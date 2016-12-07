#For Setting SharePoint to use the IRM SCP
$webSvc = [Microsoft.SharePoint.Administration.SPWebService]::ContentService 
$webSvc.IrmSettings.IrmRMSEnabled = $true 
$webSvc.IrmSettings.IrmRMSUseAD = $true 
$webSvc.Update() 

#To explicitly set IRM Server
$webSvc = [Microsoft.SharePoint.Administration.SPWebService]::ContentService 
$webSvc.IrmSettings.IrmRMSEnabled = $true 
$webSvc.IrmSettings.IrmRMSUseAD = $false 
$webSvc.IrmSettings.IrmRMSCertServer = "https://rms.learn-sp2016.com" 
$webSvc.Update() 