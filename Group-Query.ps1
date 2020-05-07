$groupname = 'Druva - HQ'
$ou = 'OU=AMER'

Get-ADGroupMember $groupname |
Where-Object {$_.objectclass -eq 'user'} |
ForEach-Object {
    Get-ADUser -Filter "SamAccountName -eq '$($_.SamAccountName)'" -SearchBase $ou
} |
Select-Object Name,SamAccountName
