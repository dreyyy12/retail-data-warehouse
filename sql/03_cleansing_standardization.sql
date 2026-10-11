-- cleansing
UPDATE Customer
SET 
	email = ISNULL(email, 'Tidak ada email',
	phone = ISNULL phone, 'Tidak ada no. telp')
WHERE email IS NULL OR phone IS NULL;

UPDATE Customer_Feedback
SET comment = ISNULL(comment, 'Tidak ada ulasan')
WHERE comment IS NULL;

UPDATE Customer_Feedback
SET comment = TRIM(REPLACE(REPLACE(REPLACE(comment, '  ', ' '), '  ', ' '), '  ', ' '))
WHERE comment LIKE '%  %' OR comment LIKE ' %' OR comment LIKE '% ';

UPDATE Ekstraksi.Customer_Feedback
SET comment = REPLACE(comment, '!', '')
WHERE comment LIKE '%!%';

UPDATE Ekstraksi.Customer_Point
SET 
    point_redeemed = CASE WHEN point_redeemed < 0 THEN 0 ELSE point_redeemed END,
    point_balance = CASE WHEN point_balance < 0 THEN 0 ELSE point_balance END
WHERE point_redeemed < 0 OR point_balance < 0;


UPDATE Product
SET unit_price = unit_cost * 1.4
WHERE unit_cost >= unit_price;

DELETE FROM Sales_Header
WHERE sales_status = 'Cancelled';

ALTER TABLE Product
DROP CONSTRAINT FK_Product_Subcategory;

ALTER TABLE Product
DROP COLUMN subcategory_id;

DELETE FROM Sales_Header
WHERE customer_id IS NULL;

ALTER TABLE Sales_Header
DROP COLUMN shift_code;

DELETE FROM Sales_Detail
WHERE qty = 0;

DELETE FROM Sales_Detail
WHERE qty = -1;

-- standarization
UPDATE Customer_Feedback
SET comment = UPPER(LEFT(comment, 1)) + LOWER(SUBSTRING(comment, 2, LEN(comment)))
WHERE comment IS NOT NULL AND LEN(comment) > 0;

UPDATE Product
SET product_name = 'Indomie Goreng'
WHERE product_name LIKE '%indomie goreng%';
