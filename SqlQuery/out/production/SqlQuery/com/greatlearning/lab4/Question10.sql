

select * from rating;


select * from `order` as o
inner join
rating as rat
on o.ORD_ID = rat.ORD_ID;


select o.PRICING_ID, rat.ORD_ID , rat.RAT_RATSTARS from `order` as o
inner join
rating as rat
on o.ORD_ID = rat.ORD_ID;



select * from supplier_pricing as sp
inner join
(
	select o.PRICING_ID, rat.ORD_ID , rat.RAT_RATSTARS from `order` as o
	inner join
	rating as rat on o.ORD_ID = rat.ORD_ID
) as t1 on sp.PRICING_ID =t1.pricing_id;


select * from supplier_pricing as sp
inner join
(
	select o.PRICING_ID, rat.ORD_ID , rat.RAT_RATSTARS from `order` as o
	inner join
	rating as rat on o.ORD_ID = rat.ORD_ID
) as t1 on sp.PRICING_ID =t1.pricing_id;


select sp.SUPP_ID,t1.ord_id,t1.rat_ratstars from supplier_pricing as sp
inner join
(
	select o.PRICING_ID, rat.ORD_ID , rat.RAT_RATSTARS from `order` as o
	inner join
	rating as rat on o.ORD_ID = rat.ORD_ID
) as t1 on sp.PRICING_ID =t1.pricing_id;

 

select test2.supp_id, avg(rat_ratstars) as Average from
(
	select sp.SUPP_ID,t1.ord_id,t1.rat_ratstars from supplier_pricing as sp
	inner join
	(
		select o.PRICING_ID, rat.ORD_ID , rat.RAT_RATSTARS from `order` as o
		inner join
		rating as rat on o.ORD_ID = rat.ORD_ID
	) as t1 on sp.PRICING_ID =t1.pricing_id
) as test2 group by test2.SUPP_ID;

 
select final.supp_id, supplier.supp_name, final.Average from
(
	select test2.supp_id, sum(test2.rat_ratstars)/count(test2.rat_ratstars) as Average from
	(
		select supplier_pricing.supp_id, test.ORD_ID, test.RAT_RATSTARS from supplier_pricing
        inner join
		(
			select `order`.pricing_id, rating.ORD_ID, rating.RAT_RATSTARS from `order`
            inner join
            rating on rating.`ord_id` = `order`.ord_id
		) as test on test.pricing_id = supplier_pricing.pricing_id
	) as test2 group by supplier_pricing.supp_id
) as final inner join supplier where final.supp_id = supplier.supp_id;



select report.SUPP_ID, report.Average,
CASE
	WHEN report.Average =5 THEN 'Excellent Service'
	WHEN report.Average >4 THEN 'Good Service'
	WHEN report.Average >2 THEN 'Average Service'
	ELSE 'Poor Service'
END AS Type_of_Service from
 (
	select test2.supp_id, avg(rat_ratstars) as Average from
	(
		select sp.SUPP_ID,t1.ord_id,t1.rat_ratstars from supplier_pricing as sp
		inner join
		(
			select o.PRICING_ID, rat.ORD_ID , rat.RAT_RATSTARS from `order` as o
			inner join
			rating as rat on o.ORD_ID = rat.ORD_ID
		) as t1 on sp.PRICING_ID =t1.pricing_id
	) as test2 group by test2.SUPP_ID
) as report;


DELIMITER $$
USE `a_ecommerce`$$
CREATE PROCEDURE `supplier_ratings` ()
BEGIN
	select report.SUPP_ID, report.Average,
CASE
	WHEN report.Average =5 THEN 'Excellent Service'
	WHEN report.Average >4 THEN 'Good Service'
	WHEN report.Average >2 THEN 'Average Service'
	ELSE 'Poor Service'
END AS Type_of_Service from
 (
	select test2.supp_id, avg(rat_ratstars) as Average from
	(
		select sp.SUPP_ID,t1.ord_id,t1.rat_ratstars from supplier_pricing as sp
		inner join
		(
			select o.PRICING_ID, rat.ORD_ID , rat.RAT_RATSTARS from `order` as o
			inner join
			rating as rat on o.ORD_ID = rat.ORD_ID
		) as t1 on sp.PRICING_ID =t1.pricing_id
	) as test2 group by test2.SUPP_ID
) as report;
END$$

DELIMITER ;