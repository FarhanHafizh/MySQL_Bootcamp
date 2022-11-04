use my_db;

## Nomor 1 BETUL
# tampilkan tabel olist_order_payments tapi ganti karakter (_) pada tipe pembayaran dengan spasi
select
	payment_type,
    replace(payment_type, '_', ' ') as payment
from
	olist_order_payments;
    
## Nomor 2 BETUL
# tampilkan pesanan yang diterima customer (order_delivered_customer_timestamp) pada tanggal 1 bulan apapun
select
	order_id,
	order_delivered_customer_timestamp,
    mid(order_delivered_customer_timestamp,9,2) as mid
    # substr(order_delivered_customer_timestamp,9,2) as substring_1,
    # substring(order_delivered_customer_timestamp,9,2) as substring_2
from
	olist_orders
where
	mid(order_delivered_customer_timestamp,9,2) like '01'
;

# Cara kedua
select
	order_id,
	order_delivered_customer_timestamp,
    substr(order_delivered_customer_timestamp,9,2) as substring_1
    # substring(order_delivered_customer_timestamp,9,2) as substring_2
from
	olist_orders
where
	order_delivered_customer_timestamp like '%-01 %'
;

## Nomor 3 BETUL TAPI ADA JAWABAN LENGKAP DENGAN CASE WHEN LENGTH(ZIP) > 5
# tampilkan seller_zip_code_prefix (tabel olist_sellers) dengan aturan
# 1. jika terdiri dari 5 digit atau lebih tampilkan apa adanya
# 2. jika kurang, berikan angka 0 di depannya agar menjadi 5 digit
select
	seller_zip_code_prefix,
    lpad(seller_zip_code_prefix,5,0) as zip
from
	olist_sellers;
    
# Kalau null diasumsikan 00000
select
	seller_zip_code_prefix,
    lpad(coalesce(seller_zip_code_prefix,''),5,0) as zip
from
	olist_sellers;

# Jawaban tutor
select
	seller_zip_code_prefix,
	case when length(seller_zip_code_prefix) > 4 then seller_zip_code_prefix
	else lpad(coalesce(seller_zip_code_prefix,''),5,0) end as zip
from
	olist_sellers
;
    
## Nomor 4 BETUL
# berapa banyak review yang diberikan pada tahun 2017 yang memiliki lebih dari 80 karakter pada pesannya?
select
	count(1)
from
	olist_order_reviews
where
	left(review_creation_date,4) like '2017' and
    length(review_comment_message) > 80
;

# Cara lain
select
	count(1) as count_reviews
from
	olist_order_reviews
where
	length(review_comment_message) > 80 and
    review_creation_date like '2017%'
;

## Nomor 5
# Tampilkan secara unik kota yang ada di olist_customers dan hitung berapa banyak huruf a pada nama kota tersebut
select distinct
	customer_city
from
	olist_customers
where
	customer_city is not null
# Jujur bingung
;

# nyonyek tutor sebelum dijawab full
select
	customer_city,
    length(customer_city) - length(city_modified) as num_a_in_city
from
	(
		select
			customer_city,
			replace(customer_city,'a','') as city_modified
		from
			(
				select distinct
					customer_city
				from
					olist_customers
				where
					customer_city is not null
			) as t1
	) as t2
;
# Jawaban full tutor
select
	customer_city,
	replace(customer_city,'a','') as city_modified,
    length(customer_city) - length(replace(customer_city,'a','')) as a_in_city
from
	(
		select distinct
			customer_city
		from
			olist_customers
		where
			customer_city is not null
	) as t1