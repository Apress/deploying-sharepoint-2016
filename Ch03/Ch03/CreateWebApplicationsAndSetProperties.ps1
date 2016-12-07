Setspn -S HTTP/sharepoint.learn-sp2016.com CORP\s-web 
Setspn -S HTTP/sharepoint-my.learn-sp2016.com CORP\s-web 

$ap = New-SPAuthenticationProvider -DisableKerberos:$false 
New-SPWebApplication -Name "SharePoint" -HostHeader sharepoint.learn-sp2016.com -Port 443 -ApplicationPool "SharePoint" -ApplicationPoolAccount (Get-SPManagedAccount "CORP\s-web") -SecureSocketsLayer:$true -AuthenticationProvider $ap -DatabaseName SharePoint_CDB1 
New-SPWebApplication -Name "SharePoint MySites" -HostHeader sharepoint-my.learn-sp2016.com -Port 443 -ApplicationPool "SharePoint" -SecureSocketsLayer:$true -AuthenticationProvider $ap -DatabaseName SharePoint-My_CDB1 

$wa = Get-SPWebApplication https://sharepoint.learn-sp2016.com 
$wa.Properties["portalsuperuseraccount"] = "i:0#.w|CORP\s-su" 
$wa.Properties["portalsuperreaderaccount"] = "i:0#.w|CORP\s-sr" 
$wa.Update() 

$wa = Get-SPWebApplication https://sharepoint.learn-sp2016.com 
$zp = $wa.ZonePolicies("Default") 
$policy = $zp.Add("i:0#.w|CORP\s-su", "Portal Super User") 
$policyRole = $wa.PolicyRoles.GetSpecialRole("FullControl") 
$policy.PolicyRoleBindings.Add($policyRole) 
$policy = $zp.Add("i:0#.w|CORP\s-sr", "Portal Super Reader") 
$policyRole = $wa.PolicyRoles.GetSpecialRole("FullRead") 
$policy.PolicyRoleBindings.Add($policyRole) 
$wa.Update() 

foreach($server in (Get-SPServer | ?{$_.Role -ne "Invalid" -and $_.Role -ne "Search"})) 
{ 
    Write-Host "Resetting IIS on $($server.Address)..." 
        iisreset $server.Address /noforce 
}  

New-SPManagedPath -RelativeUrl "personal" -WebApplication https://sharepoint-my.learn-sp2016.com 

$wa = Get-SPWebApplication https://sharepoint-my.learn-sp2016.com 
$wa.SelfServiceSiteCreationEnabled = $true 
$wa.Update() 

New-SPSite -Url https://sharepoint.learn-sp2016.com -Template STS#0 -Name "Team Site" -OwnerAlias "CORP\trevor" New-SPSite -Url https://sharepoint-my.learn-sp2016.com -Template SPSMSITEHOST#0 -Name "Team Site" -OwnerAlias "CORP\trevor" 
New-SPSite -Url https://sharepoint.learn-sp2016.com/sites/CTHub -Template STS#0 -Name "Content Type Hub " -OwnerAlias "CORP\trevor" 
Set-SPMetadataServiceApplication -Identity "Managed Metadata Service" -HubUri https://sharepoint.learn-sp2016.com/sites/cthub 
New-SPSite -Url https://sharepoint.learn-sp2016.com/sites/search -Template SRCHCEN#0 -Name "Search Center" -OwnerAlias "CORP\trevor" 
$sa = Get-SPEnterpriseSearchServiceApplication $sa.SearchCenterUrl = "https://sharepoint.learn-sp2016.com/sites/search/Pages" 
$sa.Update() 

$sa = Get-SPServiceApplication | ?{$_.TypeName -eq "User Profile Service Application"} 
Set-SPProfileServiceApplication -Identity $sa -MySiteHostLocation https://sharepoint-my.learn-sp2016.com 