Import-Module ActiveDirectory

function Get-ADUserLastLogon([string]$userName)
{
$dcs = Get-ADDomainController -Filter {Name -like "*"}
$time = 0
foreach($dc in $dcs)
{
$hostname = $dc.HostName
$user = Get-ADUser $userName | Get-ADObject -Properties lastLogon
if($user.LastLogon -gt $time)
{
$time = $user.LastLogon
}
}
$dt = [DateTime]::FromFileTime($time)
Write-Host $username "last logged on at:" $dt }

Get-aduser -filter * | Select SamAccountName | export-csv C:\Test\testlast1.csv -NoTypeInformation
#$users = Get-Content C:\Test\testlast.csv

#Foreach ($u in $users) {
 #    Get-ADUser -filter $u | select SamAccountName,Name,Enabled,DistinguishedName
 #    Get-ADUserLastLogon -UserName "$u"
#}

#Import-csv C:\Test\testlast.csv | ForEach {
#Get-ADUser -Filter {SAMAccountName -eq $_.sam} -Properties SamAccountName,Name,Enabled,DistinguishedName
#}

$users = ForEach ($use in $(Get-Content C:\Test\testlast1.csv)) {

    Get-AdUser $name.Trim() -Properties SamAccountName, Name, Enabled, DistinguishedName
    Get-ADUserLastLogon -UserName "$use.Trim()"
}
    
 #$users |
 #Select-Object SamAccountName,Department,Mail #|
 #Export-CSV -Path C:\Test\testlastoutput.csv -NoTypeInformation

