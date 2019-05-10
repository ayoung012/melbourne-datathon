SELECT 'Different Doctors', 
(SELECT GenericIngredientName
FROM Drug_LookUp
WHERE MasterProductID = t2.Drug_ID
), t2.Drug_ID, count(*)
FROM tramadol_min_vic t1
JOIN adverse_trans_min t2 ON t1.Patient_ID = t2.Patient_ID
AND t1.Dispense_Week = t2.Dispense_Week
AND t1.Prescriber_ID != t2.Prescriber_ID
AND t1.Drug_ID IN (
    SELECT MasterProductID
    FROM Drug_LookUp
    INNER JOIN Adverse_Interaction ai ON ai.DrugA_ID = GenericIngredientName
)
AND t2.Drug_ID IN (
    SELECT MasterProductID
    FROM Drug_LookUp
    INNER JOIN Adverse_Interaction ai ON ai.DrugA_ID IN (
        SELECT GenericIngredientName
        FROM Drug_LookUp
        WHERE MasterProductID = t1.Drug_ID
    )
    WHERE GenericIngredientName = ai.DrugB_ID
)
GROUP BY t2.Drug_ID
;
