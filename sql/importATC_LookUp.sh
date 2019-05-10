#!/bin/bash
#===============================================================
# Uses relative directory paths and assumes there is a data
# subfolder in the root of the repo and a raw folder inside that
#
# Creates ATC_LookUp Table
# Imports all ATC_LookUp data into sqlite db
#

DATA=../data/raw
DB=../data/medi.db

# Create ATC_LookUp Table in database
sqlite3 $DB "CREATE TABLE ATC_LookUp(
	ATCLevel1Code	varchar(2)
,	ATCLevel1Name	varchar(63)
,	ATCLevel2Code	varchar(3)
,	ATCLevel2Name	varchar(64)
,	ATCLevel3Code	varchar(4)
,	ATCLevel3Name	varchar(71)
,	ATCLevel4Code	varchar(5)
,	ATCLevel4Name	varchar(92)
,	ATCLevel5Code	varchar(7)
,	ATCLevel5Name	varchar(78)
)"

sqlite3 -separator $'\t' $DB ".import $DATA/Lookups/ATC_LookUp.txt ATC_LookUp"
