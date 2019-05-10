#!/bin/sh
#===========================================================
# Extra sql tables and databases for enhanced queries
# for adams notebooks in <git-repo>/data/medi.db

# Set dir to this directory, regardless of where the script is running
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# cd to current directory for sql scripts to create in the correct directory
cd $DIR

DB=../data/medi.db

# Run extra SQL setup scripts for adams notebooks
sqlite3 $DB < impliedcondition.sql
sqlite3 $DB < postcodes_geo.sql

#Create indexes
sqlite3 $DB "CREATE INDEX PatientID_Index ON implied_condition(Patient_ID);"
sqlite3 $DB "CREATE INDEX ChronicIllness_Index ON implied_condition(ChronicIllness);"

