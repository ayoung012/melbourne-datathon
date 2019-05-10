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

-- Ant previous query finding tramadol interactions

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


SELECT * FROM Drug_LookUp
WHERE MasterProductID IN (
SELECT drug_ID
FROM adverse_trans_min
GROUP BY Drug_ID
ORDER BY COUNT(*) DESC
LIMIT 10
);

-- Select top ten transactions by drug_ID incl genericIngredientName from drug lookup
SELECT t.Drug_ID, GenericIngredientName, count(*)
FROM adverse_trans_min t
JOIN Drug_LookUp d ON MasterProductID = Drug_ID
GROUP BY Drug_ID
ORDER BY COUNT(*) DESC
LIMIT 30;

-- Select top ten transactions by drug_ID incl genericIngredientName from drug lookup
SELECT d.GenericIngredientName
FROM Drug_LookUp d 
WHERE d.GenericIngredientName LIKE '%TRAMADOL%';

-- DELETE all not in top 10
DELETE FROM adverse_trans_min
WHERE Drug_ID NOT IN (
SELECT drug_ID
FROM adverse_trans_min
GROUP BY Drug_ID
ORDER BY COUNT(*) DESC
LIMIT 10
);


DELETE FROM adverse_trans_min
WHERE Drug_ID IN (
        SELECT d.MasterProductID
        FROM Drug_LookUp d
        WHERE d.GenericIngredientName LIKE '%MIRTAZAPINE%'
);


-- DELETE all except MAOIs
DELETE FROM adverse_trans_min
WHERE Drug_ID NOT IN (
        SELECT d.MasterProductID
        FROM Drug_LookUp d
        WHERE (d.GenericIngredientName LIKE '%PHENELZINE%'
        OR d.GenericIngredientName LIKE '%TRANYLCYPROMINE%'
       OR d.GenericIngredientName LIKE '%MOCLOBEMIDE%'
    )
);

-- DELETE all that are not TRAMADOL
DELETE FROM tramadol_min_vic
WHERE Drug_ID NOT IN (
        SELECT d.MasterProductID
        FROM Drug_LookUp d
        WHERE d.GenericIngredientName LIKE '%TRAMADOL%'
);

INSERT INTO Adverse_Interaction
VALUES 
('TRAMADOL','DESVENLAFAXINE',4),
('TRAMADOL','VENLAFAXINE',4),
('TRAMADOL','SERTRALINE',4),
('TRAMADOL','ESCITALOPRAM',4),
('TRAMADOL','DULOXETINE',4),
('TRAMADOL HYDROCHLORIDE','DESVENLAFAXINE',4),
('TRAMADOL HYDROCHLORIDE','VENLAFAXINE',4),
('TRAMADOL HYDROCHLORIDE','SERTRALINE',4),
('TRAMADOL HYDROCHLORIDE','ESCITALOPRAM',4),
('TRAMADOL HYDROCHLORIDE','DULOXETINE',4),
('TRAMADOL/PARACETAMOL','DESVENLAFAXINE',4),
('TRAMADOL/PARACETAMOL','VENLAFAXINE',4),
('TRAMADOL/PARACETAMOL','SERTRALINE',4),
('TRAMADOL/PARACETAMOL','ESCITALOPRAM',4),
('TRAMADOL/PARACETAMOL','DULOXETINE',4)



2885|VENLAFAXINE|20046
7874|SERTRALINE|16072
7083|DESVENLAFAXINE|15630
2884|VENLAFAXINE|14118
4825|ESCITALOPRAM|11644
2179|DULOXETINE|11486
10604|VENLAFAXINE|11386
7873|SERTRALINE|10992
2932|SERTRALINE|10964


