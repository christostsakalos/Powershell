
###Needs connecttoexchange
while ($true) {
$Name = Read-Host -Prompt "Input display name (Ctrl+C to quit)"
$external = Read-Host -Prompt "External Address"

New-MailContact -Name $Name -FirstName $Name  -LastName $Name -ExternalEmailAddress $external -OrganizationalUnit "rico-logistics.local/RICO/Contacts" -ErrorAction STOP
}