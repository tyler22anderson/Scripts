﻿#LOAD AD MODULE
Try
{
  Import-Module ActiveDirectory -ErrorAction Stop
}

#Gets usernames and phone numbers for each area. Did this because of the contractors. Each have their own variables.
$extensionUS = get-aduser -filter * -searchbase "OU=AMER,OU=TenableUsers,DC=corp,DC=tenablesecurity,DC=com" -properties Telephonenumber | Select-Object sAMAccountName, telephonenumber
$extensionEMEA = get-aduser -filter * -searchbase "OU=EMEA,OU=TenableUsers,DC=corp,DC=tenablesecurity,DC=com" -properties Telephonenumber | Select-Object sAMAccountName, telephonenumber
$extensionAPAC = get-aduser -filter * -searchbase "OU=APAC,OU=TenableUsers,DC=corp,DC=tenablesecurity,DC=com" -properties Telephonenumber | Select-Object sAMAccountName, telephonenumber

#Combining each variable into one.

$extension = $extensionUS
$extension += $extensionEMEA
$extension += $extensionAPAC

$extension

