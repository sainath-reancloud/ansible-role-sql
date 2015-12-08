Param(
[string]$sqlFeatures,
[string]$installSharedDrive,
[string]$installSharedWOWDrive,
[string]$instanceDrive,
[string]$adminUser,
[string]$adminPassword,
[string]$sqlSysAdminAccts,
[string]$saPassword,
[string]$sqlUserDBLogDrive,
[string]$sqlTempDBDrive,
[string]$newinstanceName,
[string]$primaryReplica
)

$sqlFeatures = '"' + $sqlFeatures + '"'

$scriptargs = @($sqlFeatures, $installSharedDrive, $installSharedWOWDrive, $instanceDrive, $adminUser, $adminPassword, $sqlSysAdminAccts, $saPassword, $sqlUserDBLogDrive, $sqlTempDBDrive, $newinstanceName, $primaryReplica)
"C:\Installers\InstallSQL_dynamic.ps1 $scriptargs" | out-file -filepath C:\Installers\ExecuteSQL.ps1 -width 200


