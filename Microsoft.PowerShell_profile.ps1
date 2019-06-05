
#modify window size
$Shell = $Host.UI.RawUI
$size = $Shell.BufferSize
$size.width=240
$size.height=5000
$Shell.BufferSize = $size
$size = $Shell.WindowSize
$size.width=220
$size.height=60
$Shell.WindowSize = $size
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Green"


function psr {
$cname = Read-Host -Prompt "Bitte geben Sie den Rechnernamen ein!"
[string] $cname2 = $cname + ".Domain.de"
Enter-PSSEssion -Computername $cname2 -UseSSL}



Set-Alias sccm  "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\Microsoft.ConfigurationManagement.exe"
Set-Alias psr psse
Set-Alias ad    "C:\Windows\system32\dsa.msc"
Set-Alias ads   "C:\Windows\system32\dssite.msc"
Set-Alias svc   "C:\Windows\system32\services.msc"
Set-Alias adsi  "C:\Windows\system32\adsiedit.msc"
Set-Alias gpo   "C:\Windows\system32\gpmc.msc"
Set-Alias lpo   "C:\Windows\system32\gpedit.msc"
Set-Alias dns   "C:\Windows\system32\dnsmgmt.msc"
Set-Alias dhcp  "C:\Windows\system32\dhcpmgmt.msc"
Set-Alias fcm   "C:\Windows\system32\Cluadmin.msc"
Set-Alias cm    "C:\Windows\system32\compmgmt.msc"
Set-Alias hv    "C:\Program Files\Microsoft System Center Virtual Machine Manager\bin\VmmAdminUI.exe"
Set-Alias wsus  "C:\Program Files\Update Services\administrationsnapin\wsus.msc"





cls
Write-Host ""
Write-Host ""
Write-Host "  ##############################################################################"
Write-Host "  #    sccm  -  SCCM Console           #    lpo  -  Local Policy               #"
Write-Host "  #    psr   -  Powershellremote       #    dns  -  DNS Console                #"
Write-Host "  #    ad    -  Active Directory       #    cm   -  Computermanagement         #"
Write-Host "  #    ads   -  AD Sites and Services  #    dhcp -  DHCP Console               #"
Write-Host "  #    svc   -  Services               #    fcm  -  Failover Cluster Manager   #"
Write-Host "  #    adsi  -  ADSI Editor            #    hv   -  SC Virtual Mashine Manager #"
Write-Host "  #    gpo   -  GPO Console            #    wsus -  WSUS Console               #"
Write-Host "  #    ise   -  ISE Console            #                                       #"
Write-Host "  #    code  -  VS Code                #                                       #"
Write-Host "  #                                    #                                       #"
Write-Host "  ##############################################################################"



Write-Host 'Powershell' $PsVersionTable.PSVersion '-' (Get-date)
Write-Host ""
Write-Host '  Good afternoon... gentlemen. I am a HAL 9000... computer. I became operational'
Write-Host '  at the H.A.L. plant in Urbana, Illinois... on the 12th of January 1992. My instructor was'
Write-Host '  Mr. Langley... and he taught me to sing a song. If you ''d like to hear it I can sing it for you.'
Write-Host ""
Write-Host ""
