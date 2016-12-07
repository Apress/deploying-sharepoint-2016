$wa = Get-SPWebApplication https://sharepoint.learn-sp2016.com 
$wa.HttpStrictTransportSecuritySettings.IsEnabled = $true 
$wa.HttpStrictTransportSecuritySettings.MaxAge = 31536000 
$wa.Update() 