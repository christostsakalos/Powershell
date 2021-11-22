function Mail2Me ($message, $userID)

{

	   $SmtpServer ="idcsmtprelay.tvslsl.in"

              $from = "it.notifications@comapny.com"

              $to = "<it.notifications@company.com>"         

           $smtp = new-object system.net.mail.smtpClient($SmtpServer)

            $mail = new-object System.Net.Mail.MailMessage

              $mail.From = $from

                $mail.To.Add($to)

              $mail.Subject = "AD User Account $UserID is LockedOut "

             $mail.Body = $message

            #$mail.IsBodyHtml = $true;

           $smtp.Send($mail)

} # end of function Mail2me

# Main

$PDC=(get-addomain).PDCEmulator

 

$Levent=Get-WinEvent -ComputerName $PDC -FilterHashtable @{Logname='Security';Id=4740} -ErrorAction SilentlyContinue

if ($Levent)

{

foreach ($i in $Levent)

            {

              if (((get-date) - $i.timecreated).totalminutes -le 5)

                 {

                  $UserInfo=$i.properties[0].value|get-aduser -properties *

                  $Tc=$i.timecreated

                  $UserID=$UserInfo.SamAccountName

                  $UserName=$UserInfo.Name

                  $Phone=$UserInfo.TelephoneNumber

                  $Init=$i.properties[1].value

                   #$MSg=$i.message

$message =@"

The Lockedout account ID: $UserID

 

The user name           : $UserName

 

User Phone number       : $Phone

 

Locked out occurred on  : $Tc

 

Initiated computer name  : $Init

"@                      

                             

                   Mail2Me $message $UserID

                 }

             }

     }