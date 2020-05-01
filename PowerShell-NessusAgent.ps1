net stop "Tenable Nessus Agent"
rd -r "C:\Program Files\Tenable\Nessus Agent" -Force
Start-Process msiexec.exe -Wait -ArgumentList '/I C:\Kaseya\NessusAgent\NessusAgent-7.0.3-x64.msi NESSUS_GROUPS="Windows Workstations" NESSUS_SERVER="cloud.tenable.com:443" NESSUS_KEY=ba6ffa6df5b8a6cd7e10a9a6f806aaa9075ad1e81e534f10fb43b197ecb069f6 /qn /L*V C:\Kaseya\NessusAgent\Install.log'