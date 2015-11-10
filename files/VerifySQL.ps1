Function Set-Attr($obj, $name, $value)
{
    # If the provided $obj is undefined, define one to be nice
    If (-not $obj.GetType)
    {
        $obj = New-Object psobject
    }

    $obj | Add-Member -Force -MemberType NoteProperty -Name $name -Value $value
}

Function Fail-Json($obj, $message = $null)
{
    # If we weren't given 2 args, and the only arg was a string, create a new
    # psobject and use the arg as the failure message
    If ($message -eq $null -and $obj.GetType().Name -eq "String")
    {
        $message = $obj
        $obj = New-Object psobject
    }
    # If the first args is undefined or not an object, make it an object
    ElseIf (-not $obj.GetType -or $obj.GetType().Name -ne "PSCustomObject")
    {
        $obj = New-Object psobject
    }

    Set-Attr $obj "msg" $message
    Set-Attr $obj "failed" $true
    echo $obj | ConvertTo-Json -Depth 99
    Exit 1
}

Function Exit-Json($obj)
{
    # If the provided $obj is undefined, define one to be nice
    If (-not $obj.GetType)
    {
        $obj = New-Object psobject
    }

    echo $obj | ConvertTo-Json -Depth 99
    Exit
}

$sql = $false
If (Test-Path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server") {
    
    $SQLVer = '11.1.3000.0'

    $inst = (get-itemproperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server').InstalledInstances
    foreach ($i in $inst)
    {
       $p = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL').$i
       $ChkSQLVer =   (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$p\Setup").Version
    }

    If ($ChkSQLVer -eq $SQLVer) {
        $sql = $true
    } 
}

If ($sql) {
    Exit-Json "SQL Server installation is successful."
}
Else{
    Fail-Json 'result' "SQL Server Installation Failed. Please check the log for more details."
}

