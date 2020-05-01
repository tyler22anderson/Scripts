$groupname = 'Druva - HQ'
$ou = 'OU=AMER,OU=TenableUsers,DC=corp,DC=tenablesecurity,DC=com'

Get-ADGroupMember $groupname |
Where-Object {$_.objectclass -eq 'user'} |
ForEach-Object {
    Get-ADUser -Filter "SamAccountName -eq '$($_.SamAccountName)'" -SearchBase $ou
} |
Select-Object Name,SamAccountName