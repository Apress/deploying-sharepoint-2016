Add-PSSnapin Microsoft.SharePoint.PowerShell
Import-Module Microsoft.PowerShell.Utility
Import-Module MSOnline -force
Import-Module MSOnlineExtended -force
Import-Module Microsoft.Online.SharePoint.PowerShell –force

$cred=Get-Credential
Connect-MsolService -Credential $cred


$pfxPath = "C:\certs\sts.pfx"
$pfxPass = "pass@word1"
$cerPath = "C:\certs\stscer2.cer"
$spcn = "*.learn-sp2016.com"
$site = Get-SPsite “https://sharepoint.learn-sp2016.com”
$spoappid = "00000003-0000-0ff1-ce00-000000000000"
$spocontextID = (Get-MsolCompanyInformation).ObjectID
$metadataEndpoint = "https://accounts.accesscontrol.windows.net/" + $spocontextID + "/metadata/json/1"

$cer = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 -ArgumentList $pfxPath, $pfxPass
$cer.Import($cerPath)
$binCert = $cer.GetRawCertData()
$credValue = [System.Convert]::ToBase64String($binCert);
New-MsolServicePrincipalCredential -AppPrincipalId $spoappid -Type asymmetric -Usage Verify -Value $credValue
