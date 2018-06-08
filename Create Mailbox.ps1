$UserCredential = Get-Credential
$OU = 'domain.com/OU_Clients/Mailsystem/Mailboxes/'
 
 
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://mail01.domain.com/PowerShell/ -Authentication Kerberos -Credential $UserCredential
Import-PSSession $Session
 
 
 
$mailbox = Read-Host -Prompt "Please enter the new mailbox name!"
 
 
New-Mailbox -Name:$mailbox -OrganizationalUnit:$OU -Database:'DB01' -userPrincipalName:$mailbox'@domain.com' -Shared 

 
Remove-PSSession $Session