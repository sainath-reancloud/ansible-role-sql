
sleep -s 30

While((Get-ScheduledTask -TaskName SQL_Install).State -eq "Running"){
    sleep -s 30
}

Unregister-ScheduledTask -TaskName SQL_Install -Confirm:$false
