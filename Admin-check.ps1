Get-ADGroupMember -Identity "Domain Admins" | Select-Object Name,SamAccountName | Export-CSV C:\Users\tanderson\Desktop\domain-admins.csv

Get-ADGroupMember -Identity "Enterprise Admins" | Select-Object Name,SamAccountName | Export-CSV C:\Users\tanderson\Desktop\enterprise-admins.csv
