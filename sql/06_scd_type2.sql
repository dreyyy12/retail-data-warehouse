-- ============================================================
-- IMPLEMENTASI SCD TIPE 2: TAHAP 1 (MENUTUP HISTORI LAMA)
-- ============================================================
UPDATE target
SET 
    target.end_date = CAST(GETDATE() AS DATE),
    target.is_current = 0                      
FROM Loading.Dim_Customer_Membership target
INNER JOIN Transformasi.Membership_Clean source 
    ON target.customer_id = source.customer_id
WHERE target.is_current = 1 
  AND target.end_date IS NULL 
  AND target.membership_level_id <> source.membership_level_id; 


-- ============================================================
-- IMPLEMENTASI SCD TIPE 2: TAHAP 2 (MEMASUKKAN BARIS BARU)
-- ============================================================

INSERT INTO Loading.Dim_Customer_Membership (
    customer_id, 
    membership_level_id, 
    start_date, 
    end_date, 
    is_current
)
SELECT 
    source.customer_id,
    source.membership_level_id,
    CAST(GETDATE() AS DATE) AS start_date, 
    NULL AS end_date,
    1 AS is_current                        
FROM Transformasi.Membership_Clean source
WHERE NOT EXISTS (
    SELECT 1 
    FROM Loading.Dim_Customer_Membership target
    WHERE target.customer_id = source.customer_id 
      AND target.is_current = 1
      AND target.end_date IS NULL 
      AND target.membership_level_id = source.membership_level_id
);
