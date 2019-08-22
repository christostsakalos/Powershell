Get-MailboxDatabase -Status | select Name,Server,DatabaseSize,AvailableNewMailboxSpace  | Format-Table -Wrap -AutoSize
