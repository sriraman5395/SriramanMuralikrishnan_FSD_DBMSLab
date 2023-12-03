 select * from `order` ;
 select * from customer;


SELECT * FROM `order` AS o
INNER JOIN customer AS c
ON c.CUS_ID=o.CUS_ID;


SELECT o.*  FROM `order` AS o
INNER JOIN customer AS c
ON c.CUS_ID=o.CUS_ID ;


SELECT o.* , c.CUS_NAME,c.CUS_GENDER FROM `order` AS o
INNER JOIN customer AS c
ON c.CUS_ID=o.CUS_ID HAVING o.ORD_AMOUNT>=3000;

SELECT COUNT(T2.CUS_GENDER) AS No_Of_Customer,T2.CUS_GENDER AS Gender FROM
(
	SELECT T1.CUS_ID,T1.CUS_GENDER,T1.ORD_AMOUNT,T1.CUS_NAME FROM
	(
		SELECT o.* , c.CUS_NAME,c.CUS_GENDER FROM `order` AS o
		INNER JOIN customer AS c
		ON c.CUS_ID=o.CUS_ID HAVING o.ORD_AMOUNT>=3000
	) AS T1
) AS T2 GROUP BY T2.CUS_GENDER;
#________________________________________________________________________________________________________________

#________________________________________________________________________________________________________________
