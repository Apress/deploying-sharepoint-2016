$ErrorActionPreference = "Stop" 
$ra = ConvertTo-SecureString "Password1!" -AsPlainText -Force 
$certThumbprint = '3CF5BA40F795373E77A63A76F89C972EB7D6B81D' 
$admins = 'BUILTIN\Administrators' 
$svcAcct = 's-wfm@CORP' 
$mgUsers = 's-wfm@CORP','trevor@CORP','vlad@CORP' 
$baseConnectionString = 'Data Source=gensql.corp.learn-sp2016.com;Integrated Security=True;Encrypt=False;Initial Catalog=' 
$sbConnString = $baseConnectionString + 'SbManagementDB;' 
$sbGateConnString = $baseConnectionString + 'SbGatewayDatabase;' 
$sbMsgConnString = $baseConnectionString + 'SBMessageContainer01;' 
$wfConnString = $baseConnectionString + 'WFManagementDB;' 
$wfInstConnString = $baseConnectionString + 'WFInstanceManagementDB;' 
$wfResConnString = $baseConnectionString + 'WFResourceManagementDB;' 

Add-Type -Path "C:\Program Files\Workflow Manager\1.0\Workflow\Artifacts\Microsoft.ServiceBus.dll" 


Write-Host -ForegroundColor Yellow "Creating Service Bus farm..." 

New-SBFarm -SBFarmDBConnectionString $sbConnString ` 
    -InternalPortRangeStart 9000 -TcpPort 9354 -MessageBrokerPort 9356 -RunAsAccount $svcAcct -AdminGroup $admins ` 
    -GatewayDBConnectionString $sbGateConnString -FarmCertificateThumbprint $certThumbprint ` 
    -EncryptionCertificateThumbprint $certThumbprint -MessageContainerDBConnectionString $sbMsgConnString 

Write-Host -ForegroundColor Yellow "Creating Workflow Manager farm..." 

New-WFFarm -WFFarmDBConnectionString $wfConnString ` 
    -RunAsAccount $svcAcct -AdminGroup $admins -HttpsPort 12290 -HttpPort 12291 ` 
    -InstanceDBConnectionString $wfInstConnString ` 
    -ResourceDBConnectionString $wfResConnString -OutboundCertificateThumbprint $certThumbprint ` 
    -SslCertificateThumbprint $certThumbprint ` 
    -EncryptionCertificateThumbprint $certThumbprint 

Write-Host -ForegroundColor Yellow "Adding host to Service Bus farm..." 
Add-SBHost -SBFarmDBConnectionString $sbConnString -RunAsPassword $ra -EnableFirewallRules $true 

Try 
{ 
    New-SBNamespace -Name 'WorkflowDefaultNamespace' -AddressingScheme 'Path' -ManageUsers $mgUsers 
    Start-Sleep -s 90 
} 
Catch [system.InvalidOperationException] {} 
$SBClientConfiguration = Get-SBClientConfiguration -Namespaces 'WorkflowDefaultNamespace' 
Write-Host -ForegroundColor Yellow "Adding host to Workflow Manager Farm..." 

Add-WFHost -WFFarmDBConnectionString $wfConnString -RunAsPassword $ra -EnableFirewallRules $true ` 
    -SBClientConfiguration $SBClientConfiguration 
Write-Host -ForegroundColor Green "Completed." 
$ErrorActionPreference = "Continue" 