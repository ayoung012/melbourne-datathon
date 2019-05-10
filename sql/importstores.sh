#!/bin/bash
#===============================================================
# Uses relative directory paths and assumes there is a data
# subfolder in the root of the repo and a raw folder inside that
#
# Creates stores table
# Imports all store data into sqlite db

DATA=../data/raw
DB=../data/medi.db

# Create stores table
sqlite3 $DB "CREATE TABLE stores
(
	Store_ID	smallint
,	StateCode	varchar(3)
,	postcode	varchar(4) 
,	IsBannerGroup	boolean
)"

sqlite3 -separator $'\t' $DB ".import $DATA/Lookups/stores.txt stores"
