
$path = Split-Path -parent "c:\Temp\*.*"
$LogDate = get-date -f yyyyMMddhhmm
$csvfile = $path + "\ALLADUsers_$logDate.csv"

Import-Module ActiveDirectory

$SearchBase = "OU=OU_Clients,DC=domain,DC=com"
$ADServer = 'DC01'

#ensures that updated users are never exported.
$AllADUsers = Get-ADUser -server $ADServer `-searchbase $SearchBase ` -Filter * -Properties * | Where-Object { $_.info -NE '* no' }
$AllADUsers |
Select-Object @{ Label = "First Name"; Expression = { $_.GivenName } },
			  @{ Label = "Last Name"; Expression = { $_.Surname } },
			  @{ Label = "Display Name"; Expression = { $_.DisplayName } },
			  @{ Label = "Logon Name"; Expression = { $_.sAMAccountName } },
			  @{ Label = "Full address"; Expression = { $_.StreetAddress } },
			  @{ Label = "City"; Expression = { $_.City } },
			  @{ Label = "State"; Expression = { $_.st } },
			  @{ Label = "Post Code"; Expression = { $_.PostalCode } },
			  @{ Label = "Country/Region"; Expression = { if (($_.Country -eq 'DE')) { 'Deutschland' }
		Else { '' } } },
			  @{ Label = "Job Title"; Expression = { $_.Title } },
			  @{ Label = "Company"; Expression = { $_.Company } },
			  @{ Label = "Directorate"; Expression = { $_.Description } },
			  @{ Label = "Department"; Expression = { $_.Department } },
			  @{ Label = "Office"; Expression = { $_.OfficeName } },
			  @{ Label = "Phone"; Expression = { $_.telephoneNumber } },
			  @{ Label = "Email"; Expression = { $_.Mail } },
			  @{ Label = "Manager"; Expression = { %{ (Get-AdUser $_.Manager -server $ADServer -Properties DisplayName).DisplayName } } },
			  @{ Label = "Account Status"; Expression = { if (($_.Enabled -eq 'TRUE')) { 'Enabled' }
		Else { 'Disabled' } } }, # the 'if statement# replaces $_.Enabled
			  @{ Label = "Last LogOn Date"; Expression = { $_.lastlogondate } } |
Export-Csv -Path $csvfile -Delimiter ";"
