-- perbaikan sementara tagihan 2018

select a.* from mp_billing a,(SELECT no_plg,no_telp,periode,field_13 FROM PDF_DETAIL_INVOICE_APRIL where periode<202301) b 
where a.svcno=b.no_telp and a.period=b.periode;

SELECT * FROM  mp_billing -- WHERE pay_id='xyz';

CREATE TABLE PDF_DETAIL_INVOICE_MEI2023 AS SELECT * FROM PDF_DETAIL_INVOICE pdi

SELECT svcno,count(*) 
FROM mp_billing a, PDF_DETAIL_INVOICE b WHERE a.SVCNO =b.NO_TELP AND a.PERIOD =b.PERIODE 
GROUP BY svcno,PERIOD HAVING count(*)>1;

SELECT PERIOD,count(*) FROM MP_BILLING mb WHERE SVCNO ='05618176463' GROUP BY period HAVING count(*)>1;

SELECT * FROM mp_billing WHERE SVCNO ='05618176463' AND PERIOD ='201904'

SELECT NO_TELP,periode, count(*) FROM PDF_DETAIL_INVOICE GROUP BY NO_TELP , PERIODE 
HAVING count(*)>1

SELECT * FROM PDF_DETAIL_INVOICE pdi WHERE NO_TELP ='05618176463' --AND NO_KWIT ='904A00200002'
AND PERIODE ='201904'

447979
2220

0315614722
0218900299
0217753482
05618176463
05262027207
02144853751

UPDATE mp_billing a
   SET (pay_id) = (SELECT 'xyz'
                         FROM (SELECT no_plg,no_telp,periode,field_13 FROM PDF_DETAIL_INVOICE where periode<202301) b 
                        WHERE a.svcno=b.no_telp and a.period=b.periode)
 WHERE EXISTS (
    SELECT 1
      FROM (SELECT no_plg,no_telp,periode,field_13 FROM PDF_DETAIL_INVOICE where periode<202301) b 
     WHERE a.svcno=b.no_telp and a.period=b.periode );
    
--    versi MERGE
MERGE INTO MP_BILLING t1
USING
(
SELECT DISTINCT no_telp,periode FROM PDF_DETAIL_INVOICE WHERE periode<202301
)t2
ON(t1.SVCNO  = t2.NO_TELP AND t1.PERIOD=t2.PERIODE)
WHEN MATCHED THEN UPDATE SET
t1.pay_id = 'xyz';
     
delete FROM  mp_billing WHERE pay_id='xyz';

COMMIT;