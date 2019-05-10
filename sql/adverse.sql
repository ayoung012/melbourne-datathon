SELECT t1.Patient_ID, t1.Drug_ID, t2.Drug_ID, t1.Dispense_Week, t2.Dispense_Week
FROM transactions_depression_vic t1
JOIN transactions_depression_vic t2 ON t1.Patient_ID = t2.Patient_ID
AND t2.Dispense_Week BETWEEN date(t1.Dispense_Week, '-14 days') AND date(t1.Dispense_Week, '+14 days')
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
);

