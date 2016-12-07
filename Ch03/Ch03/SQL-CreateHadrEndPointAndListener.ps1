Invoke-SqlCmd "CREATE DATABASE AOTemp;" -ServerInstance LSSQL01 
New-SqlHADREndpoint -Path SQLSERVER:SQL\LSSQL01\DEFAULT -Name SPHADR -Port 5022 -Encryption Required 
New-SqlHADREndpoint -Path SQLSERVER:\SQL\LSSQL02\DEFAULT -Name SPHADR -Port 5022 -Encryption Required 
Set-SqlHADREndpoint -Path SQLSERVER:\SQL\LSSQL01\DEFAULT\Endpoints\SPHADR -State Started 
Set-SqlHADREndpoint -Path SQLSERVER:\SQL\LSSQL02\DEFAULT\Endpoints\SPHADR -State Online 
Backup-SqlDatabase -Database AOTemp -BackupFile Z:\Backup\AOTemp.bak -ServerInstance LSSQL01 -NoRecovery 
Backup-SqlDatabase -Database AOTemp -BackupFile Z:\Backup\AOTemp_Log.bak -ServerInstance LSSQL01 -BackupAction Log -NoRecovery 

$replicaA = New-SqlAvailabilityReplica -Name LSSQL01 -EndpointUrl TCP://LSSQL01.corp.learn-sp2016.com:5022 -FailoverMode Automatic -AvailabilityMode SynchronousCommit -Version 12 -AsTemplate 
$replicaB = New-SqlAvailabilityReplica -Name LSSQL02 -EndpointUrl TCP://LSSQL02.corp.learn-sp2016.com:5022 -FailoverMode Automatic -AvailabilityMode SynchronousCommit -Version 12 -AsTemplate 
Cd SQL\LSSQL01\DEFAULT 
New-SqlAvailabilityGroup -Name SPHADR AvailabilityReplicas ($replicaA, $replicaB) -Database AOTemp 
Cd SQLSERVER:\SQL\LSSQL02\DEFAULT 
Join-SqlAvailabilityGroup -Name SPHADR 

New-SqlAvailabilityGroupListener -Name SPAG -StaticIp "172.16.0.23/255.255.0.0" -Path SQLSERVER:\SQL\LSSQL01\DEFAULT\AvailabilityGroups\SPHADR 

Cd SQLSERVER:\SQL\LSSQL02\DEFAULT 
Restore-SqlDatabase AOTemp -ServiceInstance LSSQL02 -BackupFile \\LSSQL01\Backup\AOTemp.bak -NoRecovery 
Restore-SqlDatabase AOTemp -ServiceInstance LSSQL02 -BackupFile \\LSSQL01\Backup\AOTemp_Log.bak -RestoreAction Log 
$ag = Get-Item SQLSERVER:\SQL\LSSQL02\DEFAULT\AvailabilityGroups\SPHADR 
Add-SqlAvailabilityDatabase -InputObject $ag -Database AOTemp 