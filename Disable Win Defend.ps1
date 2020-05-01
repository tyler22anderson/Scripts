Set-MpPreference -DisableRealtimeMonitoring $true

$val = Get-ItemProperty -Path "hklm:SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware"
if($val.DisbaleAntiSpyware -ne 1)
{
 set-itemproperty -Path "hklm:SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -value 1
}