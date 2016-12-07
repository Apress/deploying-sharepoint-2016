[OPTIONS] 
ACTION="Install" FEATURES=SQLENGINE,REPLICATION,IS INSTANCENAME="MSSQLSERVER" SQLSVCACCOUNT=CORP\s-sql SQLSVCPASSWORD="<Password>" SQLSYSADMINACCOUNTS="CORP\Domain Admins" IAcceptSQLServerLicenseTerms="True" QUIET="True" UpdateEnabled="False" ERRORREPORTING="False" INSTANCEDIR="M:\\Program Files\\Microsoft SQL Server\\" AGTSVCACCOUNT=CORP\s-sql AGTSVCPASSWORD="<Password>" AGTSVCSTARTUPTYPE=Automatic SQLSVCSTARTUPTYPE=Automatic SQLTEMPDBDIR=T:\Data\ SQLTEMPDBLOGDIR=T:\Data\ SQLUSERDBDIR=M:\Data\ SQLUSERDBLOGDIR=L:\Logs\ ISSVCACCOUNT=CORP\s-sql ISSVCPASSWORD="<Password>" ISSVCStartupType=Automatic TCPENABLED=1 BROWSERSVCSTARTUPTYPE=Automatic 

@ECHO OFF 
set CDRoot=D: 
@ECHO ON 
%CDRoot%\Setup.exe /ConfigurationFile=sqlconfig.ini /Q 

msiexec /i SharedManagementObjects.msi /passive /norestart 
msiexec /i SQLSysClrTypes.msi /passive /norestart 
msiexec /i PowerShellTools.msi /passive /norestart 