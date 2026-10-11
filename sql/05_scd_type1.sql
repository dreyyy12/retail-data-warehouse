-- ============================================================
-- IMPLEMENTASI SCD TIPE 1: UPDATE DATA KONTAK (Dim_Customer)
-- ============================================================
UPDATE target
SET 
    target.customer_name     = source.customer_name,
    target.gender            = source.gender,
    target.birth_date        = source.birth_date,
    target.email             = source.email,
    target.phone             = source.phone,
    target.registration_date = source.registration_date,
    target.status            = source.status
FROM Loading.Dim_Customer target
INNER JOIN Customer source 
    ON target.customer_code = source.customer_code
WHERE 
    target.customer_name     <> source.customer_name
    OR target.gender         <> source.gender
    OR target.birth_date     <> source.birth_date
    OR target.email          <> source.email
    OR target.phone          <> source.phone
    OR target.registration_date <> source.registration_date
    OR target.status         <> source.status;



    -- ============================================================
-- IMPLEMENTASI SCD TIPE 1: UPDATE HARGA & STATUS (Dim_Product)
-- ============================================================

UPDATE target
SET 
    target.product_name = source.product_name,
    target.unit_cost = source.unit_cost,
    target.unit_price = source.unit_price,
    target.status = source.status
FROM Loading.Dim_Product target
INNER JOIN Product source 
    ON target.product_code = source.product_code
WHERE target.product_name <> source.product_name
   OR target.unit_cost <> source.unit_cost
   OR target.unit_price <> source.unit_price
   OR target.status <> source.status;
   
