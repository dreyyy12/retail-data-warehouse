ALTER TABLE sales_header
ADD sales_id INT;

UPDATE sales_header
SET sales_id = CAST(RIGHT(sales_no, 6) AS INT)
WHERE sales_id IS NULL;

select * from customer

alter table customer
add customer_sid INT;

update product
set product_sid = CAST(RIGHT(product_code, 4) AS INT)
where product_sid is null;

alter table product
add product_sid INT
