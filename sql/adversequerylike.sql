-- Select patients taking tramadol with other AD in same week

SELECT t1.Patient_ID,
    t1.Store_ID as store_id1, t1.Prescriber_ID as prescriber_id1, t1.Drug_ID as drug_id1, t1.Dispense_Week as dispense_week1,
    t2.Store_ID as store_id2, t2.Prescriber_ID as prescriber_id2, t2.Drug_ID as drug_id2, t2.Dispense_Week as dispense_week2
FROM tramadol_min_vic t1
JOIN adverse_trans_min t2 ON t1.Patient_ID = t2.Patient_ID
AND t1.Dispense_Week = t2.Dispense_Week
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
    WHERE GenericIngredientName LIKE ai.DrugB_ID
);

