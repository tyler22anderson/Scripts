$groupfrom = Read-Host "Type the AD group you want to copy the users from exactly how it looks in AD"
$groupto = Read-Host "Type the AD group you want to copy the users to exactly how it looks in AD"


$users = Get-ADGroupMember -Identity $groupfrom | Select-Object SamAccountName

ForEach ($user in $users) {
    
    Add-ADGroupMember -Identity $groupto $user.SamAccountName

    }