--delete from PDF_DETAIL_INVOICE WHERE PERIODE <202301;
--
--COMMIT;
--truncate table PDF_DETAIL_INVOICE;

--CREATE TABLE BKP_PDF_DETAIL_INVOICE_202305 AS SELECT * FROM PDF_DETAIL_INVOICE-- WHERE PERIODE <202301

--select count(*) from TMP_PERIOD_PROCESS;

SELECT count(DISTINCT(satker_id)) FROM PDF_DETAIL_INVOICE;

SELECT KODE_SATKER 
from MP_SATKER_GENERATE

SELECT count(*) FROM MP_TTE_SATKER mts 

--CREATE TABLE PDF_DETAIL_INVOICE_APRIL AS SELECT * FROM PDF_DETAIL_INVOICE WHERE 1=0;

INSERT INTO PDF_DETAIL_INVOICE 
select x.nomor,  x.NO_KWIT, x.NO_TELP,x.NO_PLG,x.NAMA_PENGGUNA,x.PERIOD PERIODE, x.ABONEMEN FIELD_1,
        x.SELULER FIELD_2, x.LOKAL FIELD_3, x.sljj FIELD_4, x.interlokal FIELD_5, x.SLI FIELD_6, x.LAIN_LAIN FIELD_7,
        x.JASNITA FIELD_8, x.TKNET FIELD_9, x.tagihan_netto FIELD_10, x.PPN FIELD_11, 0 FIELD_12, x.tagihan_bruto FIELD_13,
        0 FIELD_14, 0 FIELD_15, 0 FIELD_16, 0 FIELD_17, 0 FIELD_18, 0 FIELD_19, 0 FIELD_20,
        'ISI' TANDA, 'Times,,8' FONTNYA, '' TGL_CREATE, x.SATKER_ID, x.NAMA_SATKER                                 
        from 
        (
        SELECT 0 nomor,  d.NO_KWIT, /*c.NO_TELP*/ a.SVCNO NO_TELP,c.NO_PLG,c.NAMA_PENGGUNA NAMA_PENGGUNA,a.PERIOD,  
                d.ABONEMEN, /*0*/ d.LOKAL_SELULAR seluler, d.lokal, d.sljj, d.interlokal, (d.sli007+d.sli001+d.sli008) as SLI, 
                (d.discount+d.stb+d.tglobal+d.japati+d.isdn_data+d.isdn_voice+d.lokalmeter+d.flexi+d.hsma+d.smsk+d.pdn+d.dvoip+d.smsp+d.tlgop+d.voip+d.credit+d.debit+d.deposit+d.restitusi+d.cicilan+d.penalti+d.tsave+d.intagjastel) as LAIN_LAIN,
                (d.qin+d.airtime) as JASNITA, d.tknet, d.tagih tagihan_netto, d.ppn, /*d.meterai*/ 0 meterai, d.tagihtot as tagihan_bruto, d.NO_KWIT as NO_BILLING, f.KODE_SATKER SATKER_ID,f.NAMA_SATKER                
                from mp_billing a 
                left join (SELECT NO_TELP, NO_PLG, NAMA_PENGGUNA, ID_SATKER FROM MC_PENGGUNA@DBL_SPHWEB WHERE APLIKASI=4 AND DELETED_BY IS NULL) c
                on a.svcno=c.no_telp 
                left join T_TAGIHAN_ETL2@DBL_SPHWEB d on a.svcno=d.nd and substr(a.period,4,1)=d.tahun and ltrim(substr(a.period,5,2),'0')=d.bulan
                                left join MP_CUSTOMER_SPM e on (a.SVCNO= e.NO_TELEPON and  a.PERIOD=e.PERIOD)
                JOIN MP_CUSTOMER_SSC f ON (a.svcno=f.svcno and f.status=1)
                --where f.KODE_SATKER=?
								and								(a.PAY_AMOUNT=0) --BELUM BAYAR SAJA
                and (
                                    case when a.period<202306 and nvl(d.tagihtot,0)=0 then 0
                                    else 1
                          end )=1
                --and NVL2(b.PAYMENT_ID, 'BAYAR',NVL2(e.ID_BATCH,'PROSES BAYAR', 'BELUM BAYAR')) in ('BELUM BAYAR','PROSES BAYAR')
        ) x
        GROUP BY
        x.NO_KWIT, x.NO_TELP, x.NO_PLG,x.NAMA_PENGGUNA, x.PERIOD,  
                x.ABONEMEN, x.seluler, x.lokal, x.sljj, x.interlokal, x.SLI, 
                x.LAIN_LAIN,x.JASNITA, x.tknet, x.tagihan_netto, x.ppn, x.meterai, x.tagihan_bruto,x.NO_BILLING,
                                        x.SATKER_ID,x.NAMA_SATKER
        ORDER BY x.NAMA_PENGGUNA ASC, x.PERIOD ASC;
				
	commit;

--SELECT * FROM mp_customer_ssc WHERE SVCNO ='03712629123'--KODE_SATKER ='411404';
--
--SELECT * FROM MC_PENGGUNA@DBL_SPHWEB WHERE NO_TELP ='172606210369'
--
--SELECT * FROM T_TAGIHAN_ETL2@DBL_SPHWEB WHERE nd='0217520532';
--
--SELECT * FROM trems.trems_payment@dbl_billdet WHERE telp='0213452670' AND nper='202110';
--
-- select SUM(a.PAYMENT_AMOUNT) PAYMENT_AMOUNT, MAX(a.PAYMENT_DATE) PAYMENT_DATE, MAX(a.CL_ID) CL_ID, MAX(a.JENIS) JENIS, 
--     a.NPER, a.TELP, a.C_LOKET, sum(a.METERAI) METERAI, sum(a.DENDA) DENDA, a.PAYMENT_TYPE, a.BA_PAY, a.CL_USER, a.CURRENCY
--		 from  MP_BILLING x
--     JOIN trems.trems_payment@dbl_billdet a ON(a.TELP=x.SVCNO AND a.NPER=x.PERIOD)
--		 WHERE telp='0213513991' AND nper='202204'
--     GROUP BY a.NPER, a.TELP, a.C_LOKET, a.PAYMENT_TYPE, a.BA_PAY, a.CL_USER, a.CURRENCY
--	  
--	  SELECT * FROM PDF_DETAIL_INVOICE