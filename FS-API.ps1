$apikey = "API KEY"
$URI = "https://example.freshservice.com/api/v2/agents.json"
#$cred = Get-Credential
$headers = @{}
$EncodedCredentials = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $APIKey,$null)))
$headers.Add('Authorization', ("Basic {0}" -f $EncodedCredentials))
$Headers.Add('Content-Type', 'application/json')

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-RestMethod -Method Get -Uri $URI -Headers $headers | Convertto-Json -Depth 10

