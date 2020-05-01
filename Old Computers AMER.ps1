# Gets time stamps for all computers in the domain that have NOT logged in since after specified date 
# Mod by Tilo 2013-08-27 
import-module activedirectory  
$domain = "corp.tenablesecurity.com"  
$DaysInactive = 90  
$time = (Get-Date).Adddays(-($DaysInactive)) 
  
# Get all AD computers with lastLogonTimestamp less than our time 
Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -Properties LastLogonTimeStamp -SearchBase "OU=AMER,OU=TenableComputers,DC=corp,DC=tenablesecurity,DC=com" | 
  
# Output hostname and lastLogonTimestamp into CSV 
select-object Name,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}} | export-csv c:\users\tanderson\desktop\OLD_Computer-AMER.csv -notypeinformation