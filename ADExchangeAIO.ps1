#Christos Tsakalos All in One
$testcsv = Import-CSV "\\172.24.15.192\department\IT\Chris\test.csv"
$sharedmailboxes = Import-Csv "P:\test.csv"

$credentials = Get-Credential -Credential rico-logistics\c.tsakalos
Write-Output "Getting the Exchange Online cmdlets"

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://rico-dag04.rico-logistics.local/PowerShell/ -Authentication Kerberos -Credential $credentials
Import-PSSession $Session

Function Createuser{
###Create users from csv####

	($testcsv| foreach {
 
$OU = "OU=IT Team,OU=Rico Logistics User Pool,OU=RICO,DC=rico-logistics,DC=local"
 
new-aduser -name $_.name -enabled $true –givenName $_.firstname -DisplayName $_.displayname –surname $_.surname -accountpassword (convertto-securestring $_.password -asplaintext -force) -changepasswordatlogon $false -samaccountname $_.username –userprincipalname ($_.username+”@ricogroup.co.uk”) -Path $OU -Department $_.Department -Title $_.Title -Manager $_.Manager
})

$testcsv |Foreach{
$samAccountName = $_.Username
$Group = "accounts"
Add-ADGroupMember -identity $Group -members $SamAccountName}

$testcsv |Foreach{
$samAccountName = $_.Username
$Group = "alerttorico"
Add-ADGroupMember -identity $Group -members $SamAccountName}	#Add users to laptpusers and alerttorico

 $testcsv |foreach{
	 $Alias = $_.username
Enable-Mailbox -Identity $Alias}

sleep -Seconds 10

 
 
 $testcsv |foreach{
	 $Alias = $_.username
Set-Mailbox -Identity $alias -IssueWarningQuota 1.5gb -ProhibitSendQuota 1.7gb -ProhibitSendReceiveQuota 2gb -UseDatabaseQuotaDefaults $false
}
	}

	Function copyuser{
		#This function requires you to connect to exchange and it will copy a template user and will mirror it.
		$template = Read-Host -Prompt "Input source user"
		$Name = Read-Host -Prompt "Input display name"
		$Displayname = $Name
		$Firstname = Read-Host -Prompt "Input first Name"
		$Surname = Read-Host -Prompt "Input Last Name"
		$samaccountname = Read-Host -Prompt "Username"
		$userprincipalname = ($samaccountname+”@ricogroup.co.uk”)

New-ADUser -instance $template -Name $Name -DisplayName $DisplayName -GivenName $Firstname -Surname $Surname -SamAccountName $samaccountname -Enabled $true -UserPrincipalName $userprincipalname -accountpassword (convertto-securestring "letmein1640" -asplaintext -force)
		sleep -Seconds 10
		
 Enable-Mailbox -identity $Name
		sleep -Seconds 3

 Set-Mailbox -Identity $Name -IssueWarningQuota 1.5gb -ProhibitSendQuota 1.7gb -ProhibitSendReceiveQuota 2gb -UseDatabaseQuotaDefaults $false

		}

Sleep -Seconds 2

Param ($Source, $Target)
If ($Source -ne $Null -and $Target -eq $Null)
{
    $Target = $Name
}
If ($Source -eq $Null)
{
    $Source = $template
    $Target = $Name
}

# Retrieve group memberships.
$SourceUser = Get-ADUser $Source -Properties memberOf
$TargetUser = Get-ADUser $Target -Properties memberOf

# Hash table of source user groups.
$List = @{}

#Enumerate direct group memberships of source user.
ForEach ($SourceDN In $SourceUser.memberOf)
{
    # Add this group to hash table.
    $List.Add($SourceDN, $True)
    # Bind to group object.
    $SourceGroup = [ADSI]"LDAP://$SourceDN"
    # Check if target user is already a member of this group.
    If ($SourceGroup.IsMember("LDAP://" + $TargetUser.distinguishedName) -eq $False)
    {
        # Add the target user to this group.
        Add-ADGroupMember -Identity $SourceDN -Members $Target
    }
}

# Enumerate direct group memberships of target user.
ForEach ($TargetDN In $TargetUser.memberOf)
{
    # Check if source user is a member of this group.
    If ($List.ContainsKey($TargetDN) -eq $False)
    {
        # Source user not a member of this group.
        # Remove target user from this group.
        Remove-ADGroupMember $TargetDN $Target
    }
}







Function distributiongroups {

(
$testcsv|foreach {New-MailContact -Name $_.ContactDisplayName -FirstName $_.ContactDisplayName -LastName $_.ContactDisplayName -ExternalEmailAddress $_.ContactExternalEmailAddress -OrganizationalUnit "rico-logistics.local/RICO/Contacts" -ErrorAction STOP}
)

#Create the distribution group#
(
$testcsv|foreach {
	$Name = $_.DistGroupAlias
	$Alias = $_.DistGroupAlias
	$Email = $_.DistGroupemail
New-DistributionGroup -Name $Alias -Alias $Alias -Displayname $Alias -PrimarySMTPAddress $Email -OrganizationalUnit "rico-logistics.local/rico/distribution 365" -MemberDepartRestriction Closed
  }
  )

#We add some delay to make sure that groups/contacts are registered into AD#
sleep -seconds 15


#Add users & contacts to the groups#
(
$testcsv |ForEach {Add-DistributionGroupMember -Identity $_.Groupalias -Member $_.GroupMemberName}
)

	
	}

	Function addpermissions  {        
		#Once you finish press Ctrl+C to quit the loop if you wish to user another function

		$username = read-host "Please enter username (Ctrl+C to quit)"
while ($true)
    {
    $mailbox = read-host "Please enter shared mailbox name (Ctrl+C to quit)"
    
    Add-MailboxPermission $mailbox -User $username -AccessRights FullAccess
ForEach ($User in $username)
{
Add-RecipientPermission $user.alias -AccessRights SendAs –Trustee $mailbox
}

    }

	}
