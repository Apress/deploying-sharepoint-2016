$siteUrl = "https://sharepoint.learn-sp2016.com"
$loginname = "corp\vlad"
$language = "fr-fr"
$input = "https://sharepoint.learn-sp2016.com/Shared%20Documents/DocumentToTranslate.docx"
$output = "https://sharepoint.learn-sp2016.com/Shared%20Documents/DocumentFR.docx"


Add-Type -Path 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll'
Add-Type -Path 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll'
Add-Type -Path 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.Office.Client.TranslationServices.dll'
Write-Host "Please enter password for $($siteUrl):"
$pwd = Read-Host -AsSecureString
$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl)
$ctx.Credentials = New-Object System.Net.NetworkCredential($loginname, $pwd)

$job = New-Object Microsoft.Office.Client.TranslationServices.SyncTranslator($ctx, $language)

$job.OutputSaveBehavior = [Microsoft.Office.Client.TranslationServices.SaveBehavior]::AppendIfPossible

$job.Translate([string]$input, [string]$output);
$ctx.ExecuteQuery()
