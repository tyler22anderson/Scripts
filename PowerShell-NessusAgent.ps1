net stop "Tenable Nessus Agent"
rd -r "C:\Program Files\Tenable\Nessus Agent" -Force
Start-Process msiexec.exe -Wait -ArgumentList '/I C:\Kaseya\NessusAgent\NessusAgent-7.0.3-x64.msi NESSUS_GROUPS="Windows Workstations" NESSUS_SERVER="cloud.tenable.com:443" NESSUS_KEY=KEY /qn /L*V C:\Kaseya\NessusAgent\Install.log'
