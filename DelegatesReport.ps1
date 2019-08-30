$Mailboxes = get-mailbox -ResultSize Unlimited

$logpath = "T:\IT\Chris\Powershell\Reports for Imran"


get-mailbox -ResultSize Unlimited -Filter {ForwardingAddress -ne $Null} |Select Alias, ForwardingAddress |Export-Csv "T:\IT\Chris\Powershell\Reports for Imran\forwards.csv" -NoTypeInformation

$Mailboxes |  ? {$_.GrantSendOnBehalfTo -ne $null} | select Name,Alias,UserPrincipalName,PrimarySmtpAddress,GrantSendOnBehalfTo | Export-Csv "T:\IT\Chris\Powershell\Reports for Imran\sendonbehalf.csv" -NoTypeInformation 

$Mailboxes | Get-MailboxPermission | Where { ($_.IsInherited -eq $False) -and -not ($_.User -like “NT AUTHORITY\SELF”) -and -not ($_.User -like '*Discovery Management*') } | Select Identity, user | Export-Csv "T:\IT\Chris\Powershell\Reports for Imran\fullaccess.csv" -NoTypeInformation |
Send-MailMessage -From "administrator@ricogroup.co.uk" -to "i.bhatti@ricogroup.co.uk", "c.tsakalos" -subject "ADGroupsMembership" -Attachment "\\uklndcp001\Chris\AD_Groups.csv" -smtpServer "172.24.15.10" -body "See attached..."
