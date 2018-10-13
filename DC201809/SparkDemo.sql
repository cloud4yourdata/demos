---------------------
USE DCDbSpark
--------------------
SELECT * FROM DevicesDataExternal WHERE DEVICEID =10 ORDER BY READINGDATETIME DESC LIMIT 100
------------------
----REFRESH TABLE DevicesData
SELECT DEVICEID,DATE_FORMAT(READINGDATETIME,'yyyyMM'), AVG(VALUE) AVGVALUE, MIN(VALUE) MINVALUE, MAX(VALUE),STDDEV(VALUE) 
FROM DevicesData 
GROUP BY DEVICEID,DATE_FORMAT(READINGDATETIME,'yyyyMM')  
ORDER BY DEVICEID,DATE_FORMAT(READINGDATETIME,'yyyyMM')