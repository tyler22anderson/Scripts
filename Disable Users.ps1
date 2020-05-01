#Script created by Tyler Anderson on 5/18/2018
#
#Script is used to disable users and remove on of their groups from AD.
#
#Script will also move the user to the Disabled Users OU

#Gets username needed to be disabled
$username = Read-Host -Prompt 'Enter the username which needs to be disabled'

#Gets the primary group ID for Z Disabled Users
$disabledUsers = (Get-ADGroup "Z Disabled Users" -Properties primaryGroupToken).primaryGroupToken

#Gets the primary group ID for Domain Users
$domainUsers = (Get-ADGroup "Domain Users" -Properties primaryGroupToken).primaryGroupToken 

#Gets the groups the user is a member of
$userGroups = Get-ADPrincipalGroupMembership $username | select name

#adds the user to Z Disabled Users
Add-ADGroupMember -identity 'Z Disabled Users' -members $username -Confirm:$false

#Changes the primary group for the user
Get-ADUser $username -Properties * | Set-ADUser -Replace @{primaryGroupID= $disabledUsers} -Confirm:$false

#Removes each group
foreach ($group in $userGroups) {
    Remove-ADGroupMember -Identity $group.name -Members $username -Confirm:$false
}

#disabled the account
Disable-ADAccount -Identity $username -Confirm:$false

#moves the account
Get-ADUser $username | Move-ADObject -TargetPath "OU=Disabled Users,DC=corp,DC=tenablesecurity,DC=com" -Confirm:$false
