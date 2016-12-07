$ca = Get-SPWebApplication -IncludeCentralAdministration | ?{$_.IsAdministrationWebApplication -eq $true} $senderAddr = "sharepoint@learn-sp2016.com" 
$replyAddr = "sharepoint@learn-sp2016.com"  
$smtpServer = "mail.learn-sp2016.com" 
$ca.UpdateMailsettings($smtpServer, $senderAddr, $replyAddr, 65001, $true, 587) 

$email = "recipient@learn-sp2016.com" 
$subject = "Email through SharePoint OM" 
$body = "Message body." 

$site = Get-SPSite http://centralAdministrationUrl 
$web = $site.OpenWeb() 
[Microsoft.SharePoint.Utilities.SPUtility]::SendEmail($web,0,0,$email,$subject,$body) 

Send-MailMessage -To "recipient@learn-sp2016.com" -From "sharepoint@learn-sp2016.com" -Subject "Testing Smtp Mail" -Body "Message Body" -SmtpServer "mail.learn-sp2016.com" -UseSsl -Port 587 