#This script is for when a user goes from a contractor to a full employee
#Script created by Tyler Anderson 7/30/2019

#Gets the contractor that needs to be updated and puts it into a variable
$contractor = Read-Host "Please enter the contractor you want to be changed to a full employee"

#Checks to see if the username ends with .ctr
If ($contractor -like "*.ctr")

    {

    #Changes the users OU to the AMER OU
    Get-ADUser $contractor | Move-ADObject -TargetPath 'OU=AMER,OU=TenableUsers,DC=corp,DC=tenablesecurity,DC=com'

    #Trims the username of the .ctr and stores it in a new variable
    $NewSamName = $contractor -split ".ctr"

    #Sets email address variable
    $tenable = "@tenable.com"

    #Combines the username with @tenable.com to make the email address
    $email = "$NewSamName" + "$tenable"

    #Removes the space between variables
    $email -replace '\s',''

    #Changes the contractors username to the trimed username and sets e-mail address
    Get-ADUser -Identity $contractor | Set-ADUser -SamAccountName $NewSamName -PassThru | Set-ADUser -UserPrincipalName $NewSamName -PassThru | Set-ADUser -EmailAddress $email -PassThru

    #Prints the new username
    Write-Host "The new user name is $NewSamName"

    }

Else

{

Write-Host "Username does not include .ctr"

}

