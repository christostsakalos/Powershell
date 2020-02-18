Import-Module $((Get-ChildItem -Path $($env:LOCALAPPDATA+"\Apps\2.0\") -Filter CreateExoPSSession.ps1 -Recurse ).FullName | Select-Object -Last 1)
Connect-EXOPSSession -UserPrincipalName christos.tsakalos@westcoastcsp.onmicrosoft.com -DelegatedOrganization chriscroissants.onmicrosoft.com
$global:UserPrincipalName="christos.tsakalos@westcoastcsp.onmicrosoft.com"