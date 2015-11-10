### Example Usage ###

# "ECRM\Administrator" "-=-9L=iRPj" "SQLENGINE,FULLTEXT,RS,SSMS,ADV_SSMS" "C" "C" "C" "ECRM\Administrator" "-=-9L=iRPj" "ECRM\Administrator" "-=-9L=iRPj" "C" "C" "DevOps2"
# "ECRM\Administrator" "-=-9L=iRPj" "SQL,Tools" "C" "C" "C" "ECRM\Administrator" "-=-9L=iRPj" "ECRM\Administrator" "-=-9L=iRPj" "C" "C" "MSSQLSERVER"
# "C" indicates take the default value

#####################

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
[string]$newinstanceName
)

Copy-S3Object -BucketName ellucian-ecrm -Key iso/SQLServer2012SP1-FullSlipstream-ENU-x64.iso -LocalFile C:\Installers\SQLServer2012SP1-FullSlipstream-ENU-x64.iso

$scriptargs = @($sqlFeatures, $installSharedDrive, $installSharedWOWDrive, $instanceDrive, $adminUser, $adminPassword, $sqlSysAdminAccts, $saPassword, $sqlUserDBLogDrive, $sqlTempDBDrive, $newinstanceName)

C:\installers\RunSQLInstall_dynamic.ps1 $scriptargs
