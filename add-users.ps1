# Define some static things here
$GITHUB_TOKEN=''
$GITHUB_URL='https://github.eng.tenable.com'
$GITHUB_ORG=''
$USERS_FILE=''

$headers = @{}
$headers.Add("accept","application/vnd.github.v3+json")
$headers.Add("authorization","token $GITHUB_TOKEN")
$headers.Add("cache-control","no-cache")

# Specify Use of TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

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
  $requestURL=$GITHUB_URL + "/api/v3/orgs/$GITHUB_ORG/memberships/$username"
  $result=Invoke-RestMethod -Uri $requestURL -Method PUT -Headers $headers -ContentType "application/json"
  Write-Host "$username added to $GITHUB_ORG"
}

function addUserToOktaGroup($email){
  $adUser=Get-ADUser -Filter {mail -eq $email}
  Add-ADGroupMember -Identity "Okta - GitHub" $adUser
}

foreach($user in Get-Content $USERS_FILE){
  $githubUsername = addUser $user
  Write-Host "User $githubUsername created."
  addUserToOrg $githubUsername
  addUserToOktaGroup $user
}
