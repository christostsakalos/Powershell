
###Needs connecttoexchange
	
$Name = Read-Host -Prompt "Input display name"
$Alias = Read-Host -Prompt "Alias"
$Email = Read-Host -Prompt "fulle-mailaddress"
New-DistributionGroup -Name $Alias -Alias $Alias -Displayname $Alias -PrimarySMTPAddress $Email -OrganizationalUnit "rico-logistics.local/rico/distribution 365" -MemberDepartRestriction Closed
  