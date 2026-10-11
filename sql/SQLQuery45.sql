
SELECT TOP 10
    sd.product_id AS kode_produk_transaksi,
    p.product_name AS nama_produk,
    COUNT(sd.sales_id) AS frekuensi_pembelian, 
    SUM(sd.qty) AS total_kuantitas_terjual     
FROM Sales_Detail sd 
LEFT JOIN product p ON sd.product_id = p.product_sid
GROUP BY 
    sd.product_id,
    p.product_name
ORDER BY 
    total_kuantitas_terjual DESC; 



SELECT TOP 3 c.customer_id, c.customer_name, cm.membership_level_id, ml.level_name, cm.start_date
FROM customer c 
INNER JOIN customer_membership cm ON c.customer_id = cm.customer_id
INNER JOIN membership_level ml ON cm.membership_level_id = ml.membership_level_id

