Rename-Computer -NewName <value> -Restart 
$cred = Get-Credential #User credentials to join the computer to the domain 
Add-Computer -Credential $cred -DomainName CORP 
Restart-Computer 