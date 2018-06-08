#set parameter OU1 - OU2
 
    param(
    [Parameter(Mandatory=$true)]
    [ValidateNotNullorEmpty()]
    [ValidateSet('OU1','OU2','ALL')]
    [String]$abtl
    )
 

#Function Mail / user search 
 
    function SendMAil{
    
    $smtp = "mail.domain.com"
    $from = "from@domain.com"
    $cc = "cc@domain.com"
    
 
#Body in HTML
 
    $body =     "<span style='font-family:Arial;font-size:10pt'>Hello $name,<p>please let us know if the following user accounts are still active and needed.
                If users listed here have left the company, we need appropriate tickets for the deletion of the accounts.<p>"
    
    $body +=    "Here all accounts:<p>"
    
#user search Department / business concern
 
(Get-AdUser -Filter * -SearchBase "OU=$ou,OU=OU_Clients,DC=domain,DC=com"| Select-Object Name | Sort-Object Name ) | ForEach-Object { $Name = $_.Name; $body += "$Name <br>" }
 
    $body +=    "<p>Here are the accounts that were not registered in the last 60 days:<p>"
 
#Searches for all users of the desired department/company who have not been logged in for 60 days
 
        (Search-ADAccount -AccountInactive -TimeSpan 60 -UsersOnly -SearchBase "OU=$ou,OU=OU_Clients,DC=domain,DC=com" | Select-Object Name | Sort-Object Name) | ForEach-Object { $Name = $_.Name; $body += "$Name <br>" } 
 
    $body +=    "<p><br><br>With kind regards<br><br>
                System Operating<p>
                Domain AG<br>
                Everywhereroad 4<br>
                12345 Everywher<br> 
                Tel. +49 (0) 12 34567 - 890<br>
                Fax +49 (0) 12 34567 - 198<br>
                it@domain.com<p></span>
                <span style='font-family:Arial;font-size:8pt'>
                www.domain.com<br>
            
                CEO XY</span>"
    
    #sends Mail with Prio High
 
    Send-MailMessage -Encoding "UTF8" -SmtpServer $smtp -To $to -From $from -Subject $subject -CC $cc -Body $body -BodyAsHtml -Prio High
    }
 
    #Selection options that can be called as parameters
    #"ALL" for multi OU
 
    switch ($abtl) {
        "OU1" {
            $ou = "OU1"
            $to = "OU1@domain.com"
            $subject = "Review OU1 Accounts"
            $name = "All"
            SendMail
            }
        "OU2" {
            $ou = "OU2"
            $to = "OU2@domain.com"
            $subject = "Review OU2 Accounts"
            $name = "XYName"
            SendMail
            }
        "ALL" {
            $ou = "OU1"
            $to = "OU1@domain.com"
            $subject = "Review OU1 Accounts"
            $name = "All"
            SendMail
 
            $ou = "OU2"
            $to = "OU2@domain.com"
            $subject = "Review OU2 Accounts"
            $name = "XYName"
            SendMail
            }
            
        default {Write-Warning -Message "Falsche Abteilung!"; exit}
    }
