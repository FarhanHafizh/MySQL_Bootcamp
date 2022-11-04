use my_db;

## NOMOR 1
# tampilkan kolom order_id, customer_unique_id, order_status, dan order_purchase_timestamp dari tabel
# olist_orders digabung dengan tabel olist_customers dengan key custumer_id pada kedua tabel
select * from olist_customers;
select * from olist_orders;

select
	order_id,
    customer_unique_id,
    order_status,
    order_purchase_timestamp
from
	olist_orders as t1
    inner join
		olist_customers as t2
	on t1.customer_id = t2.customer_id;
# Nomor 1 udah betul
    
## NOMOR 2
# tampilkan product_category_name dan price dari tabel olist_products dan olist_order_items dengan
# key product_id. tampilkan hanya product_category_name yang memiliki harga saja
select * from olist_products;
select * from olist_order_items;

select
	product_category_name,
    price
from
	olist_products as t1
    inner join
		olist_order_items as t2
	on t1.product_id = t2.product_id
where
	t1.product_category_name is not null; #koreksi sikit, harusnya price nya yang not null
    
select
	product_category_name,
    price
from
	olist_products as t1
    inner join
		olist_order_items as t2
	on t1.product_id = t2.product_id
where
	t2.price is not null;    
    
## Konteks
# customer_unique_id adalah id yang diberikan kepada seorang customer secara unik,
# sementara customer id adalah id yang berasosiasi dengan pesanan yang berbeda2 tiap waktu.
# seorang customer (1 unique_id) bisa memiliki lebih dari 1 customer_id
# Ex : jika customer tersebut memiliki 4 pesanan, maka unique_id nya berasosiasi dengan 4 customer_id yang beda2

## NOMOR 3
# hitung banyaknya customer yang tercatat dalam olist_customers yang tidak memesan apapun sepanjang tahun 2017
select * from olist_customers;
select * from olist_orders;
select * from olist_order_items;
select distinct
	order_status
from
	olist_orders;

select
	customer_unique_id
from
	olist_customers as t1
    left join
		olist_orders as t2
    on t1.customer_id = t2.customer_id
    and t2.order_purchase_timestamp like '2017%'
where order_status not in('delivered','shipped','unavailable');
    
# jawaban no 3 (?)
select
	count(customer_unique_id)
from
	olist_customers as t1
    left join
		olist_orders as t2
    on t1.customer_id = t2.customer_id
where
	t2.order_id is null;
    
## KOREKSI NOMOR 3
select
	count(distinct customer_unique_id) as count_customer
from
	(select
		*
	from
		(select
			customer_id,
			customer_unique_id
		from
			olist_customers) as t1 # sub query2
	left join
		(select
			customer_id as customer_id_2
		from
			olist_orders
		where
			order_purchase_timestamp
		like
			'2017%') as t2 # sub query 1 # nyari customer yang tidak memesan apapun
	on t1.customer_id = t2.customer_id_2
    ) as t # sub query 3
where
	customer_id_2 is null
;

##
	select
		*
	from
		(select
			customer_id,
			customer_unique_id
		from
			olist_customers) as t1 # sub query2
	left join
		(select
			customer_id as customer_id_2
		from
			olist_orders
		where
			order_purchase_timestamp
		like
			'2017%') as t2 # sub query 1 # nyari customer yang tidak memesan apapun
	on t1.customer_id = t2.customer_id_2;
##

## NOMOR 4
# Berdasarkan review tahun 2018 (review_creation_date), kelompokkan dan hitung banyaknya
# review_score yang diterima setiap seller_id.
# Siapa seller yang menerima paling banyak review bintang 5 pada tahun itu?
select * from olist_order_reviews;
select * from olist_order_items;

select
	seller_id,
    review_score
from olist_order_items as t1
	inner join olist_order_reviews as t2
    on t1.order_id = t2.order_id;
    
# Koreksi nomor 4
select
	seller_id,
    review_score,
    count(1) as count_review
from
		(select
			order_id,
			review_score
		from
			olist_order_reviews
		where
			review_creation_date like '2018%'
		) as t1
	inner join
		(select
			order_id as order_id_2,
			seller_id
		from
			olist_order_items
		) as t2
	on t1.order_id = t2.order_id_2
group by
	1,2
order by
	2 desc, 3 desc
;


### REMEDIAL NOMOR 3 DAN 4
## NOMOR 3
select
	count(distinct customer_unique_id) as count_unique
from
	(select
		customer_unique_id,
		customer_id
	from
		olist_customers) as t1
	##
left join
	##
	(select
		customer_id as customer_id_2,
        order_purchase_timestamp
	from
		olist_orders
	where
		order_purchase_timestamp like '2017%')as t2
on
	t1.customer_id = t2.customer_id_2
where
	customer_id_2 is null
;


## NOMOR 4
select
	seller_id,
    review_score,
    count(1) as count_review
from	
		(select
			order_id,
			seller_id
		from
			olist_order_items
		) as  t1
	inner join # kalau pake left review score yang null ikut masuk
		(select	
			order_id,
			review_score,
			review_creation_date
		from
			olist_order_reviews
		where
			review_creation_date like '2018%'
		) as t2
	on t1.order_id = t2.order_id
group by
	1,2
order by
	2 desc,3 desc
;