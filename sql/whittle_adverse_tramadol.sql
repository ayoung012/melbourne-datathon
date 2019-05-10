-- Creates table of transactions involving tramadol or antidepressant drugs (limited to one year and to victoria).

CREATE TABLE adverse_trans_min
AS
SELECT * FROM transactions
WHERE Dispense_Week >= '2015-01-01'
AND Dispense_Week < '2016-01-01'
AND Patient_ID IN (
    SELECT Patient_ID
    FROM transactions 
    GROUP BY Patient_ID, Drug_ID
    HAVING count(*) > 1
)
AND (
    Drug_ID IN (
        SELECT d.MasterProductID
        FROM Drug_LookUp d
        WHERE d.GenericIngredientName LIKE '%TRAMADOL%'
    ) OR  
    Drug_ID IN (
        SELECT c.MasterProductID AS Drug_ID
        FROM ChronicIllness_LookUp c
        WHERE c.ChronicIllness = 'Depression'
    )
)      
AND Patient_ID IN (
    SELECT Patient_ID
    FROM patients
    WHERE postcode IN (
        SELECT postcode FROM postcodes_geo
        WHERE state = 'VIC'
    )
)
