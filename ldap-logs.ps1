[string]$pathToSaveFiles = $PSScriptRoot +"\"
$PSOobj4CSV = @()
$nrOfLogRecordsToProcess = 10000 #
$hostname = $env:computername

$CurrDateTimeStr=[DateTime]::Now.ToString("yyyyMMdd-HHmmss")
$pathToCSV = "$($pathToSaveFiles)$($CurrDateTimeStr)_$($hostname)_ldap_users_IPs.csv"
write-host "Fetching records..."
$eventList = Get-WinEvent -FilterHashtable @{logname=’security’; id=4624,4625}| Select-Object -First $nrOfLogRecordsToProcess

$i=1
$recordCount = $eventList.count
foreach($currEvent in $eventList){
  if (
  ($currEvent.Properties[18].Value -notlike '*10.11.*') -and 
  ($currEvent.Properties[5].Value -notlike '*felipe.moura*') -and 
  ($currEvent.Properties[5].Value -notlike '*alerts-account*') ) {
  
   
    if ($currEvent.Properties[4].Value.Value.Length  -gt 10) { #if sid more then 10 symbols
        $PSOline = [pscustomobject]@{
            'Time'    = $currEvent.TimeCreated.ToString()
            'AccountName'  = $currEvent.Properties[5].Value
            'IP' = $currEvent.Properties[18].Value
        }
    
        #write-host "Record $i from $recordCount time: $($currEvent.TimeCreated.ToString()) AccountName: $($currEvent.Properties[5].Value) IP: $($currEvent.Properties[18].Value)"
        $PSOobj4CSV += $PSOline

    }
    $i++
  }
}
$PSOobj4CSV|export-CSV  $pathToCSV -NoTypeInformation -append  -force
Write-host "Info written to $pathToCSV file" 
