#!/bin/bash
#===============================================================
# Uses relative directory paths and assumes there is a data
# subfolder in the root of the repo and a raw folder inside that
#
# Creates patients table
# Imports all patients data into sqlite db

DATA=../data/raw
DB=test.db

# Create Patients table in database
sqlite3 $DB "CREATE TABLE patients
(
	Patient_ID	int
,	gender	varchar(1)
,	year_of_birth	smallint
,	postcode	varchar(4) 
)"

sqlite3 -separator $'\t' $DB ".import $DATA/Lookups/patients.txt patients"
