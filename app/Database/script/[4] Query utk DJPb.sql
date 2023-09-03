--1. running query billing punya djpb bulan kebelakang
--SELECT count(*) FROM MP_BILLING WHERE period='202306';
--
--SELECT count(*) FROM MP_BILLING_SUM WHERE period='202306';

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
            JOIN MP_CUSTOMER_SSC u on (u.SVCNO=TRIM (p.no_telp) and u.status=1)
						WHERE 
						t.period>'201601' and t.period<'202306'--minimal period billing yang masuk
						and TO_CHAR(u.VALID_FROM, 'YYYYMM') in ('202305','202306') 
						and s.NAMA_SATKER is not null and p.no_telp is not null
            GROUP BY 'SPH'||TRIM (s.satker_id),t.PERIOD,
              TRIM(p.no_telp),s.NAMA_SATKER,s.UPDATED_DATE
)A WHERE NOT EXISTS (SELECT B.GROUPID,B.PERIOD,B.SVCNO FROM MP_BILLING B WHERE A.PERIOD=B.PERIOD AND A.SVCNO=B.SVCNO);

COMMIT;

-- 2.0 INSERT KE TABLE TMP_PERIOD_PROCESS
--select count(*) from TMP_PERIOD_PROCESS;

TRUNCATE TABLE TMP_PERIOD_PROCESS;

INSERT INTO TMP_PERIOD_PROCESS select distinct(period) from (
					select * from 
					(
					SELECT  /*c.NO_TELP*/ a.SVCNO NO_TELP, NVL(C.ID_SATKER,'Sedang Proses') AS ID_PELANGGAN, NVL(C.NAMA_PENGGUNA,'Sedang Proses') AS NAMA_PELANGGAN, NVL2(a.PAY_ID, 'BAYAR',NVL2(e.ID_BATCH,'PROSES BAYAR', 'BELUM BAYAR')) STATUS_TAGIHAN,
									a.PERIOD, a.PAY_ID AS NO_KWITANSI, 
									d.ABONEMEN, /*0*/ d.LOKAL_SELULAR seluler, d.lokal, d.sljj, d.interlokal, (d.sli007+d.sli001+d.sli008) as SLI, 
									(d.discount+d.stb+d.tglobal+d.japati+d.isdn_data+d.isdn_voice+d.lokalmeter+d.flexi+d.hsma+d.smsk+d.pdn+d.dvoip+d.smsp+d.tlgop+d.voip+d.credit+d.debit+d.deposit+d.restitusi+d.cicilan+d.penalti+d.tsave+d.intagjastel) as LAIN_LAIN,
									(d.qin+d.airtime) as JASNITA, d.tknet, d.tagih tagihan_netto, d.ppn, /*d.meterai*/ 0 meterai, d.tagihtot as tagihan_bruto, d.NO_KWIT as NO_BILLING,
									TO_CHAR(d.LASTUPDATE,'dd-mm-yyyy') tanggal_billing,
																	(select g.NIK from v_sph_satker_ttd_valid@DBL_SPHWEB g where 'SPH'||g.SATKER_ID=a.GROUPID and rownum=1) NIK_PEJABAT,(select g.NAMA from v_sph_satker_ttd_valid@DBL_SPHWEB g where 'SPH'||g.SATKER_ID=a.GROUPID and rownum=1) NAMA_PEJABAT
									from mp_billing a 
									left join (SELECT NO_TELP, NO_PLG, NAMA_PENGGUNA, ID_SATKER FROM MC_PENGGUNA@DBL_SPHWEB WHERE APLIKASI=4 AND DELETED_BY IS NULL) c
									on a.svcno=c.no_telp 
									left join T_TAGIHAN_ETL2@DBL_SPHWEB d on a.svcno=d.nd and substr(a.period,4,1)=d.tahun and ltrim(substr(a.period,5,2),'0')=d.bulan
													left join MP_CUSTOMER_SPM e on (a.SVCNO= e.NO_TELEPON and  a.PERIOD=e.PERIOD)
									JOIN MP_CUSTOMER_SSC f ON (a.svcno=f.svcno and f.status=1)
									where 
									(a.PAY_AMOUNT=0) --BELUM BAYAR
									and d.tagihtot>0
					) x
					GROUP BY
					x.NO_TELP, x.ID_PELANGGAN, x.NAMA_PELANGGAN, x.STATUS_TAGIHAN,x.PERIOD, x.NO_KWITANSI, 
									x.ABONEMEN, x.seluler, x.lokal, x.sljj, x.interlokal, x.SLI, 
									x.LAIN_LAIN,x.JASNITA, x.tknet, x.tagihan_netto, x.ppn, /*x.meterai*/ x.meterai, x.tagihan_bruto,x.NO_BILLING,x.TANGGAL_BILLING,
																	x.NIK_PEJABAT, x.NAMA_PEJABAT
				);
			
			COMMIT;

--2. insert query mp_tel75 punya djpb bulan kebelakang (ada versi terbaru lebih cepet, di poin 2.1)
--	INSERT INTO MP_TEL75  ( 
--			select 
--			a.payment_id, 
--			case when (substr(a.payment_id,4,4)=substr(a.cl_doc_date,3,4)) then 'GG' else 'CD' end type, 
--			a.cl_type, 
--			a.idba ba_bill, 
--			a.ba_pay, 
--			a.loket, 
--			a.svcno acc_num, 
--			--b.custname nama_pelanggan, 
--			''  nama_pelanggan, 
--			a.nper period, 
--			substr(a.gl_bank,3) gl_account,
--			a.cl_post_date payment_date,
--			a.cl_doc_date,
--			substr(a.cl_doc_date,1,6) cl_period,
--			a.cl_curr currency,
--			a.cl_status,
--			c.group_produk produk, 
--			a.cl_user,  
--			a.cl_doc,
--			a.bill_amount,
--			a.dc_bank bank,
--			a.denda,
--			a.meterai materai,
--			a.pot_pph, 
--			(a.pot_ppn_wapu+a.pot_ppn) pot_ppn, 
--			a.pot_others,
--			a.total_flagging payment_amount, 
--			a.st_status,
--			a.st_doc,
--			a.st_post_date,
--			a.st_period,
--			a.st_user,
--			a.cpudt,
--			a.cputm
--			from trems.trems_cash_detail@dbl_billdet a,
--			--mp_customer b,
--			trems.p_produk@dbl_billdet c,
--			--mp_billing d,
--			mp_customer_ssc e,
--			mp_billing f
--			where 
--			a.nper
--			in (
--				SELECT period FROM TMP_PERIOD_PROCESS
--			)
--			AND a.idprod=c.idprod
--			and a.svcno=e.svcno(+)
--			and a.svcno=f.svcno(+)
--			and a.nper=f.period(+)			
--			and e.status=1
--			and NOT EXISTS 
--			(
--				SELECT x.PAYMENT_ID FROM MP_TEL75 x
--					where 
--					x.PAYMENT_ID=a.payment_id 
--					AND x.ACC_NUM =a.svcno
--					AND x.PERIOD =a.nper
--					AND x.CL_DOC = a.cl_doc
--					AND x.CPUDT = a.cpudt
--			)
--			--and rownum<100
--			);
				
--2.1 versi baru INSERT ke tel 75 lebih cepat tapi masih ke trems cash detail
--INSERT INTO MP_TEL75  ( 
--	select 
--	a.payment_id, 
--	case when (substr(a.payment_id,4,4)=substr(a.cl_doc_date,3,4)) then 'GG' else 'CD' end type, 
--	a.cl_type, 
--	a.idba ba_bill, 
--	a.ba_pay, 
--	a.loket, 
--	a.svcno acc_num, 
--	--b.custname nama_pelanggan, 
--	''  nama_pelanggan, 
--	a.nper period, 
--	substr(a.gl_bank,3) gl_account,
--	a.cl_post_date payment_date,
--	a.cl_doc_date,
--	substr(a.cl_doc_date,1,6) cl_period,
--	a.cl_curr currency,
--	a.cl_status,
--	'POTS' produk, 
--	a.cl_user,  
--	a.cl_doc,
--	a.bill_amount,
--	a.dc_bank bank,
--	a.denda,
--	a.meterai materai,
--	a.pot_pph, 
--	(a.pot_ppn_wapu+a.pot_ppn) pot_ppn, 
--	a.pot_others,
--	a.total_flagging payment_amount, 
--	a.st_status,
--	a.st_doc,
--	a.st_post_date,
--	a.st_period,
--	a.st_user,
--	a.cpudt,
--	a.cputm
--	from trems.trems_cash_detail@dbl_billdet a,  -- sebaiknya diganti ke trems_payment (amountnya di-sum)
--	mp_customer_ssc e
--	where 
--	a.nper
--	in (
--		SELECT period FROM TMP_PERIOD_PROCESS
--	)
--	and a.svcno=e.svcno(+)		
--	and e.status=1
--	and NOT EXISTS 
--	(
--		SELECT x.PAYMENT_ID FROM MP_TEL75 x
--			where 
--			x.PAYMENT_ID=a.payment_id 
--			AND x.ACC_NUM =a.svcno
--			AND x.PERIOD =a.nper
--			AND x.CL_DOC = a.cl_doc
--			AND x.CPUDT = a.cpudt
--	)
--	);

--2.2 Versi lebih baru lagi ambil dari trems-payment
INSERT INTO MP_TEL75  ( 
	select 
	a.cl_id payment_id, 
	case when (substr(a.cl_id,4,4)=substr(a.PAYMENT_DATE,3,4)) then 'GG' else 'CD' end type, 
	a.payment_type cl_type, 
	a.idba ba_bill, 
	a.ba_pay, 
	a.L_BANK loket, 
	a.telp acc_num, 
	--b.custname nama_pelanggan, 
	''  nama_pelanggan, 
	a.nper period, 
	substr(a.CL_HKONT,3) gl_account,
	a.PAYMENT_DATE payment_date,
	a.cpudt,
	substr(a.cpudt,1,6) cl_period,
	a.CURRENCY currency,
	case when (a.jenis='BAYAR') then 'CL' else 'ST' end type,
	'POTS' produk, 
	a.cl_user,  
	a.DOC_NUMBER,
	a.BILLING_AMOUNT,
	a.BILLING_AMOUNT bank,
	a.denda,
	a.meterai materai,
	0 pot_pph, 
	0 pot_ppn, 
	0 pot_others,
	a.payment_amount payment_amount, 
	'-' st_status,
	null st_doc,
	'99991231' st_post_date,
	'999912' st_period,
	'-' st_user,
	a.cpudt,
	a.UPDATE_TIME
	from trems.trems_payment@dbl_billdet a,  -- sebaiknya diganti ke trems_payment (amountnya di-sum)
	mp_customer_ssc e
	where 
	a.nper
	in (
				SELECT period FROM TMP_PERIOD_PROCESS
	)
	and a.telp=e.svcno(+)		
	and e.status=1
	and NOT EXISTS 
	(
		SELECT x.PAYMENT_ID FROM MP_TEL75 x
			where 
			x.PAYMENT_ID=a.cl_id 
			AND x.ACC_NUM =a.telp
			AND x.PERIOD =a.nper
			AND x.CL_DOC = a.DOC_NUMBER
			AND x.CPUDT = a.cpudt
	)
	);

COMMIT;
			
--3. merge pay amount ke mp_billing
MERGE INTO MP_BILLING a
USING (
	SELECT b.ACC_NUM, b.PERIOD, MAX(b.PAYMENT_ID) PAYMENT_ID, SUM(b.BILL_AMOUNT)  PAYMENT_AMOUNT
	FROM MP_TEL75 b
	where b.PERIOD
	in 
	(
		SELECT PERIOD FROM TMP_PERIOD_PROCESS
	)
	GROUP BY b.ACC_NUM, b.PERIOD
) temp
ON (a.SVCNO =temp.ACC_NUM AND a.PERIOD=temp.PERIOD)
   WHEN MATCHED THEN UPDATE 
	 SET a.PAY_ID = case when temp.PAYMENT_AMOUNT=0 then '' else temp.PAYMENT_ID end,
			 a.PAY_AMOUNT=temp.PAYMENT_AMOUNT;

			
--UPDATE MP_BILLING t1
--   SET (t1.PAY_ID, t1.PAY_AMOUNT) = (SELECT case when t2.PAYMENT_AMOUNT=0 then '' else t2.PAYMENT_ID end, t2.PAYMENT_AMOUNT
--                         FROM MP_TEL75 t2
--                        WHERE t2.period='202206' --IN (SELECT PERIOD FROM TMP_PERIOD_PROCESS)
--                        AND t1.SVCNO  = t2.ACC_NUM AND t1.PERIOD=t2.PERIOD AND t1.PAY_AMOUNT=0 
--                        AND t1.svcno IN (SELECT svcno FROM mp_customer_ssc WHERE status=1))
-- WHERE EXISTS (
--    SELECT 1
--      FROM MP_TEL75 t2
--     WHERE t1.SVCNO  = t2.ACC_NUM AND t1.PERIOD=t2.PERIOD AND t1.PAY_AMOUNT=0) 
--    AND t1.svcno IN (SELECT svcno FROM mp_customer_ssc WHERE status=1) );
    
    
commit;