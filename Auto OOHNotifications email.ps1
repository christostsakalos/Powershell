$Username = "OOHNotification"
$Password = Get-Content “C:\Scripts\password.txt” | ConvertTo-SecureString
$Credentials = New-Object System.Management.Automation.PSCredential $Username,$Password

Send-MailMessage -to "m.noronha@ricogroup.co.uk" -From "OOHNotification <OOHNotification@company.co.uk>" -Subject "Out of hour support process" -Body "Dear Colleagues, 

Please be aware the out of hours support number should only be used for all business critical calls ONLY, all other issues that can be actioned during normal business hours should be logged on our helpdesk at http://helpdesklink.com 
  
For all line outages and network issues please call 0844.. (outside the UK, call +442...3), if no answer please leave a voicemail message.
  
For all Trace , DA and PODFather  issues please call 0203... (outside the UK, call +44...), if no answer please leave a voicemail message.

Thank you, 
Company Information Services / Technology. "  -SMTPServer "mail.smtp2go.com" -Port "2525" -Credential $Credentials