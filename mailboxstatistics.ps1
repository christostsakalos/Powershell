Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails SharedMailbox |

Get-MailboxStatistics |

Select DisplayName, `

@{name="TotalItemSize (MB)"; expression={[math]::Round( `

($_.TotalItemSize.ToString().Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}}, `

ItemCount | Sort "TotalItemSize (MB)" -Descending | Export-Csv -Path C:\Users\tsakalos\Desktop\exchangesizenew2.csv -NoTypeInformation
