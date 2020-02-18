Connect-MsolService # Works as normal if you define parameter -tenantid tenancy'sID
#To get tenant ID use Get-MsolPartnerContract -All | Select-Object Name, TenantID
