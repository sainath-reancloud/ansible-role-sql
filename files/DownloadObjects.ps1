Param(
  [string]$BucketName,
  [string]$KeyName,
  [string]$Destination
)

Read-S3Object -BucketName $BucketName -KeyPrefix $KeyName -Folder $Destination
