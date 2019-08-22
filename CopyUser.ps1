#connect
$credentials = Get-Credential -Credential rico-logistics\c.tsakalos
Write-Output "Getting the Exchange Online cmdlets"

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://rico-dag04.rico-logistics.local/PowerShell/ -Authentication Kerberos -Credential $credentials
Import-PSSession $Session

	
#Write "copyuser" and follow the instruction to create the user

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

Get-ADUser -Identity $template -Properties memberof |
Select-Object -ExpandProperty memberof |
Add-ADGroupMember -Members $Name -PassThru | 
Select-Object -Property SamAccountName



		}
