SELECT count(*) FROM MP_BILLING WHERE period='202306';
--
SELECT count(*) FROM MP_BILLING_SUM WHERE period='202306';

insert into MP_BILLING_SUM (GROUPID,AMOUNT, STATUS, CREATED_DATE, CREATED_BY,PERIOD, IDENTIFIKASI, SOURCE, CURRENCY )
select * from
(
	SELECT 'SPH'||UPPER(TRIM(s.satker_id)) AS GROUPID,
         NVL(SUM(t.tagihtot),0) AS AMOUNT,
              '0' AS STATUS,
              SYSDATE AS CREATED_DATE,
              'SYSTEM' AS CREATED_BY,
              t.PERIOD,
              'P' AS IDENTIFIKASI,
              'COINS' AS SOURCE,
              'IDR' AS CURRENCY	
       FROM MC_SPH_SATKER@DBL_SPHWEB  s,
            MC_PENGGUNA@DBL_SPHWEB  p,
            T_TAGIHAN_ETL2@DBL_SPHWEB  t											
			WHERE UPPER (TRIM (s.satker_id)) = UPPER (TRIM (p.id_satker))
            AND p.no_telp = t.nd
            AND SUBSTR (s.satker_id,1,1) = '0'
            AND TRIM (p.no_telp) IS NOT NULL and t.period='202306' 
   GROUP BY  'SPH' || UPPER (TRIM (s.satker_id)), t.PERIOD
 ) A WHERE NOT EXISTS (SELECT B.GROUPID,B.PERIOD FROM MP_BILLING_SUM B WHERE A.PERIOD=B.PERIOD AND A.GROUPID=B.GROUPID );
 
--SPH BILLING (fix)
INSERT INTO MP_BILLING (PERIOD, GROUPID, SVCNO,BUSINESS_AREA_ID, AMOUNT, NAMA, STATUS, CURRENCY, SENDTREMS, CREATED_DATE, IDENTIFIKASI, SOURCE, MATERAI, DENDA, PERIOD_BILLING,PAY_AMOUNT)
SELECT * FROM
(
            SELECT t.PERIOD,
              'SPH'||TRIM (s.satker_id) AS GROUPID,
              TRIM (p.no_telp) AS svcno,
              '-' as BISNIS_AREA_ID,    
              NVL(SUM(T.TAGIHTOT),0) AS amount,
              s.NAMA_SATKER,
              '0'AS STATUS,
							'IDR' AS CURRENCY,
              '0' as SENDTREMS,
							s.UPDATED_DATE LASTUPDATE,
							'P' AS IDENFIKASI,
              'COINS' AS SOURCE,
              '1' as MATERAI,
              '0' AS DENDA,
                t.PERIOD  AS PERIOD_BILLING,
				0 PAY_AMOUNT
			FROM   T_TAGIHAN_ETL2@DBL_SPHWEB t 
			left join mc_pengguna@DBL_SPHWEB p on( p.no_telp=t.nd and p.DELETED_BY is null)			
            LEFT JOIN  mc_sph_satker@DBL_SPHWEB s on s.satker_id = p.id_satker
            WHERE t.PERIOD='202306' and s.NAMA_SATKER is not null and p.no_telp is not null
            GROUP BY 'SPH'||TRIM (s.satker_id),t.PERIOD,
              TRIM(p.no_telp),s.NAMA_SATKER,s.UPDATED_DATE
)A WHERE NOT EXISTS (SELECT B.GROUPID,B.PERIOD,B.SVCNO FROM MP_BILLING B WHERE A.PERIOD=B.PERIOD AND A.SVCNO=B.SVCNO);

-- NONPOTS SUM (fix)

INSERT INTO MP_BILLING_SUM 
(GROUPID, PERIOD, AMOUNT, CREATED_DATE, CREATED_BY, IDENTIFIKASI, SOURCE, CURRENCY, STATUS)
SELECT  ACCOUNT_NUM, PERIOD, TOTAL, SYSDATE, 'SYSTEM', 'N', 'IDEAS', CURRENCY, 0
FROM EBS_HEADER_NON_POTS@dbl_evergreen WHERE PERIOD='202306' 
GROUP BY  ACCOUNT_NUM, PERIOD, TOTAL, SYSDATE, 'SYSTEM', 'N', 'IDEAS', CURRENCY, 0;

-- NONPOTS BILLING (fix)
INSERT INTO MP_BILLING (
  GROUPID,
  SVCNO,
  PERIOD,
  PERIOD_BILLING,
  BUSINESS_AREA_ID,
  AMOUNT,
  CREATED_DATE,
  CREATED_BY,
  IDENTIFIKASI,
  SOURCE,
  MATERAI,
  DENDA,
  CURRENCY,
  STATUS,
  PAY_AMOUNT
) SELECT
  ACCOUNT_NUM,
  ACCOUNT_NUM,
  PERIOD,
  PERIOD,
  BA,
  TOTAL,
  SYSDATE,
  'SYSTEM',
  'N',
  'IDEAS',
  1,
  0,
  CURRENCY,
  0, 
  0
FROM
  EBS_HEADER_NON_POTS@dbl_evergreen
WHERE
  PERIOD = '202306' GROUP BY
ACCOUNT_NUM,
  ACCOUNT_NUM,
  PERIOD,
  PERIOD,
  BA,
  TOTAL,
  SYSDATE,
  'SYSTEM',
  'N',
  'IDEAS',
  1,
  0,
  CURRENCY,
  0;

commit;