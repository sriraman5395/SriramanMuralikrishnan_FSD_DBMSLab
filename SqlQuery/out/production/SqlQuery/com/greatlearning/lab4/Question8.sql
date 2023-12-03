select * from `order`;


SELECT * FROM `ORDER` AS O
inner join
supplier_pricing as sp on sp.PRICING_ID=o.pricing_id;


SELECT o.*, sp.PRO_ID FROM `ORDER` AS O
inner join
supplier_pricing as sp on sp.PRICING_ID=o.pricing_id and O.ord_date>"2021-10-05";





select * from product as p
inner join
(
	SELECT o.*, sp.PRO_ID FROM `ORDER` AS O
	inner join
	supplier_pricing as sp on sp.PRICING_ID=o.pricing_id
) as q
on p.PRO_ID = q.PRO_ID;



select p.PRO_ID,p.PRO_NAME from product as p
inner join
(
	SELECT o.*, sp.PRO_ID FROM `ORDER` AS O
	inner join
	supplier_pricing as sp on sp.PRICING_ID=o.pricing_id and O.ord_date>"2021-10-05"
) as q
on p.PRO_ID = q.PRO_ID;