[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

          # Build our headers for the API calls
$api = ""
$headers = @{}
$headers.Add("accept","application/json")
#$headers.Add("Content-Type: application/json")
$headers.Add("Authorization", "SSWS $api")

$URL = "https://tenable.okta.com/api/v1/apps/0oa12vsqgaf4YRVvb0i8/users"

$output = Invoke-RestMethod -Uri $URL -Headers $headers -ContentType "application/json" -Verbose | Select-Object "Credentials" 

$output.credntials | Out-File api.csv