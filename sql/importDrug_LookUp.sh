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
sqlite3 $DB "CREATE TABLE Drug_LookUp
(
    MasterProductID smallint
,   MasterProductCode   varchar(9)
,   MasterProductFullName   varchar(61)
,   BrandName   varchar(30)
,   FormCode    varchar(10)
,   StrengthCode    varchar(21)
,   PackSizeNumber  smallint
,   GenericIngredientName   varchar(30)
,   EthicalSubCategoryName  varchar(21)
,   EthicalCategoryName varchar(16)
,   ManufacturerCode    varchar(9)
,   ManufacturerName    varchar(27)
,   ManufacturerGroupID smallint
,   ManufacturerGroupCode   varchar(43)
,   ChemistListPrice    float
,   ATCLevel5Code   varchar(7)
,   ATCLevel4Code   varchar(5)
,   ATCLevel3Code   varchar(4)
,   ATCLevel2Code   varchar(3)
,   ATCLevel1Code   varchar(2)
)"

sqlite3 -separator $'\t' $DB ".import $DATA/Lookups/Drug_LookUp.txt Drug_LookUp"
