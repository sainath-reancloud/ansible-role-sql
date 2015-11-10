$Prin = New-ScheduledTaskPrincipal -GroupId "BUILTIN\Administrators" -RunLevel Highest

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-NoProfile -WindowStyle Hidden -file "C:\Installers\ExecuteSQL.ps1"'
$trigger = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "SQL_Install" -Description "SQL Installation processs" -User "greatvalleyu\sqlservice" -Password "R3cruit3r"
	
