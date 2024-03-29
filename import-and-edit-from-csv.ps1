#####find user from csv and update
 $promotions = Import-Csv -Delimiter ";" -Path ("C:\manager.csv")

foreach($user in $promotions){

    # Find user
    $ADUser = Get-ADUser -SearchBase 'OU=USERS,DC=test,DC=net' -Filter "UserPrincipalName -eq '$($user.UserPrincipalName)'" -Properties * |
    # edit user
    Set-ADUser -Manager $user.manager -EmailAddress $user.mail -DisplayName $user.displayname -Title $user.title 
} 
