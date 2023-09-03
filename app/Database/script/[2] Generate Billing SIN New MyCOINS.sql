  --- SIN ---
  --SIN SUM sudah
insert into MP_BILLING_SUM 
SELECT 'SIN'||ID AS GROUPID,AMOUNT_ALL AS AMOUNT,'' AS FLAGID,'0' AS STATUS,'' AS AMOUNTFLAG,
        SYSDATE AS CREATED_DATE,'SYSTEM' AS CREATED_BY,'' AS UPDATE_DATE,'' AS UPDATE_BY,
        PERIODE as BULAN_TAGIH,'P' AS IDENTIFIKASI,'COINS' AS SOURCE,'' AS VIRTUAL_ACCOUNT,
        '' as PAYMENT_AMOUNT,
        '' as PAYMENT_DATE,
        '' as FLAGTREMS,
        '' as STATUSTREMS,
        '' as CL_DOC,
        '' as CL_DOC_DATE,
        '' as SELISIH,
        '' as BISNIS_SHARE,
        '' as REKON_N_TO_N,
        '' as REKON_RELASI,
        '' as CASH_NONCASH,
        '' as Z_DISKON,
        'IDR' as CURRENCY,
        ''  as PPN,
        '' as PPH,
        '' as AMOUNT_MATERAI
FROM (  SELECT s.*, NVL( s.tot,0) + NVL(a.adj,0) + NVL(re.REF,0 ) as AMOUNT_ALL   
                  FROM  (SELECT x.periode,x.accountnas, x.nama, round(x.tots+(x.tots*0.11)) as tot, x.id from (SELECT s.id_account id,
                                s.accountnas,
                                S.NAMA nama,
                                T.periode,
																NVL (SUM (tagihan), 0) AS tots
                         FROM mc_sin_account@DBL_SPHWEB s
                         LEFT OUTER JOIN mc_pengguna@DBL_SPHWEB p
                              ON S.ID_ACCOUNT = P.ID_ACCOUNT AND p.status != 0 and p.aplikasi=2 and deleted_by is null
                              JOIN mc_t_tagihan@DBL_SPHWEB t
                              ON t.notelp = p.no_telp
                              AND periode = '202306'
                    WHERE s.status != 0 
                    GROUP BY s.id_account,
                             accountnas,
                 t.periode,
                             S.NAMA) x) s
                    LEFT OUTER JOIN (  SELECT acc, SUM (total) AS adj
                                       FROM mc_t_adjustment@DBL_SPHWEB
                                       WHERE periode = '202306'
                                       GROUP BY acc) a
                    ON A.ACC = S.ACCOUNTNAS
                    LEFT OUTER JOIN (  SELECT acc, SUM (total) AS res
                                       FROM mc_t_restitusi@DBL_SPHWEB
                                       WHERE periode = '202306'
                                       GROUP BY acc) r
                    ON r.ACC = S.ACCOUNTNAS
                    LEFT OUTER JOIN (  SELECT ACCOUNTNAS, SUM (total) AS REF
                                       FROM mc_t_refund@DBL_SPHWEB
                                       WHERE periode= '202306'
                                       GROUP BY ACCOUNTNAS) re
                    ON re.ACCOUNTNAS = S.ACCOUNTNAS
                ORDER BY id)
WHERE 1 = 1  ;

COMMIT;

-- SIN BILLING  belum
INSERT INTO MP_BILLING
SELECT  t.periode AS period,
'SIN'||TRIM(s.id_account) AS groupid,
       TRIM(p.NO_TELP)AS svcno,
       MIN(t.idba ) as BISNIS_AREA_ID,
       NVL(SUM(T.tagihan),0) AS amount,
      s.NAMA,'0' AS STATUS,'IDR' AS CURRENCY,'0' as SENDTREMS,
      s.CREATED_BY,s.CREATED_date,'' AS FLAGID,'P' AS IDENFIKASI,
      'COINS' AS SOURCE,
      '' AS AMOUNTFLAG,'' AS FLAGDATE,
      '' as PAYMENT_AMOUNT,
      '' as PAYMENT_DATE,
      '' as FLAGTREMS,
      '' as STATUSTREMS,
      '' as CL_DOC,
      '' as CL_DOC_DATE,
      '1' as MATERAI,
      '0' AS DENDA,
      '' AS RCID,
      '' AS LOKET,
      '' AS RP_MATERAI,
      '' AS RP_DENDA,
      '' AS RP_CICILAN,
      '' AS CL_TYPE,
      '' AS BA_PAY,
      '' AS CL_USER,
      '' AS C_SITE,  
      '' AS BANK_NO,
      '' AS CL_HKONT,
      '' AS BANK_EXT_NO,
      '' AS PPN,
      '' AS PPH,
      t.periode as PERIOD_BILLING,
      '' AS PHISTORY,
      '' AS SVCNO_DUMMY_SEMENTARA,
      '' AS ZDISKON,
	  '' AS PAY_ID,
	  0 ASPAY_AMOUNT
FROM MC_SIN_ACCOUNT@DBL_SPHWEB s LEFT JOIN MC_PENGGUNA@DBL_SPHWEB p on s.id_ACCOUNT = p.id_account
AND p.status != 0 and p.aplikasi=2 and deleted_by is null
            LEFT JOIN MC_T_TAGIHAN@DBL_SPHWEB t on TRIM(p.NO_TELP) = TRIM (t.notelp)
      WHERE 
           t.periode='202306' 
   GROUP BY 
     'SIN'||TRIM(s.id_account),t.periode, p.NO_TELP,
      s.NAMA,s.CREATED_BY,s.CREATED_date;
     
     COMMIT;

--SIN ADJUSTMENT
INSERT INTO MP_BILLING SELECT
  *
FROM
  (
    SELECT
      T.bultag AS PERIOD,
      'SIN' || UPPER (TRIM(s.ID_account)) AS groupid,
      UPPER (TRIM(T.NOTELP)) AS svcno,
      '' AS BISNIS_AREA_ID,
      T.total AS amount,
      s.NAMA,
      '0' AS STATUS,
      'IDR' AS CURRENCY,
      '0' AS SENDTREMS,
      s.CREATED_BY,
      s.CREATED_DATE,
      '' AS FLAGID,
      'P' AS IDENFIKASI,
      'COINS' AS SOURCE,
      '' AS AMOUNTFLAG,
      '' AS FLAGDATE,
      '' AS PAYMENT_AMOUNT,
      '' AS PAYMENT_DATE,
      '' AS FLAGTREMS,
      '' AS STATUSTREMS,
      '' AS CL_DOC,
      '' AS CL_DOC_DATE,
      '1' AS MATERAI,
      '0' AS DENDA,
      '' AS RCID,
      '' AS LOKET,
      '' AS RP_MATERAI,
      '' AS RP_DENDA,
      '' AS RP_CICILAN,
      '' AS CL_TYPE,
      '' AS BA_PAY,
      '' AS CL_USER,
      '' AS C_SITE,
      '' AS BANK_NO,
      '' AS CL_HKONT,
      '' AS BANK_EXT_NO,
      '' AS PPN,
      '' AS PPH,
      T.periode AS PERIOD_BILLING,
      '' AS PHISTORY,
      '' AS SVCNO_DUMMY_SEMENTARA,
      '' AS ZDISKON,
	  '' AS PAY_ID,
	  0 ASPAY_AMOUNT
    FROM
      MC_SIN_ACCOUNT@DBL_SPHWEB s,
      MC_T_ADJUSTMENT@DBL_SPHWEB T
    WHERE
      T.acc = s.accountnas
    AND T.bultag = '202306'
  ) p
WHERE
   NOT EXISTS (
    SELECT
      *
    FROM
      MP_BILLING A
    WHERE
      A.GROUPID = p.groupid
    AND A.period = p.period
    AND A.PERIOD_BILLING = p.period_billing);
   
   COMMIT;

--SIN ADJUSTMENT P_HISTORY
MERGE INTO MP_BILLING tmp
USING ( 
           SELECT  t.periode AS period,t.bultag,
          'SIN'||UPPER(TRIM(s.id_account)) AS groupid,
       UPPER (TRIM (p.NO_TELP)) AS svcno,
       NVL(SUM(T.total),0) AS amount
        FROM mc_sin_account@DBL_SPHWEB s,
                  MC_PENGGUNA@DBL_SPHWEB p,
                  mc_t_adjustment@DBL_SPHWEB t
        WHERE UPPER (TRIM (p.NO_TELP)) = UPPER (TRIM (t.NOTELP)) 
               AND UPPER (TRIM (s.id_account)) = UPPER (TRIM (p.id_account)) 
							 and p.aplikasi=2 and deleted_by is null
               AND t.bultag='202306' 
      GROUP BY t.periode,t.bultag,'SIN'||UPPER(TRIM(s.id_account)),
       UPPER (TRIM (p.NO_TELP))
      HAVING COUNT(*) >1 
    
)c
ON (tmp.SVCNO=c.svcno AND tmp.GROUPID=c.groupid and tmp.period=c.bultag and tmp.amount=c.amount)
WHEN MATCHED THEN 
UPDATE SET 
  tmp.PHISTORY='H';
	
	commit;