Get-ADGroupMember -Identity "Okta - All" | Where-Object {$_.SamAccountName -like "*.ctr"} | Select-Object SamAccountName
