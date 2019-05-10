#!/bin/bash
#===============================================================
# Uses relative directory paths and assumes there is a data
# subfolder in the root of the repo and a raw folder inside that
#
# Creates Drug_LookUp Table
# Imports all Drug_LookUp data into sqlite db

DATA=../data/raw
DB=test.db

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
('TRAMADOL','%PHENELZINE%',4),
('TRAMADOL','%TRANYLCYPROMINE%',4),
('TRAMADOL','%MOCLOBEMIDE%',4),
('TRAMADOL HYDROCHLORIDE','%PHENELZINE%',4),
('TRAMADOL HYDROCHLORIDE','%TRANYLCYPROMINE%',4),
('TRAMADOL HYDROCHLORIDE','%MOCLOBEMIDE%',4),
('TRAMADOL/PARACETAMOL','%PHENELZINE%',4),
('TRAMADOL/PARACETAMOL','%TRANYLCYPROMINE%',4),
('TRAMADOL/PARACETAMOL','%MOCLOBEMIDE%',4)
"
