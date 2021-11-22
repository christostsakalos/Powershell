Send-MailMessage -to OOHNotification@company.co.uk -bcc alerttocompany@company.co.uk -From OOHNotification@company.co.uk  -Subject "Out of hour support process" -Body "Dear Colleagues, 

Please note the Out Of Hours (OOH) support number should ONLY be used for all BUSINESS CRITICAL calls, all other issues that can be actioned during normal business hours should be logged on our helpdesk at http://helpdesklink.com/ 
  
For all line outages and network issues please call 08...0 (outside the UK, call +442...3), if no answer please leave a voicemail message.
  
For all Application issues please call 08...0 (outside the UK, call +442...4), if no answer please leave a voicemail message.


OOH times for Bank Holiday Weekend are as follows:
6pm Friday 27th August to 8am Tuesday 31st August 2021 


Thank you, 
Information Services / Technology. " -SmtpServer "mail.smtp2go.com" -Port "2525" -Credential "Credentials"