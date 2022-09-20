# get active group members and export to CSV

$grupos= Get-AdGroupMember -Identity "--GROUP--" | get-aduser  -Properties * | Where { $_.Enabled -eq $True}

foreach ($grupo in $grupos){
        $grupos_dados = New-Object -TypeName psobject
        
        ##attributes
        $grupos_dados | Add-Member -Type NoteProperty -Name 'USERNAME' -Value $grupo.samaccountname
        $grupos_dados | Add-Member -Type NoteProperty -Name 'EMAIL_ADDRESS' -Value $grupo.mail
        $grupos_dados | Add-Member -Type NoteProperty -Name 'GIVEN_NAME' -Value $grupo.GivenName
        $grupos_dados | Add-Member -Type NoteProperty -Name 'FAMILY_NAME' -Value $grupo.sn
        $grupos_dados | Add-Member -Type NoteProperty -Name 'TITLE' -Value $grupo.title
        $grupos_dados | Add-Member -Type NoteProperty -Name 'CanonicalName' -Value $grupo.CanonicalName
        
        ##file
        $grupos_dados | Export-CSV -Path "c:\.....\file.csv" -Append -Encoding UTF8 -NoType -Delimiter "|" 
}
