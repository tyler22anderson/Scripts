#This is a script to automate the gsuite termination process. 

#Input the email of the user
$user = Read-Host -Prompt 'Input the email of the employee being termed: '

#removes all groups
gam user $user delete groups

#Changes the OU
gam update $user org /tenable.com/Suspended

#resets password to random value
gam update user $user password random

