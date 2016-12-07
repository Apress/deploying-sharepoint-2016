$ssasConnection = New-Object System.Data.OleDb.OleDbConnection
$ssasConnection.ConnectionString = "Provider=MSOLAP;Data Source=LSSASS01\PowerPivot2016"
$ssasConnection.Open()

$guid = New-Object System.Guid "3444B255-171E-4cb9-AD98-19E57888A75F"
$restrictionList = @($null, $null, $null, $null, $null, $null, $null, "Administrators")
$schemaTable = $ssasConnection.GetOleDbSchemaTable($guid, $restrictionList); 
[xml]$admins = $schemaTable.METADATA

$ssasConnection.Close()

$admins.Role.Members.Member
