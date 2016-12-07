Mkdir C:\SharePointCluster 
New-SmbShare -EncryptData $true -CachingMode None -Name SharePointCluster -Path C:\SharePointCluster 