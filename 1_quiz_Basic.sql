use my_db;

## Nomor 1
# Tampilkan 50 baris pertama tabel olist_orders
select
	*
from
	olist_orders
limit
	50;
    
## Nomor 2
# tampilkan kolom order_id, customer_id, order_purchase_timestamp pada tabel olist orders
# batasi 50 baris pertama
select
	order_id,
    customer_id,
	order_purchase_timestamp
from
	olist_orders
limit
	50;
    
## Nomor 3
# dari tabel olist_order_items, tampilkan kolom (1) price, (2) price + 100, (3) price + freight_value
# berikan alias pada kolom kedua dan ketiga dengan nama bebas & batasi 50 baris pertama
select * from olist_order_items limit 50;
select
	price,
    price + 100 PricePlus100,
    price + freight_value as Price_n_Freight
from
	olist_order_items
limit
	50;
    
## Nomor 4
# tampilkan secara unik semua customer_state dari tabel olist customers
select distinct
	customer_state
from
	olist_customers
limit
	50;
    
## Nomor 5
# urutkan tabel olist_orders berdasarkan order_purchase_timestamp terlama sampai terbaru.
# kapan pembelian ketiga dilakukan berdasarkan tabel tersebut?
select
	*
from
	olist_orders
order by
	order_purchase_timestamp
limit
	50;