$sa = Get-SPEnterpriseSearchServiceApplication
$si = Get-SPEnterpriseSearchServiceInstance | ?{$_.Server -match "LSSPSR01"}
$clone = $sa.ActiveTopology.Clone()
New-SPEnterpriseSearchAdminComponent -SearchTopology $clone -SearchServiceInstance $si
New-SPEnterpriseSearchContentProcessingComponent -SearchTopology $clone -SearchServiceInstance $si
New-SPEnterpriseSearchAnalyticsProcessingComponent -SearchTopology $clone -SearchServiceInstance $si
New-SPEnterpriseSearchCrawlComponent -SearchTopology $clone -SearchServiceInstance $si
New-SPEnterpriseSearchIndexComponent -SearchTopology $clone -SearchServiceInstance $si -IndexPartition 0
New-SPEnterpriseSearchQueryProcessingComponent -SearchTopology $clone -SearchServiceInstance $si
New-SPEnterpriseSearchAdminComponent -SearchTopology $clone -SearchServiceInstance $si2
New-SPEnterpriseSearchAnalyticsProcessingComponent -SearchTopology $clone -SearchServiceInstance $si2
New-SPEnterpriseSearchContentProcessingComponent -SearchTopology $clone -SearchServiceInstance $si2
New-SPEnterpriseSearchCrawlComponent -SearchTopology $clone -SearchServiceInstance $si2
New-SPEnterpriseSearchIndexComponent -SearchTopology $clone -SearchServiceInstance $si2 -IndexPartition 0 -RootDirectory F:\SearchIndex\0
New-SPEnterpriseSearchQueryProcessingComponent -SearchTopology $clone -SearchServiceInstance $si2
$clone.Activate()

foreach($topo in (Get-SPEnterpriseSearchTopology -SearchApplication $sa |
?{$_.State -eq "Inactive"}))
{
Remove-SPEnterpriseSearchTopology -Identity $topo -Confirm:$false
}
