Param(
    [string]$runAsUser,
    [string]$runAsPassword
)

$password = $runAsPassword | ConvertTo-SecureString -asPlainText -Force
$username = $runAsUser 
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
$session = New-PSSession -Credential $credential
$sqlServer = $env:computername

$query1 = @"
EXEC sp_configure 'backup compression default', 1 ;
RECONFIGURE WITH OVERRIDE ;
GO

EXEC sp_configure 'show advanced options', 1;
GO

RECONFIGURE WITH OVERRIDE;
GO

EXEC sp_configure 'max degree of parallelism', 1;
GO 

EXEC sp_configure 'optimize for ad hoc workloads', 1;
GO

RECONFIGURE WITH OVERRIDE;
GO
"@

$query2 = @"
ALTER DATABASE tempdb 
MODIFY FILE 
(    
NAME = tempdev,    
SIZE = 250MB
); 

ALTER DATABASE tempdb 
ADD FILE 
(    
NAME = tempdev2,    
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data\tempdev2.ndf',    
SIZE = 250MB,    
MAXSIZE = UNLIMITED,    
FILEGROWTH = 10 %
); 

ALTER DATABASE tempdb 
ADD FILE 
(    
NAME = tempdev3,    
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data\tempdev3.ndf',    
SIZE = 250MB,    
MAXSIZE = UNLIMITED,    
FILEGROWTH = 10 %
);

ALTER DATABASE tempdb 
ADD FILE (    
NAME = tempdev4,    
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data\tempdev4.ndf',    
SIZE = 250MB,    
MAXSIZE = UNLIMITED,    
FILEGROWTH = 10 %
);

ALTER DATABASE tempdb 
ADD FILE 
(    
NAME = tempdev5,    
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data\tempdev5.ndf',    
SIZE = 250MB,    
MAXSIZE = UNLIMITED,    
FILEGROWTH = 10 %
);


ALTER DATABASE tempdb 
ADD FILE 
(    
NAME = tempdev6,    
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data\tempdev6.ndf',    
SIZE = 250MB,    
MAXSIZE = UNLIMITED,    
FILEGROWTH = 10 %
);

ALTER DATABASE tempdb 
ADD FILE 
(    
NAME = tempdev7,    
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data\tempdev7.ndf',    
SIZE = 250MB,    
MAXSIZE = UNLIMITED,    
FILEGROWTH = 10 %
);

ALTER DATABASE tempdb 
ADD FILE 
(    
NAME = tempdev8,    
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data\tempdev8.ndf',    
SIZE = 250MB,    
MAXSIZE = UNLIMITED,    
FILEGROWTH = 10 %
);
GO
"@

Invoke-Command -Session $session -ScriptBlock {
    Param(
        [string]$sqlServer,
        [string]$query1,
        [string]$query2
    )

    Import-Module SQLPS -DisableNameChecking
    Invoke-Sqlcmd -HostName $sqlServer -Database master -Query $query1
    Write-Host "Query1 Executed Successfully"
    Invoke-Sqlcmd -HostName $sqlServer -Database master -Query $query2
    Write-Host "Query2 Executed Successfully"
} -ArgumentList @($sqlServer,$query1,$query2)
