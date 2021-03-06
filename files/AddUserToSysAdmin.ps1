Param(
[string]$runAsUser,
[string]$runAsPassword,
[string]$usersToAdd
)

$sysFQDN = [System.Net.Dns]::GetHostByName(($env:computerName)) | FL HostName | Out-String | %{ "{0}" -f $_.Split(':')[1].Trim() }
$sqlServer = $env:computername
$user = $usersToAdd

$password = $runAsPassword | ConvertTo-SecureString -asPlainText -Force
$username = $runAsUser 
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
$session = New-PSSession -Credential $credential

Invoke-Command -Session $session -ScriptBlock {
    Param(
        [string]$sqlserver,
        [string]$user
    )

    [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | out-null
     
    Function Add-WindowsAccountToSQLRole ([String]$Server, [String] $User, [String]$Role){
     
        $Svr = New-Object ('Microsoft.SqlServer.Management.Smo.Server') $server
         
        # Check if Role entered Correctly
        $SVRRole = $svr.Roles[$Role]
        if($SVRRole -eq $null){
            Write-Host " $Role is not a valid Role on $Server"
        } 
        else{
                #Check if User already exists
                if($svr.Logins.Contains($User)){
                    $SqlUser = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Login $Server, $User
                    $LoginName = $SQLUser.Name
                    if($Role -notcontains "public"){
                        $svrole = $svr.Roles | where {$_.Name -eq $Role}
                        $svrole.AddMember("$LoginName")
                    }
                }
                else{
                    $SqlUser = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Login $Server, $User
                    $SqlUser.LoginType = 'WindowsUser'
                    $SqlUser.Create()
                    $LoginName = $SQLUser.Name
                    if($Role -notcontains "public"){
                        $svrole = $svr.Roles | where {$_.Name -eq $Role}
                        $svrole.AddMember("$LoginName")
                    }
                }
        }
     
    }

    Add-WindowsAccountToSQLRole $sqlServer $user sysadmin
} -ArgumentList @($sqlServer,$user)
