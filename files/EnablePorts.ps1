# Enable TCP 1433
netsh advfirewall firewall add rule name="Port 1433" dir=in action=allow protocol=TCP localport=1433 profile=any

# Enable UDP 1434
netsh advfirewall firewall add rule name="Port 1434" dir=in action=allow protocol=UDP localport=1434 profile=any

# Enable TCP 80
netsh advfirewall firewall add rule name="Port 80" dir=in action=allow protocol=TCP localport=80 profile=any
