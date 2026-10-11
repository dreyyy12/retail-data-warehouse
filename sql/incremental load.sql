-- ============================================================
-- INCREMENTAL LOAD: TABEL FAKTA POIN PELANGGAN (Fact_Customer_Point)
-- ============================================================

DECLARE @LastLoadDate DATE;
SELECT @LastLoadDate = ISNULL(MAX(point_date), '1900-01-01') 
FROM Customer_Point;

INSERT INTO Customer_Point (
    customer_id, 
    point_date, 
    point_earned, 
    point_redeemed, 
    point_balance
)
SELECT 
    c.customer_id, 
    cp.point_date, 
    cp.point_earned, 
    cp.point_redeemed, 
    cp.point_balance
FROM Customer_Point cp
INNER JOIN Customer_Point c ON cp.customer_id = c.customer_id
WHERE cp.point_date > @LastLoadDate; 
