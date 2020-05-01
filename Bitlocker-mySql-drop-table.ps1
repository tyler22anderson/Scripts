# Get all Bitlocker Objects from AD

Import-Module Mysqlcmdlets
Connect-MySqlServer -Server 192.168.206.143 -Credential (Get-Credential)


$BitLockerObjects = Get-ADObject -Filter { objectclass -eq 'msFVE-RecoveryInformation' }

#refreshing the table for testing
Invoke-MySqlQuery -Query "use powershelltest"
Invoke-MySqlQuery -Query "drop table bitlocker"
Invoke-MySqlQuery -Query "create table bitlocker (computer_name varchar(15), bitlocker_key varchar(255), created_date varchar(25))"

  #Get the system name for each object
  foreach ($System in $BitLockerObjects) {
    $System = $System.DistinguishedName
    $System = $System.Split(',')
    $System = $System[1]
    $System = $System.Split('=')
    $System = $System[1]
    $Computer = Get-ADComputer -Filter {Name -eq $System}

    #Get all Bitlocker objects that exist for the provided system name and print out some info about them
    $BitLockerRecoveryKey = Get-ADObject -Filter { objectclass -eq 'msFVE-RecoveryInformation' } -SearchBase $Computer.DistinguishedName -Properties *
       foreach ($key in $BitLockerRecoveryKey) {
        #$ComputerExists = Invoke-MySqlQuery -query {"select * from powershelltest.bitlocker where computer_name='{0}' and bitlocker_key='{1}'" -f $System, $key.'msFVE-RecoveryPassword'}
        #If ($ComputerExists -eq $null) {
            Invoke-MySqlQuery –Query "set sql_mode='no_backslash_escapes'" , {“insert into powershelltest.bitlocker(computer_name, bitlocker_key, created_date) values ('{0}', '{1}', '{2}')” –f $System, $key.'msFVE-RecoveryPassword', $key.Created}
            Write-Host "Computer Name:"$System
        #}

       


       #Write-Host "Computer Name:"$System
       #Write-Host "Bitlocker Recovery Key:"$key.'msFVE-RecoveryPassword'
       #Write-Host "Created: "$key.Created
       }
     }