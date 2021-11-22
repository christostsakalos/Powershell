Import-Module PSFTP
clear-host
$username = "ftpuser"
$pass = "ftpuserpass"
$password = $pass | ConvertTo-SecureString -asPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential($username, $password)
Set-FTPConnection -Credential $credentials -Server 'ftp://serverhostname/' -Session FTPCloud -UsePassive
$Session = Get-FTPConnection -Session FTPCloud
$Lastfile = Dir "C:\scripts\*.csv" | Sort CreationTime -Descending | Select-object -ExpandProperty FullName -First 1 |Out-String | ForEach-Object { $_.Trim() }
Add-FTPItem -Session FTPCloud -Path / -LocalPath "$lastfile" -Overwrite