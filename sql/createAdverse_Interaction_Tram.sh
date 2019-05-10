#!/bin/bash
#===============================================================
# Uses relative directory paths and assumes there is a data
# subfolder in the root of the repo and a raw folder inside that
#
# Creates Drug_LookUp Table
# Imports all Drug_LookUp data into sqlite db

DATA=../data/raw
DB=../data/medi.db

# Create Drug_LookUp Table in database
sqlite3 $DB "DROP TABLE Adverse_Interaction"

sqlite3 $DB "CREATE TABLE Adverse_Interaction
(
    DrugA_ID smallint,
    DrugB_ID smallint,
    Rating smallint -- 1 to 5 based on severity
)"

# add more values by uncommenting the last line and removing quote mark on second last line
sqlite3 $DB "INSERT INTO Adverse_Interaction
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
"
