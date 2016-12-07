Connect-SPConfigurationDatabase -DatabaseName Configuration -DatabaseServer spag.corp.learn-sp2016.com -Passphrase (ConvertTo-SecureString "FarmPassphrase1" -AsPlainText -Force) -LocalServerRole Application 
Initialize-SPResourceSecurity 
Install-SPHelpCollection -All 
Install-SPService 
Install-SPFeature -AllExistingFeatures 
Install-SPApplicationContent 

Start-Service SPTimerV4 