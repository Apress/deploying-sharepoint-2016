Install-WindowsFeature Failover-Clustering,NET-Framework-Core -IncludeManagementTools 
Test-Cluster -Node LSSQL01,LSSQL02 
New-Cluster -Name "LSSPSQLClus" -Node LSSQL01,LSSQL02 -StaticAddress 172.16.0.22 -IgnoreNetwork 192.168.5.0/24 -NoStorage 