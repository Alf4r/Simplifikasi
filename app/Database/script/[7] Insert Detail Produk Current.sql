CREATE table PDF_DETAIL_PRODUK_CUR_202306 as SELECT * from PDF_DETAIL_PRODUK_CURRENT;
--
--truncate table PDF_DETAIL_PRODUK_CURRENT;
--
--SELECT  * FROM PDF_DETAIL_PRODUK_CURRENT pdpc  WHERE PERIOD <202301;
--
SELECT count(*) FROM PDF_DETAIL_PRODUK_CURRENT --WHERE PERIOD <202301;

SELECT sum(tagihan_bruto) FROM PDF_DETAIL_PRODUK_CURRENT WHERE satker_id ='119091';



SELECT sum(field_13) FROM PDF_DETAIL_INVOICE pdi WHERE SATKER_ID ='119091' --AND periode<>'202306';

82577205

MP_SATKER_GENERATE

MP_TTE_SATKER

--update mp_billing SET pay_amount=payment_amount WHERE svcno IN (
--'121202232057',
--'121292233682',
--'02127096730',
--'02127933245',
--'122202212364',
--'121202210515',
--'02127096730',
--'121202210515') AND payment_date='20230608'

SELECT sum(tagihan_bruto) FROM PDF_DETAIL_PRODUK_CURRENT where satker_id='119091' AND period='202306';

INSERT INTO PDF_DETAIL_PRODUK_CURRENT 
SELECT
	y.SATKER_ID,
	SUM(y.ABONEMEN) ABONEMEN,
	SUM(y.seluler) SELULER,
	SUM(y.lokal) LOKAL,
	sum(y.sljj) sljj,
	sum(y.interlokal) interlokal,
	sum(y.SLI) SLI,
	SUM(y.LAIN_LAIN) LAIN_LAIN,
	sum(y.JASNITA) JASNITA,
	SUM(y.tknet) TKNET,
	SUM(y.tagihan_netto) TAGIHAN_NETTO,
	SUM(y.tagihan_bruto) TAGIHAN_BRUTO,
	SUM(y.ppn) PPN,
	SUM(y.meterai) METERAI,
	y.PERIOD 
FROM
	(
	SELECT
		x.*
	FROM
		(
		SELECT
			/*c.NO_TELP*/
			a.SVCNO NO_TELP,
			a.PERIOD,
			d.ABONEMEN,
			/*0*/
			d.LOKAL_SELULAR seluler,
			d.lokal,
			d.sljj,
			d.interlokal,
			(d.sli007 + d.sli001 + d.sli008) AS SLI,
			(d.discount + d.stb + d.tglobal + d.japati + d.isdn_data + d.isdn_voice + d.lokalmeter + d.flexi + d.hsma + d.smsk + d.pdn + d.dvoip + d.smsp + d.tlgop + d.voip + d.credit + d.debit + d.deposit + d.restitusi + d.cicilan + d.penalti + d.tsave + d.intagjastel) AS LAIN_LAIN,
			(d.qin + d.airtime) AS JASNITA,
			d.tknet,
			d.tagih tagihan_netto,
			d.ppn,
			/*d.meterai*/
			0 meterai,
			d.tagihtot AS tagihan_bruto,
			d.NO_KWIT AS NO_BILLING,
			f.KODE_SATKER SATKER_ID
		FROM
			mp_billing a
		JOIN MP_CUSTOMER_SSC f ON
			(a.svcno = f.svcno
				AND f.status = 1)
		LEFT JOIN T_TAGIHAN_ETL2@DBL_SPHWEB d ON
			a.svcno = d.nd
			AND substr(a.period, 4, 1)= d.tahun
			AND ltrim(substr(a.period, 5, 2), '0')= d.bulan
		WHERE
		f.KODE_SATKER IN (SELECT kode_SATKER FROM MP_SATKER_GENERATE WHERE STATUS=1) AND
			a.PERIOD >= '202301'
			AND (a.PAY_AMOUNT = 0)
        ) x
	GROUP BY
		x.NO_TELP,
		x.PERIOD,
		x.ABONEMEN,
		x.seluler,
		x.lokal,
		x.sljj,
		x.interlokal,
		x.SLI,
		x.LAIN_LAIN,
		x.JASNITA,
		x.tknet,
		x.tagihan_netto,
		x.ppn,
		x.meterai,
		x.tagihan_bruto,
		x.NO_BILLING,
		x.SATKER_ID
        ) y
GROUP BY
	y.SATKER_ID, y.PERIOD;

--SELECT count(DISTINCT(SATKER_ID)) FROM PDF_DETAIL_PRODUK_CURRENT;
	
	commit;