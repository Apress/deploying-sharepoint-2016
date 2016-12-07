BACKUP DATABASE Configuration TO DISK = N'Z:\Backup\Configuration.bak'; 
BACKUP LOG Configuration TO DISK = N'Z:\Backup\Configuration_Log.bak'; 
ALTER AVAILABILITY GROUP SPHADR ADD DATABASE Configuration; 

RESTORE DATABASE Configuration FROM DISK = N'\\LSSQL02\Backup\Configuration.bak' WITH NORECOVERY; 
RESTORE LOG Configuration FROM DISK = N'\\LSSQL02\Backup\Configuration_Log.bak' WITH NORECOVERY; 
ALTER DATABASE Configuration SET HADR Availability GROUP = SPHADR; 