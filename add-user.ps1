<#
.SYNOPSIS
This script adds a user to GitHub Enterprise and puts them in a specified org

.EXAMPLE
./test-args.ps1 jlancaster@tenable.com ITS

.DESCRIPTION
You will need to generate an access token for your account with the following permissions and their child permissions:
  -admin:org
  -user
  -site_admin

You can create this token at https://github.eng.tenable.com/settings/tokens

#>

# Define our parameters
[cmdletbinding(DefaultParameterSetName = 'AddUser', SupportsShouldProcess = $true)]
param(
  [Parameter(ParameterSetName = 'setup')]
  [switch]
  $setup,

  [Parameter(ParameterSetName='AddUser',ValuefromPipeline=$true,Position=0)]
  [string] $user = "",

  [Parameter(ParameterSetName='AddUser',ValuefromPipeline=$true,Position=1)]
  [string] $org = ""

)

# Static things
$GITHUB_URL='https://github.eng.tenable.com'

# Specify Use of TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

If($setup){
  Write-Host "Setting us up the bomb..."
  Install-Module -Name "CredentialManager"
  $target = "GitHub Enterprise Admin Token"
  $token = Read-host "Please enter your access token" -AsSecureString
  New-StoredCredential -Target $target -SecurePassword $token -Persist LocalMachine -Type Generic | Out-Null
  exit
}Else{
  # Get our API token and validate that it exists
  $token = (Get-StoredCredential -Target "GitHub Enterprise Admin Token" -AsCredentialObject).Password
  if (-Not $token){
    Write-Host "Your API token is not configured. Please run 'add-user.ps1 -setup' to configure this first"
    exit
  }

  # Build our headers for the API calls
  $headers = @{}
  $headers.Add("accept","application/vnd.github.v3+json")
  $headers.Add("authorization","token $token")
  $headers.Add("cache-control","no-cache")

  function addUser($user){
    # Build the body of our request
    $username=$user.split("@")[0]
    $email=$user
    $body = @{}
    $body.Add("login","$username")
    $body.Add("email","$email")

    # Build the request URL
    $requestURL=$GITHUB_URL + "/api/v3/admin/users"

    # Add the user and store the results
    $result=Invoke-RestMethod -Uri $requestURL -Method POST -Body ($body|ConvertTo-Json) -Headers $headers -ContentType "application/json"

    # Get our GitHub Friendly username
    return $result.login
  }

  function addUserToOrg($username){
    # Add our new user to the specified org
    $requestURL=$GITHUB_URL + "/api/v3/orgs/$org/memberships/$username"
    $result=Invoke-RestMethod -Uri $requestURL -Method PUT -Headers $headers -ContentType "application/json"
    Write-Host "$username added to $org"
  }

  function addUserToOktaGroup($email){
    # Add our user to the Okta group for GitHub Enterprise
    # We query for the user based on email address
    $adUser=Get-ADUser -Filter {mail -eq $email}
    Add-ADGroupMember -Identity "Okta - GitHub" $adUser
  }

    $githubUsername = addUser $user
    Write-Host "User $githubUsername created."
    addUserToOrg $githubUsername
    addUserToOktaGroup $user
}
