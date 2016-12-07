$ErrorActionPreference = "Stop" 
$ra = ConvertTo-SecureString "Password1!" -AsPlainText -Force 
$certThumbprint = '3CF5BA40F795373E77A63A76F89C972EB7D6B81D' 
$mgUsers = 's-wfm@CORP','trevor@CORP' 
$baseConnectionString = 'Data Source=gensql.corp.learn-sp2016.com;Integrated Security=True;Encrypt=False;Initial Catalog=' 
$sbConnString = $baseConnectionString + 'SbManagementDB;' 
$wfConnString = $baseConnectionString + 'WFManagementDB;' 

Add-Type -Path "C:\Program Files\Workflow Manager\1.0\Workflow\Artifacts\Microsoft.ServiceBus.dll" 

Write-Host -ForegroundColor Yellow "Adding host to Service Bus Farm..." 

Add-SBHost -SBFarmDBConnectionString $sbConnString -RunAsPassword $ra -EnableFirewallRules $true -Verbose; 
$ErrorActionPreference = "Continue" 

Try 
{ 
    New-SBNamespace -Name 'WorkflowDefaultNamespace' -AddressingScheme 'Path' ` 
   -ManageUsers $mgUsers -Verbose; 
    Start-Sleep -s 90 
} 
Catch [system.InvalidOperationException] {} 

try 
{ 
    $SBClientConfiguration = Get-SBClientConfiguration -Namespaces 'WorkflowDefaultNamespace' -Verbose; 
} 
Catch [system.InvalidOperationException] {} 
Write-Host -ForegroundColor Yellow "Adding host to Workflow Manager Farm..." 

Add-WFHost -WFFarmDBConnectionString $wfConnString -RunAsPassword $ra -EnableFirewallRules $true ` 
    -SBClientConfiguration $SBClientConfiguration -Verbose; 
Write-Host -ForegroundColor Green "Completed." 
$ErrorActionPreference = "Continue"  