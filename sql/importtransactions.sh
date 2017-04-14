#!/bin/bash
# Creates transaction table
# Imports all transaction data into sqlite db

DATA=~/Projects/datasci/data
DB=datasci.db

# Create Patients database
sqlite3 $DB "
    CREATE TABLE transactions
    (
        Patient_ID  int
    ,   Store_ID    smallint
    ,   Prescriber_ID   int
    ,   Drug_ID smallint
    ,   SourceSystem_Code   varchar(1)
    ,   Prescription_Week   DATE
    ,   Dispense_Week   DATE
    ,   Drug_Code   varchar(37)
    ,   NHS_Code    varchar(6)
    ,   IsDeferredScript    tinyint
    ,   Script_Qty  smallint
    ,   Dispensed_Qty   smallint
    ,   MaxDispense_Qty smallint
    ,   PatientPrice_Amt    float
    ,   WholeSalePrice_Amt  float
    ,   GovernmentReclaim_Amt   float
    ,   RepeatsTotal_Qty    smallint
    ,   RepeatsLeft_Qty smallint
    ,   StreamlinedApproval_Code    smallint
    )"

for f in $DATA/Transactions/pat*
do
    sqlite3 -separator $'\t' $DB ".import $f transactions"
done
