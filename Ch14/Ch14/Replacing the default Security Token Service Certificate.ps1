$pfxPath = "C:\certs\sts.pfx"
$pfxPass = "pass@word1"
$stsCertificate = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 $pfxPath, $pfxPass, 20
Set-SPSecurityTokenServiceConfig -ImportSigningCertificate $stsCertificate -confirm:$false
iisreset 
net stop SPTimerV4 
net start SPTimerV4
