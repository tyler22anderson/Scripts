﻿Search-ADAccount -SearchBase "OU=Contractors" -UsersOnly -ResultPageSize 2000 -resultSetSize $null| Select-Object Name, SamAccountName, DistinguishedName, AccountExpirationDate
