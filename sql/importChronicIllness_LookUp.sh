#===============================================================
# Uses relative directory paths and assumes there is a data
# subfolder in the root of the repo and a raw folder inside that
#
# Creates ChronicIllness_Lookup table
# Imports all ChronicIllness_LookUp data into sqlite db

DATA=../data/raw
DB=../data/medi.db

# Create ChronicIllness_LookUp Table in database
sqlite3 $DB "CREATE TABLE ChronicIllness_LookUp
(
    ChronicIllness  varchar(44)
,   MasterProductID smallint
,   MasterProductFullName   varchar(59)
)"

sqlite3 -separator $'\t' $DB ".import $DATA/Lookups/ChronicIllness_LookUp.txt ChronicIllness_LookUp"
