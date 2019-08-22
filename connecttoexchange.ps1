$credentials = Get-Credential -Credential rico-logistics\c.tsakalos
Write-Output "Getting the Exchange Online cmdlets"

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://rico-dag04.rico-logistics.local/PowerShell/ -Authentication Kerberos -Credential $credentials
Import-PSSession $Session