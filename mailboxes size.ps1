#needs connect to exchange first

Get-MailboxStatistics -Server 'owa.riconx.mobi' | where {$_.ObjectClass -eq “Mailbox”} | Sort-Object TotalItemSize -Descending | ft @{label=”User”;expression={$_.DisplayName}},@{label=”Total Size (MB)”;expression={$_.TotalItemSize.Value.ToMB()}}  -auto >> “T:\IT\Chris\Powershell\Reports for Imran\mailbox_size.csv”