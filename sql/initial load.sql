-- fact sales
IF OBJECT_ID('loading.fact_sales') IS NOT NULL
	DROP VIEW loading.fact_sales;
GO

CREATE TABLE loading.fact_sales AS 
SELECT 
	sh.sales_no,
	c.customer_sid,
	p.product_sid,
	sd.sales_id,
	sh.sales_datetime,
	sd.qty,
	sd.line_total,
	sh.net_amount
FROM sales_detail sd
INNER JOIN sales_header sh ON sd.sales_id = sh.sales_id     
INNER JOIN customer c ON sh.customer_id = c.customer_id   
INNER JOIN product p ON sd.product_id = p.product_id;

-- dim_customer
IF OBJECT_ID('loading.dim_customer') IS NOT NULL
	DROP VIEW loading.dim_customer;
GO

CREATE TABLE loading.dim_customer AS
SELECT 
    -- Atribut dari tabel Customer
    c.customer_sid,
    c.customer_code,
    c.customer_id,
    c.customer_name,
    c.gender,
    c.birth_date,
    c.email,
    c.phone,
    c.registration_date,
    c.status,
    
    cf.feedback_date,
    cf.rating,
    
    cm.membership_level_id,
    cm.start_date,
    cm.end_date,
    cm.is_current,
    
    -- Atribut dari tabel Customer_Point
    cp.point_date,
    cp.point_earned,
    cp.point_redeemed,
    cp.point_balance

FROM Customer c
LEFT JOIN Customer_Feedback cf ON c.customer_id = cf.customer_id
LEFT JOIN Customer_Membership cm ON c.customer_id = cm.customer_id
LEFT JOIN Customer_Point cp ON c.customer_id = cp.customer_id;

-- dim_product
IF OBJECT_ID('loading.dim_product') IS NOT NULL
	DROP VIEW loading.dim_product;
GO

CREATE TABLE loading.dim_product AS
SELECT 
    p.product_sid,
    p.product_code,
    p.product_id,
    p.product_name,
    p.brand_id,
    p.unit_cost,
    p.unit_price,
    p.status,
    
    pc.category_name,
    pc.category_id,
    
    ps.subcategory_name

FROM product p
LEFT JOIN product_subcategory ps ON p.category_id = ps.category_id
LEFT JOIN product_category pc ON ps.category_id = pc.category_id;

