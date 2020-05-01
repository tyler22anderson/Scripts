# Check if it's a valid username, and if it's not, bail out

$usernames = (Import-csv C:\Users\Tanderson\Documents\jenkins.csv).Users

Foreach ($username in $usernames) {

$validUsername = Get-ADUser -LDAPFilter "(sAMAccountName=$username)"
If ($validUsername -eq $Null){
    Write-Output "$username does not exist in AD"
    }
Else {
    Write-Output "$username exists"
    #Add-ADgroupMember "Okta-Jenkins" $username
    #Add-ADGroupMember "devRoles_sre_cd_engineer" $username
    }
}