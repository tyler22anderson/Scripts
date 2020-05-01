$from = Read-Host "Please enter in the group you want to copy members from"
$to = Read-Host "Please enter in the group you want to copy members to"

Get-ADGroupMember $from | ForEach-Object {

    Add-ADGroupMember -identity $to -Members $_

}