﻿Get-ADUser -filter {Enabled -eq $False} -properties * | Sort-Object DisplayName | Select-Object SamAccountName, whenChanged | Export-CSV C:\users\tanderson\Documents\PowershellOutputs\LastChanged.csv