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
VALUES ('SERTRALINE','ESCITALOPRAM',5),
('FLUOXETINE','PHENELZINE',5),
('SILDENAFIL','ISOSORBIDE MONONITRATE',5),
('POTASSIUM CHLOR','SPIRONOLACTONE',5),
('CLONIDINE','PROPRANOLOL',5),
('WARFARIN','DIFLUNISAL',5),
('THEOPHYLLINE','CIPROFLOXACIN',5),
('PIMOZIDE','KETOCONAZOLE',5),
('METHOTREXATE','PROBENECID',5),
('BROMOCRIPTINE','PSEUDOEPHEDRINE',5),
('DIGOXIN','QUINIDINE BISULPH',5);"
