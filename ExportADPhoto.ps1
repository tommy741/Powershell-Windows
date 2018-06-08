
Import-Module ActiveDirectory

$UserCredential = Get-Credential

$EXSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://mail01.domain.com/PowerShell/ -Authentication Kerberos -Credential $UserCredential
Import-PSSession $EXSession

$users = get-aduser -filter * -properties Name, PasswordNeverExpires, PasswordExpired, PasswordLastSet, EmailAddress | where { $_.Enabled -eq "True" } | where { $_.PasswordNeverExpires -eq $false } | where { $_.passwordexpired -eq $false }
$unername = $users.name

foreach ($unername in $users) {
Export-RecipientDataProperty -Identity "$unername" -Picture | ForEach { $_.FileData | Add-Content C:\Temp\$unername.jpg -Encoding Byte }
}