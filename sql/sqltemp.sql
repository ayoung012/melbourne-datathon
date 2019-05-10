SELECT * FROM transact



-- Depression drugs  ATCLevel3Code = 'N06A';

SELECT t1.Patient_ID, t1.Drug_ID, t2.Drug_ID
FROM transactions t1
JOIN transactions t2
WHERE t1.Patient_ID = t2.Patient_ID


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
)

-- Hopefully takes less long
SELECT t1.Patient_ID, t1.Drug_ID, t2.Drug_ID, t1.Dispense_Week, t2.Dispense_Week
FROM transactions t1
JOIN transactions t2 ON t1.Patient_ID = t2.Patient_ID
AND t2.Dispense_Week BETWEEN date(t1.Dispense_Week, '-14 days') AND date(t1.Dispense_Week, '+14 days')
AND t1.Drug_ID IN (
    SELECT MasterProductID
    FROM Drug_LookUp
    INNER JOIN Adverse_Interaction ai ON ai.DrugA_ID = GenericIngredientName
)
AND t2.Drug_ID IN (
    SELECT MasterProductID
    FROM Drug_LookUp
    WHERE GenericIngredientName IN (
        SELECT DrugB_ID
        FROM Adverse_Interaction ai 
        WHERE DrugA_ID IN (
            SELECT GenericIngredientName
            FROM Drug_LookUp
            WHERE MasterProductID = t1.Drug_ID
        )
    )
)


SELECT t1.Prescriber_ID, t1.Patient_ID
        FROM transactions_depression_vic t1
        JOIN transactions_depression_vic t2
        JOIN Drug_LookUp d1
        JOIN Drug_LookUp d2
        WHERE t1.Patient_ID = t2.Patient_ID
        AND d1.MasterProductID = t1.Drug_ID
        AND d2.MasterProductID = t2.Drug_ID
        AND d1.GenericIngredientName > d2.GenericIngredientName
        AND (d1.GenericIngredientName NOT LIKE '%MIRTAZAPINE%'
        AND d2.GenericIngredientName NOT LIKE '%MIRTAZAPINE%')
        AND (d1.GenericIngredientName LIKE '%TRAMADOL%'
        OR d2.GenericIngredientName LIKE '%TRAMADOL%')
        AND t1.Dispense_Week = t2.Dispense_Week
        GROUP BY t1.Prescriber_ID, t1.Patient_ID
        HAVING COUNT(t1.Prescription_Week) > 5
        ORDER BY COUNT(t1.Prescription_Week) DESC;
