##users and managers
 Get-ADUser -Filter * -Properties * -SearchBase "OU=USERS,OU=COMPANY,DC=test,DC=net" | 
Select-Object SamAccountName,@{n='Manager';e={(Get-ADUser $_.manager).SamAccountName}} | 
export-csv "C:\export.csv" -Append -Encoding UTF8 -NoType -Delimiter "|"
