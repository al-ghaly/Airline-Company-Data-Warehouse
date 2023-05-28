USE DWHPROJAIRLINECOM;
--WHICH CUSTOMERS USE OUR SERVICES MORE FREQUENTLY
SELECT TOP 20 
FNAME + ' ' + LNAME AS CUST_NAME,
count(R.Reservation_ID) AS FREQUENCY
FROM RESERVATIONS_ R, CUSTOMER C
where R.Customer_ID = C.Customer_ID
GROUP BY FNAME + ' ' + LNAME
ORDER BY FREQUENCY DESC;
---------------------------------------------------------------
--What are the most popular flight routes/Timings/airports/aircrafts
ALTER TABLE ROUTE 
ADD NAME VARCHAR(256);

UPDATE ROUTE SET 
NAME = 
SOURCECITY + ' - ' +
SRCCOUNTRY + ' => ' + DESTCITY + 
' - ' + DESTCOUNTRY;

 SELECT TOP 5 
 R.NAME AS ROUTE, COUNT(*) AS FREQUENCY
 FROM
 FLIGHT F, Bridge_Flight_ B, ROUTE R
 WHERE F.ID = B.Flight_ID
 AND R.Route_ID = B.Route_ID
 GROUP BY R.NAME
 ORDER BY FREQUENCY DESC;
 -------------------------------------------------------------
 SELECT TOP 3
 A.Model AS PLANE, COUNT(*) AS FREQUENCY
 FROM
 FLIGHT F, Bridge_Flight_ B, Aircraft A
 WHERE F.ID = B.Flight_ID
 AND A.Aircraft_Id = B.Aircraft_Id
 GROUP BY A.Model
 ORDER BY FREQUENCY DESC;
 -------------------------------------------------------------
--What are the most profitable flight routes/Timings/airports/aircrafts.
SELECT TOP 10
R.NAME AS ROUTE, SUM(PRICE_) TOTAL
FROM Reservations_, Bridge_Flight_ B , ROUTE R
WHERE Reservations_.Flight_ID = B.Flight_ID
AND B.Route_ID = R.Route_ID
GROUP BY R.NAME
ORDER BY TOTAL DESC;
--------------------------------------------------------------
SELECT TOP 10
A.NAME AS AIRPORT, SUM(PRICE_) TOTAL
FROM Reservations_, Bridge_Flight_ B , AIRPORT A
WHERE Reservations_.Flight_ID = B.Flight_ID
AND (B.SRCAirport_ID = A.Airport_ID OR
B.DestAirport_ID = A.AIRPORT_ID)
GROUP BY A.NAME
ORDER BY TOTAL DESC;
--------------------------------------------------------------
--Which customers contribute the most to our revenue.
SELECT TOP 10
FNAME + ' ' + LNAME AS CUST_NAME, SUM(PRICE_) TOTAL
FROM Reservations_ R, Customer C
WHERE R.Customer_ID = C.Customer_ID
GROUP BY FNAME + ' ' + LNAME
ORDER BY TOTAL DESC;
--------------------------------------------------------------
select count(Upgrade_ID) / (max(year) - min(year)) AS ACTION_PER_YEAR
from Marketing_Analysis MA, date D
where MA.Date_ID =D.Date_ID;
--------------------------------------------------------------
--Which customer rank (gold, platinum, titanium) are most profitable to us.
SELECT TOP 10
STATUS, SUM(PRICE_) TOTAL
FROM Reservations_ R, Customer C
WHERE R.Customer_ID = C.Customer_ID
GROUP BY STATUS
ORDER BY TOTAL DESC;
--------------------------------------------------------------
--Which booking channel-PAYMENT/FARE BASIS is most rewarding/popular.
SELECT C.Name CHANNEL, SUM(PRICE_) TOTAL
FROM Reservations_ R, Channel_ C
WHERE R.Channel_ID = C.Channel_ID
GROUP BY C.NAME
ORDER BY TOTAL DESC;

SELECT FB.Name FARE, SUM(PRICE_) TOTAL
FROM Reservations_ R, Fare_Basis_Class FB
WHERE R.FBC_ID = FB.FBC_ID
GROUP BY FB.NAME
ORDER BY TOTAL DESC;

SELECT PM.Name PAYMENT, SUM(PRICE_) TOTAL
FROM Reservations_ R, Payment_Method PM
WHERE R.PM_ID = PM.PM_ID
GROUP BY PM.NAME
ORDER BY TOTAL DESC;

SELECT C.Name CHANNEL, COUNT(*) TOTAL
FROM Reservations_ R, Channel_ C
WHERE R.Channel_ID = C.Channel_ID
GROUP BY C.NAME
ORDER BY TOTAL DESC;

SELECT FB.Name FARE, COUNT(*) TOTAL
FROM Reservations_ R, Fare_Basis_Class FB
WHERE R.FBC_ID = FB.FBC_ID
GROUP BY FB.NAME
ORDER BY TOTAL DESC;

SELECT PM.Name PAYMENT, COUNT(*) TOTAL
FROM Reservations_ R, Payment_Method PM
WHERE R.PM_ID = PM.PM_ID
GROUP BY PM.NAME
ORDER BY TOTAL DESC;
--------------------------------------------------------------
--What are the aspects that we need to improve to achieve better customer satisfaction.
SELECT TOP 1
PM.Name payment, COUNT(*) FREQ, SUM(Severity_) SEV
FROM Customer_Services CS, Payment_Method PM, ACTION A
WHERE CS.PM_ID = PM.PM_ID
AND CS.Action_ID = A.Action_ID
AND A.TYPE = 'Complaint'
GROUP BY PM.Name
ORDER BY FREQ DESC;

SELECT top 1
C.Name CHANNEL, COUNT(*) FREQ, SUM(Severity_) SEV
FROM Customer_Services CS, Channel_ C, ACTION A
WHERE CS.Channel_ID = C.Channel_ID
AND CS.Action_ID = A.Action_ID
AND A.TYPE = 'Complaint'
GROUP BY C.Name
ORDER BY FREQ DESC;

SELECT top 1
M.FName + ' ' + M.LNname + ' - ' + M.Position MEMBER,
COUNT(*) FREQ, SUM(Severity_) SEV
FROM Customer_Services CS, Crew_Member M, ACTION A
WHERE CS.Member_ID = M.Member_ID
AND CS.Action_ID = A.Action_ID
AND A.TYPE = 'Complaint'
GROUP BY M.FName + ' ' + M.LNname + ' - ' + M.Position 
ORDER BY SEV DESC;
--------------------------------------------------------------
--Which flights receive the best/worst customer feedback.
SELECT top 1 --worst
FLIGHT_ID, COUNT(*) AS COMPLAINTS
, SUM(CS.Severity_) AS SEV
FROM CUSTOMER_SERVICES CS, ACTION A
WHERE CS.ACTION_ID = A.ACTION_ID
AND A.TYPE = 'Complaint'
GROUP BY FLIGHT_ID 
ORDER BY COUNT(*) DESC;

SELECT top 1 --best
FLIGHT_ID, COUNT(*) AS FEEDBACK
, SUM(CS.Severity_) AS SEV
FROM CUSTOMER_SERVICES CS, ACTION A
WHERE CS.ACTION_ID = A.ACTION_ID
AND A.TYPE = 'Feedback'
GROUP BY FLIGHT_ID 
ORDER BY SUM(CS.Severity_) desc;
--------------------------------------------------------------
select TOP 5
M.FName + ' ' + M.LNname  MEMBER,
COUNT(*) FREQUENCY
from Flight F, Crew_Member M
where F.Captain_ID = M.Member_ID
GROUP BY M.FName + ' ' + M.LNname 
ORDER BY COUNT(*) DESC;
--------------------------------------------------------------
--What are the booking patterns of frequent flyers, and what types of fare classes do they typically book.
SELECT C.STATUS, CH.NAME CHANNEL, PM.NAME PAYMENT, 
COUNT(R.CUSTOMER_ID) FREQUENCY
FROM RESERVATIONS_ R, CUSTOMER C, PAYMENT_METHOD PM, CHANNEL_ CH
WHERE R.CUSTOMER_ID = C.CUSTOMER_ID
AND R.PM_ID = PM.PM_ID
AND R.CHANNEL_ID = CH.CHANNEL_ID
AND C.STATUS IS NOT NULL
GROUP BY C.STATUS, CH.NAME, PM.NAME
HAVING COUNT(R.CUSTOMER_ID) > 135
ORDER BY STATUS, CHANNEL, PAYMENT;

SELECT C.STATUS, FBC.Name FARE, 
COUNT(R.CUSTOMER_ID) FREQUENCY
FROM RESERVATIONS_ R, CUSTOMER C, Fare_Basis_Class FBC
WHERE R.CUSTOMER_ID = C.CUSTOMER_ID
AND R.FBC_ID = FBC.FBC_ID
AND C.STATUS IS NOT NULL
GROUP BY C.STATUS, FBC.NAME
HAVING COUNT(R.CUSTOMER_ID) > 600
ORDER BY STATUS, FARE;
--------------------------------------------------------------
--How do customer demographics, such as age or income level, impact travel behavior and preferences
--##AGE##
CREATE VIEW AGE_ AS 
(SELECT CASE
WHEN YEAR(GETDATE()) -  YEAR(CU.DOB) > 50
THEN 'Old'
WHEN YEAR(GETDATE()) -  YEAR(CU.DOB) > 30
THEN 'Grown Up'
WHEN YEAR(GETDATE()) -  YEAR(CU.DOB) > 18
THEN 'Youth'
ELSE  'Kid'
END AS AGE,
c.Name as channel,
A.Name AS AIRPORT
FROM Reservations_ R, Channel_ C , Customer CU, Bridge_Flight_ B, Airport A
WHERE R.Channel_ID = C.Channel_ID
AND R.Customer_ID = CU.Customer_ID
AND B.Flight_ID = R.Flight_ID
AND B.SRCAirport_ID = A.Airport_ID
AND CU.DOB IS NOT NULL);

SELECT AGE, Channel, COUNT(*) AS FREQUENCY
FROM AGE_
GROUP BY AGE , CHANNEL
ORDER BY AGE, CHANNEL, FREQUENCY DESC;

SELECT AGE,AIRPORT, COUNT(*) AS FREQUENCY
FROM AGE_
GROUP BY AGE , AIRPORT
HAVING COUNT(*) > 11
ORDER BY AGE, AIRPORT, FREQUENCY DESC;

--##GENDER##
SELECT C.GENDER, FB.Name FARE_BASIS,COUNT(*) FREQUENCY
FROM Reservations_ R, Customer C, Fare_Basis_Class FB
WHERE R.Customer_ID = C.Customer_ID
AND R.FBC_ID = FB.FBC_ID
GROUP BY C.Gender, FB.NAME
ORDER BY GENDER, FARE_BASIS, FREQUENCY DESC;

SELECT C.GENDER, PM.Name PAYMENT,COUNT(*) FREQUENCY
FROM Reservations_ R, Customer C, Payment_Method PM
WHERE R.Customer_ID = C.Customer_ID
AND R.PM_ID = PM.PM_ID
GROUP BY C.Gender, PM.NAME
ORDER BY GENDER, PAYMENT, FREQUENCY DESC;
--------------------------------------------------------------
