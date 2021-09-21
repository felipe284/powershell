#####export users from some OU
  $grupos = Get-ADUser -SearchBase "OU=USER,DC=test,DC=net" -Filter * -Properties * | Where { $_.Enabled -eq $True} | Select-Object GivenName, sn, samaccountname, mail, company, division, department, title, CanonicalName
foreach ($grupo in $grupos){
        $grupos_dados = New-Object -TypeName psobject
        $grupos_dados | Add-Member -Type NoteProperty -Name 'name' -Value $grupo.GivenName
        $grupos_dados | Add-Member -Type NoteProperty -Name 'lastname' -Value $grupo.sn
        $grupos_dados | Add-Member -Type NoteProperty -Name 'User name' -Value $grupo.samaccountname
        $grupos_dados | Add-Member -Type NoteProperty -Name 'email' -Value $grupo.mail
        $grupos_dados | Add-Member -Type NoteProperty -Name 'bu' -Value $grupo.company
        $grupos_dados | Add-Member -Type NoteProperty -Name 'division' -Value $grupo.division
        $grupos_dados | Add-Member -Type NoteProperty -Name 'department' -Value $grupo.department
        $grupos_dados | Add-Member -Type NoteProperty -Name 'title' -Value $grupo.title
        $grupos_dados | Add-Member -Type NoteProperty -Name 'CanonicalName' -Value $grupo.CanonicalName
        $grupos_dados | Export-CSV -Path "c:\internal-users-zap.csv" -Append -Encoding UTF8 -NoType -Delimiter "|" 
}
