
#Remote PS Session Exchange
New-PSSession -Name Exchange -ConfigurationName Microsoft.Exchange -ConnectionUri http://Mail01.intercard.ag/powershell/ -AllowRedirection -Authentication Kerberos
Import-Module (Import-PSSession (Get-PSSession -Name Exchange)) -Global
 
#Mailbox to shared
SET-MAILBOX Mailbox@domain.com -Type Shared
 
#Full Access Rights
Add-MailboxPermission -Identity "mailbox" -User "secGroup" -AccessRights "FullAccess"
 
#set "send as" permission
Add-ADPermission "Mailbox" -User "secGroup" -ExtendedRights "Send As"
 
#Import PST to archiv
#Der Parameter TargetRootFolder wird nicht angegeben; daher werden die Inhalte mit den vorhandenen Ordnern zusammengeführt, und falls Ordner in der Zielstruktur nicht vorhanden sind, werden neue Ordner erstellt.
New-MailboxImportRequest "user.name" -FilePath "\\fileshare\archiv\PSTImport\Ablage.pst" -IsArchive -BadItemLimit 5 -TargetRootFolder / 
 
#PST Export from a Mailbox
New-MailboxExportRequest -Mailbox "user.name" -FilePath "\\fileshare\archiv\Mailarchiv_oldUser\user.name.pst"
 
#delete MailboxImportRequest
Get-MailboxImportRequest -Status Completed | Remove-MailboxImportRequest
 
#PST Export from a Mailbox ARCHIV
New-MailboxExportRequest -Mailbox "user.name" -FilePath "\\fileshare\Mailarchiv_oldUser\user.name_archiv.pst" -IsArchive
 
#PuF Rights export in CSV
Get-PublicFolder '\PublicFolder\GAA' -GetChildren | Get-PublicFolderClientPermission -User user.name | Export-Csv C:\Temp\PublicFolderClientPermission.csv
 
#Export Mailbox from subdomain - Dev
New-MailboxExportRequest -Mailbox user.name -FilePath \\fileshare\archiv\Mailarchiv_oldUser\user.name.pst -DomainController DevDom01
 
#delete old ActiveSyncDevice older 360 days
Get-ActiveSyncDevice -ResultSize unlimited | Get-ActiveSyncDeviceStatistics | where {$_.LastSyncAttemptTime -lt (get-date).adddays(-360)}|Remove-ActiveSyncDevice
Get-ActiveSyncDevice -Filter "DeviceId -eq 'XYDecID'" | Remove-ActiveSyncDevice

#Disable Mailbox
Disable-Mailbox -Identity "user.name" -Database DB01
 
#Connect Mailbox
Connect-Mailbox -Identity "user.name" -Database DB01 -User user.name
 
#List DistributionGroup
Get-DistributionGroup
 
#DistributionGroup Member in TXT
Get-DistributionGroupMember -Identity "DistributionGroup" >>"C:\Temp\DistributionGroup.txt"

#Get-PublicFolderstatistics 
Get-PublicFolderstatistics -Identity "\PuplicFolder\Dep1\Folder1" |FL >>c:\temp\PF_Folder1.txt
 
#Import  PST to Archiv
New-MailboxImportRequest "user.name" -FilePath "\\fileshare\archiv\Mailarchiv_oldUser\user.nameArchiv.pst" -IsArchive -TargetRootFolder /
 
#KA
Get-MailboxDatabase -Identity DB03 | Get-MailboxStatistics | Sort LastLogonTime -desc > C:\Temp\DB01.txt

#Find Mail
get-messagetrackinglog -Recipients:user.name@domain.com -MessageSubject "Passwortrücksetzung" -Start "04.03.2018 10:15:00" -End "07.03.2018 10:25:00"

$internalmessage = get-content C:\Abwesenheitsassi.txt
$externalmessage = get-content C:\Abwesenheitsassi.txt

#Enable Mailbox Autoreply
$internalmessage = get-content C:\Abwesenheitsassi.txt
$externalmessage = get-content C:\Abwesenheitsassi.txt
Set-MailboxAutoReplyConfiguration user.name -AutoReplyState enabled -ExternalAudience all -InternalMessage "$internalmessage" -ExternalMessage "$externalmessage"


