Param(
[string]$sqlServer,
[string]$user,
[string]$password
)

$wmiName = (Get-WmiObject –namespace root\Microsoft\SqlServer\ReportServer  –class __Namespace).Name

$rsConfig = Get-WmiObject –namespace "root\Microsoft\SqlServer\ReportServer\$wmiName\v11\Admin" -class MSReportServer_ConfigurationSetting -filter "InstanceName='MSSQLSERVER'"
$rsConfig.SetDatabaseConnection($sqlServer, "ReportServer", 0, $user, $password)

$rsConfig.SetVirtualDirectory("ReportServerWebService","ReportServer",0)
$rsConfig.ReserveURL("ReportServerWebService","http://+:80",0)
$rsConfig.SetVirtualDirectory("ReportManager","Reports",0)
$rsConfig.ReserveURL("ReportManager","http://+:80",0)

"Y" > C:\Installers\y.txt
$DOSCommandString = "RSKeyMgmt.exe -d -i MSSQLSERVER < y.txt"
$DOSCommandString | out-file -file "C:\Installers\ResetRSKeys.bat" -encoding ASCII
C:\Installers\ResetRSKeys.bat

$rsConfig.SetServiceState($false,$false,$false)
$rsConfig.SetServiceState($true,$true,$true)
