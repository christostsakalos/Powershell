#needs connect to exchange first

Get-Mailbox -ResultSize Unlimited |Select-Object DisplayName,PrimarySmtpAddress | Export-Csv "T:\IT\Chris\Powershell\Reports for Imran" -NoTypeInformation