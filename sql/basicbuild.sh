#!/bin/sh
#===========================================================
# Builds the basic database structure and fills with medical
# data into <git-repo>/data/medi.db

# Set dir to this directory, regardless of where the script is running
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# cd to current directory for sql scripts to create in the correct directory
cd $DIR

# Run basic SQL setup scripts
echo Importing Patients...
./importpatients.sh
echo Importing Transactions... Do something productive, this ones a whoppa, takes 5-10 mins
./importtransactions.sh
echo Importing ChronicIllness...
./importChronicIllness_LookUp.sh
echo Importing Stores...
./importstores.sh
echo Importing Drugs...
./importDrug_LookUp.sh
echo Importing ATC...
./importATC_LookUp.sh
echo Done.
