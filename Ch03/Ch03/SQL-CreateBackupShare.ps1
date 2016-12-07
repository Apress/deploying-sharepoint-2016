New-Item Z:\Backup -ItemType Directory  
New-SmbShare -Name Backup -Path Z:\Backup -FullAccess "Everyone" 
$acl = Get-Acl Z:\Backup 
$acl.SetAccessRuleProtection($true,$false) 
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("CORP\s-sql", "Modify", "ContainerInherit,ObjectInherit", "None", "Allow") 
$acl.AddAccessRule($rule) 
Set-Acl Z:\Backup $acl 