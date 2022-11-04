use my_db;

## Nomor 1
# tampilkan 50 baris dari tabel olist_customers dengan customer state = 'RJ'
select *
from olist_customers
where customer_state = 'RJ'
limit 50;

## Nomor 2
# tampilkan 50 baris dari olist_sellers dengan seller_city diantara kota2 berikut:
# 'sao paulo','santo andre','americana','rio de janeiro', 'curitiba'.
# urutkan berdasarkan seller_city secara alfabetis
select *
from olist_sellers
where seller_city in ('sao paulo','santo andre','americana','rio de janeiro', 'curitiba')
# where seller_city in ('sao paulo','santo andre','americana','rio de janeiro', 'curitiba')
# not in berarti selain yang kita tulias
order by seller_city;

## Nomor 3
# Tampilkan product_id dari tabel olist_products dengan product_weight_g tidak melebihi 1000 atau
# product_length_cm tidak kurang dari 40
select product_id, product_weight_g,product_length_cm
from olist_products
where product_weight_g <= 1000 and product_length_cm >=40;

## Nomor 4
# tampilkan secara unik order status dari tabel olist_orders dengan order_approved_at berupa null
select order_id,order_status
from olist_orders
where order_approved_at is null;

## SECARA UNIQUE ITU ARTINYA SELECT DISTINCT
# Koreksi nomor 4
select distinct order_status
from olist_orders
where order_approved_at is null;

## nomor 5
# pada tabel olist_order_payment, buat sebuah kolom yang mengidentifikasi apakah payment_value berada diantara
# 100 s/d 200
select
	*,
	case when payment_value >= 100 and payment_value <= 200 then 'masuk' # and payment_value >= 200
	else 'tidak masuk'
	end as status_value
from
	olist_order_payments;
    
select
	*,
	case when payment_value between 100 and 200 then 'mashook'
    else 'ndak mashook'
    end as 'mashook po ra'
from
	olist_order_payments;
    
## Cara lain nulis solusi nomor 5
select
	payment_value,
    case when payment_value between 100 and 200 then 'yes'
    else 'no' end as status_value
from olist_order_payments;
    
## Nomor 6
# tampilkan review_id dan review_comment_message dari tabel olist_order_reviews dengan
# review_comment_message diawali kata 'super'
select * from olist_order_reviews;
select distinct review_comment_title from olist_order_reviews;

select
	review_id,
    review_comment_message
from
	olist_order_reviews
where
	review_comment_message like 'super%';
    # di SQL itu pada umumnya case insensitive
    
## Nomor 7
# pada tabel olist_order_reviews, tampilkan kolom dengan aturan:
# 1. tampilkan review_comment_message jika isinya ada
# 2. jika tidak, tampilkan review_comment_title (jika ada)
# 3. jika tidak juga, tampilkan review_id
select 
	coalesce(review_comment_message,coalesce(review_comment_title,review_id)) as 'Review_Summary'
from olist_order_reviews;

# Cara lain nulis solusi nomor 7
select
	coalesce(review_comment_message,review_comment_title,review_id) as 'Review Summary'
from olist_order_reviews;