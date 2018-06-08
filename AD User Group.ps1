
Import-Module ActiveDirectory

$Usersall = Get-AdUser -Filter 'Description -Like "test*" '
foreach ($username in $Usersall) {
	Get-ADPrincipalGroupMembership $username | select name | Sort-Object name | Out-file \\fileshare\Austausch\$username.txt
}