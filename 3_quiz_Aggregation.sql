use my_db;

## Nomor 1
# Hitung banyaknya baris pada tabel olist_sellers
select * from olist_sellers;

select
	count(seller_id) as jumlah_seller
from
	olist_sellers;
    
# atau bisa juga lgsg pake count(1)
select count(1) as jumlah_seller from olist_sellers;
    
    
## Nomor 2
# berdasarkan tabel olist_customers, hitung banyaknya kota di masing2 state.
# urutkan state secara alfabetis. Petunjuk : gunakan fungsi count(distinct customer_city)
select * from olist_customers;

select
	customer_state, # menjadi category column
    count(distinct customer_city) as jumlah_kota
    # fungsi count tapi ngitung yg unique dari customer_city
from
	olist_customers
where
	customer_city is not null
group by
	1
order by
	1;

# ngecek AL beneran cuma 2 kota, yay bener
select
	customer_state,
    customer_city
from
	olist_customers
where
	customer_city is not null
order by
	1; 
    
## Nomor 3
# hitung jumlah payment_value dari tabel olist_order_payments yang menggunakan credit_card serta
# payment_installments lebih dari 1. kelompokkan berdasarkan payment_installments dan
# urutkan payment_installments dari terkecil sampai terbesar
select * from olist_order_payments;

select
	payment_type,
	payment_installments,
    sum(payment_value) as total_payment
from
	olist_order_payments
where
	payment_type = 'credit_card' and
    payment_installments > 1
group by
	1,2
order by
	2;
    
## Nomor 4
# berdasarkan tabel olist_products, berapa rata2 berat (product_weight_g) dari produk
# yang memiliki panjang (product_length_cm) antara 40cm s/d 80cm
select * from olist_products;

select
	avg(product_weight_g) as avg_weight_40_80
from
	olist_products
where
	product_length_cm between 40 and 80;
    
## Nomor 5
# pada tabel olist_order_items, tampilkan seller_id dan jumlah price masing2 apabila
# jumlah price si penjual tersebut lebih besar dari 2000.
# urutkan jumlah price dari yang terbesar hingga terkecil
select * from olist_order_items;

select
	seller_id,
    sum(price) as total_price
from
	olist_order_items
group by
	1
having
	total_price >= 2000
order by
	2 desc