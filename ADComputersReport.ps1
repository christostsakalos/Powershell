Get-ADComputer -Filter * -Property * | Select-Object Name,OperatingSystem,OperatingSystemVersion,ipv4Address,enabled,lastlogondate, createtimestamp |
Export-CSV "\\uklndcp001\Chris\adcomputersreport.csv"
