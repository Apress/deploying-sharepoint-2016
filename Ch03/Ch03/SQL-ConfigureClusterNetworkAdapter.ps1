Get-ClusterNetwork | fl * 
$clusadapt = Get-ClusterNetwork -Cluster LSSPSQLClus -Name "Cluster Network 1" 
$clusadap.Name = "Intranet" 
$clusadapt = Get-ClusterNetwork -Cluster LSSPSQLClus -Name "Cluster Network 2" 
$clusadap.Name = "Heartbeat" 