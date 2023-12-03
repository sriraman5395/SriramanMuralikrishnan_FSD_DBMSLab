select * from product;
select * from supplier_pricing;
select * from category;


select * from supplier_pricing;

select pro_id, min(supp_price) as Min_Price from supplier_pricing group by pro_id;


select * from product as p
inner join
(
	select pro_id, min(supp_price) as Min_Price from supplier_pricing group by pro_id
) as t2 on t2.PRO_ID=p.PRO_ID;


select p.CAT_ID, p.PRO_NAME, t2.* from product as p
inner join
(
	select pro_id, min(supp_price) as Min_Price from supplier_pricing group by pro_id
) as t2 on t2.PRO_ID=p.PRO_ID;


select * from category as cat
inner join
(
	select p.CAT_ID, p.PRO_NAME, t2.* from product as p
	inner join
	(
		select pro_id, min(supp_price) as Min_Price from supplier_pricing group by pro_id
	) as t2 on t2.PRO_ID=p.PRO_ID
) as t3 on t3.CAT_ID= cat.CAT_ID;


select c.CAT_ID,c.CAT_NAME, min(t3.min_price) as Min_Price from category as c
inner join
(
	select p.CAT_ID, p.PRO_NAME, t2.* from product as p
	inner join
	(
		select pro_id, min(supp_price) as Min_Price from supplier_pricing group by pro_id
	) as t2 on t2.PRO_ID=p.PRO_ID
) as t3 on t3.CAT_ID= c.CAT_ID group by t3.CAT_ID;


select category.cat_id,category.cat_name, min(t3.min_price) as Min_Price from category
inner join
(
	select product.cat_id, product.pro_name, t2.* from product
    inner join
	(
		select pro_id, min(supp_price) as Min_Price from supplier_pricing group by pro_id
	) as t2 where t2.pro_id = product.pro_id
) as t3 where t3.cat_id = category.cat_id group by t3.cat_id;
