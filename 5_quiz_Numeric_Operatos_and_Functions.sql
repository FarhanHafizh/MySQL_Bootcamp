use my_db;

## 1 BETUL
# Tampilkan order_id dari tabel olist_order_payments yang memiliki payment_value dibagi payment installments
# lebih besar sama dengan 30 serta dibayar menggunakan kartu kredit
select * from olist_order_payments;
select
	order_id
from
	olist_order_payments
where
	payment_value/payment_installments >= 30
    and payment_type = 'credit_card';
    
## 2 BETUL
# tampilkan payment_value serta pembulatan keatas kelipatan 100 darinya dari tabel olist_order_payments
# contohnya 56.24 dibulatkan menjadi 100, 432.1 menjadi 500 dst
select
	payment_value,
    ceil(payment_value/100)*100 as ceil_100
from
	olist_order_payments;
    
## 3 TERNYATA SALAH
# Setiap produk dalam tabel olist_products memiliki dimensi panjang, lebar, dan tinggi (?)

## 4
# pada tabel olist_products, asumsikan volume produk berupa panjang x tinggi x lebar
# massa jenis didefinisikan sebagai massa dibagi volume. Tampilkan density terbesar masing2 kategori produk
# tapi tampilkan dalam bahasa inggris bukan portugis dengan menggunakan tabel product_category_name_translation
# untuk menerjemahkan kategori produknya
select
	count(product_category_name)
from
	olist_products;
    
select
	count(product_category_name_english)
from
	product_category_name_translation;


select
	*
from
	simple_orders as t1
    left join
		simple_customers as t2
		on t1.customer_id = t2.customer_id;

select
-- 	product_category_name_english,
--     product_weight_g,
--     product_length_cm,
--     product_height_cm,
--     product_width_cm,
    count(product_width_cm)
from
	olist_products as p1
    inner join
		product_category_name_translation as p2
		on p1.product_category_name = p2.product_category_name;
        
# answer :
select
	product_category_name_english,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm,
    (product_width_cm * product_height_cm * product_length_cm) as volume,
    product_weight_g / (product_width_cm * product_height_cm * product_length_cm) as density
from
	olist_products as p1
    inner join
		product_category_name_translation as p2
		on p1.product_category_name = p2.product_category_name
order by
	density desc;
        
# final answer
    
select
	product_category_name_english,
    product_weight_g / (product_width_cm * product_height_cm * product_length_cm) as density_cm3
from
	olist_products as p1
    inner join
		product_category_name_translation as p2
		on p1.product_category_name = p2.product_category_name
order by
	2 desc;

## koreksi sebelum ngeliat video full - lakukan agregasi terlebih dahulu
# ternyata bener yang bawah ini
select
	product_category_name_english,
    max_density
from
    (	select
			product_category_name,
			max(density) as max_density
		from
			(	select
					product_category_name,
					product_weight_g / (product_width_cm * product_height_cm * product_length_cm) as density
				from
					olist_products
			) as p1
		group by
			1
    ) as p2
    inner join
		product_category_name_translation as p3
        on p2.product_category_name = p3.product_category_name;