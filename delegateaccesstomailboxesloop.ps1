
###Needs connecttoexchange
	
while ($true)
    {
    $mailbox = read-host "Please enter shared mailbox name (Ctrl+C to quit)"
    
    Add-MailboxPermission $mailbox -User $username -AccessRights FullAccess
    Add-ADPermission $mailbox -ExtendedRights Send-As -user $username

    }
