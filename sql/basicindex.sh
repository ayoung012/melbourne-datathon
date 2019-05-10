#!/bin/sh
#===========================================================
# Builds the basic database structure and fills with medical
# data into <git-repo>/data/medi.db

# Set dir to this directory, regardless of where the script is running
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# cd to current directory for sql scripts to create in the correct directory
cd $DIR

DB=../data/medi.db

# setup basic sql inndexes on transactions table, takes a while
echo Creating indexes on transactions table, takes a while:
echo Patient_ID...
sqlite3 $DB "CREATE INDEX PatientID_Index ON transactions(Patient_ID);"
echo Drug_ID...
sqlite3 $DB "CREATE INDEX DrugID_Index ON transactions(Drug_ID);"
echo Done.

