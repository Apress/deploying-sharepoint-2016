$cred = Get-Credential -UserName "CORP\s-svc" -Message "Managed Account" 
New-SPManagedAccount -Credential $cred 