# Please Configure the following variables....
$smtpServer = "mail.domain.com"
$expireindays = 7
$from = "it@domain.com"
$logging = "Enabled" # Set to Disabled to Disable Logging
$logFile = "\\fileshare\it\Skripte\Password Change Notification\Logs\Account_log.csv" # ie. c:\mylog.csv
$testing = "Disabled" # Set to Disabled to Email Users
$testRecipient = "test@domain.com"
$date = Get-Date -format ddMMyyyy
$Nirvana = "nirvana@domain.com"



 
# Check Logging Settings
if (($logging) -eq "Enabled")
{
    # Test Log File Path
    $logfilePath = (Test-Path $logFile)
    if (($logFilePath) -ne "True")
    {
        # Create CSV File and Headers
        New-Item $logfile -ItemType File
        Add-Content $logfile "Date;Name;EmailAddress;DaystoExpire;ExpiresOn"
    }
} # End Logging Check
 
# Get Users From AD who are Enabled, Passwords Expire and are Not Currently Expired
Import-Module ActiveDirectory
$users = get-aduser -filter * -properties Name, PasswordNeverExpires, PasswordExpired, PasswordLastSet, EmailAddress | where { $_.Enabled -eq "True" } | where { $_.PasswordNeverExpires -eq $false } | where { $_.passwordexpired -eq $false }
$maxPasswordAge = (Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge
 
# Process Each User for Password Expiry
foreach ($user in $users)
{
$Name = (Get-ADUser $user | foreach { $_.Name })
$emailaddress = $user.emailaddress
$passwordSetDate = (get-aduser $user -properties PasswordLastSet | foreach { $_.PasswordLastSet })
$PasswordPol = (Get-AduserResultantPasswordPolicy $user)
# Check for Fine Grained Password
if (($PasswordPol) -ne $null)
{
    $maxPasswordAge = ($PasswordPol).MaxPasswordAge
}
 
$expireson = $passwordsetdate + $maxPasswordAge
$today = (get-date)
$daystoexpire = (New-TimeSpan -Start $today -End $Expireson).Days
 
# Set Greeting based on Number of Days to Expiry.
 
# Check Number of Days to Expiry
$messageDays = $daystoexpire
 
if (($messageDays) -ge "1")
{
    $messageDays = "in " + "$daystoexpire" + " Days"
}
else
{
    $messageDays = "now"
}
 
    # Email Subject Set Here
    $subject = "Your password expires $messageDays"
 
# Email Body Set Here, Note You can use HTML, including Images.
 
$body = "<P style='font-family: Arial; font-size: 10pt' />
Hello $name,<br> 
<br>
Your password expires $messageDays .<br>
To change your password, press CTRL ALT DELF on your computer and select Change Password <br>
<br>
Thanks and greetings<br>
<br>
System Operating<br>
Client IT<br>
<br>
Domain AG<br>
Everyroad. 4<br>
12345 Everywhere<br>
Tel:       +49 (0) 12 34567 - 890<br>
Fax:     +49 (0) 12 614 45 – 258<br>
it@domain.com<br>
<br></P>
<P style='font-family: Arial; font-size: 8pt' />www.domain.com <br>

CEO: XYName<br>
</P>"
    
    # If Testing Is Enabled - Email Administrator
    if (($testing) -eq "Enabled")
    {
        $emailaddress = $testRecipient
    } # End Testing
    
    # If a user has no email address listed
    if (($emailaddress) -eq $null)
    {
        $emailaddress = $Nirvana
    }# End No Valid Email
    
    # Send Email Message
    if (($daystoexpire -ge "0") -and ($daystoexpire -lt $expireindays))
    {
        # If Logging is Enabled Log Details
        if (($logging) -eq "Enabled")
        {
            Add-Content $logfile "$date;$Name;$emailaddress;$daystoExpire;$expireson"
        }
        # Send Email Message
        Send-Mailmessage -smtpServer $smtpServer -from $from -to $emailaddress -subject $subject -body $body -bodyasHTML -priority High -Encoding UTF8
        
    }
} # End Send Message
    # End User Processing
