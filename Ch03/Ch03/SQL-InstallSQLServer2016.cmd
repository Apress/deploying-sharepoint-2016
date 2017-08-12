[OPTIONS] 
ACTION="Install"
FEATURES=SQLENGINE,REPLICATION,IS
INSTANCENAME="SQLTest"
SQLSVCACCOUNT="corp\s-sql"
SQLSVCPASSWORD="<password>"
SQLSYSADMINACCOUNTS="test\Domain Admins"
IAcceptSQLServerLicenseTerms="True"
QUIET="False"
QUIETSIMPLE="True"
UpdateEnabled="True"
ERRORREPORTING="False"
INSTANCEDIR="M:\Program Files\Microsoft SQL Server"
AGTSVCACCOUNT="corp\s-sql"
AGTSVCPASSWORD="<password>"
AGTSVCSTARTUPTYPE=Automatic
SQLSVCSTARTUPTYPE=Automatic
SQLTEMPDBDIR=T:\Data\
SQLTEMPDBLOGDIR=T:\Data\
SQLUSERDBDIR=M:\Data\
SQLUSERDBLOGDIR=L:\Logs\
ISSVCACCOUNT="corp\s-sql"
ISSVCPASSWORD="<password>"
ISSVCStartupType=Automatic
TCPENABLED=1
BROWSERSVCSTARTUPTYPE=Automatic

@ECHO ON 
D:\Setup.exe /ConfigurationFile=sqlconfig.ini /INDICATEPROGRESS

msiexec /i SharedManagementObjects.msi /passive /norestart 
msiexec /i SQLSysClrTypes.msi /passive /norestart 
msiexec /i PowerShellTools.msi /passive /norestart
