use my_db;

## Nomor 1
# Tampilkan selisih hari sejak sebuah review dibuat (review_creation_date) sampai review dijawab (review_answer_timestamp)
# hitung banyaknya review berdasarkan selisih hari dijawab tersebut
# urutkan dari yang tercepat hingga terlama
select
	lama_dijawab,
    count(1)
from
	(
		select
			review_creation_date,
			review_answer_timestamp,
			date(review_answer_timestamp) as tanggal_dijawab,
			datediff(date(review_answer_timestamp), review_creation_date) as lama_dijawab
		from
			olist_order_reviews
	) as t1
group by
	1
order by
	1
;

## Ngecek
select
	count(1)
from
	olist_order_reviews
where
	datediff(date(review_answer_timestamp), review_creation_date) = 0
;
# 325 yay harusnya betul

# iseng coba lagi
select
	datediff(date(review_answer_timestamp), review_creation_date) as lama_dijawab,
    count(1) as jumlah
from
	olist_order_reviews
group by
	1
order by
	1
; # ternyata sama

## Nomor 2
# Semua timestamp yang ada pada olist_orders memiliki zona waktu UTC
# Ubah semua kolom timestamp pada tabel tsb agar menampilkan waktu seusai WIB (UTC+7)
select
	*
from
	olist_orders;
    
## Nomor 3
# tampilkan selisih waktu dari shipping_limit_date (olist_order_items) dengan
# order_approved_at (olist_orders) untuk setiap order_id
# Lakukan pengelompokkan berdasarkan selisih hari

select
	order_id,
    shipping_limit_date
from
	olist_order_items;
    
select
	order_id,
    order_approved_at
from
	olist_orders;
--------------------------

select
	t1.order_id,
    order_approved_at,
    shipping_limit_date,
    datediff(shipping_limit_date,order_approved_at) as selisih_hari,
    count(1) as jumlah
from
	olist_order_items as t1
    inner join
		olist_orders as t2
	on t1.order_id = t2.order_id
group by
	4
order by
	4
;