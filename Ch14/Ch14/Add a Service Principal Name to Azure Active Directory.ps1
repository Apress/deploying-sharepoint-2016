$msp = Get-MsolServicePrincipal -AppPrincipalId $spoappid
$spns = $msp.ServicePrincipalNames
$spns.Add("$spoappid/$spcn") 
Set-MsolServicePrincipal ‘
-AppPrincipalId $spoappid ‘
-ServicePrincipalNames $spns
