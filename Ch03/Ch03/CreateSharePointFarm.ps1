New-SPConfigurationDatabase -DatabaseName Configuration -AdministrationContentDatabaseName Administration -DatabaseServer spag.corp.learn-sp2016.com -Passphrase (ConvertTo-SecureString "FarmPassphrase1" -AsPlainText -Force) -FarmCredentials (Get-Credential) -LocalServerRole Application  

Setspn -S HTTP/ca.corp.learn-sp2016.com CORP\s-farm 
New-SPCentralAdministration -Port 443 -WindowsAuthProvider Kerberos -SecureSocketsLayer:$true 

Set-SPAlternateUrl -Identity https://lsspap01 -Url https://ca.corp.learn-sp2016.com 
Remove-SPAlternateUrl -Identity https://lsspap01 

Initialize-SPResourceSecurity 
Install-SPFeature -AllExistingFeatures 
Install-SPService 
Install-SPHelpCollection -All 