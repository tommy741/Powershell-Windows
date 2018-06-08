 


$TemplateServer = "TemplatePrintserver"
$TemplatePrinter = "TemplatePrint"

#permission template
$newprintsecurity = Get-Printer -name $TemplatePrinter -computername $TemplateServer -Full | Where {$_.DeviceType -eq "Print"} | select PermissionSDDL -ExpandProperty PermissionSDDL

#import all CM server
$AllServers = Import-Csv P:\Allprintserver.csv

foreach ($Server in $AllServers){
[string]   $Servername = $Server.Name
#get all printer of the printserver
$allprinter = Get-Printer -ComputerName $Server -Full
    foreach ($printer in $allprinter){
    
    #get just the printername
    [string]   $Printername = $printer.Name
    
    #get date for logfile
    $Date = Get-Date -Format o
    
    #create log file 
    $Logfile = "P:\Logs\$Printername.log"
    
    Add-content $Logfile -value "Log create at $Date" 
    Invoke-Command -ComputerName $Servername -ScriptBlock {

    #Read out Printer Permission
    $printsecurity = Get-Printer -name $Printername -computername $Servername -Full | Where {$_.DeviceType -eq "Print"} | select PermissionSDDL -ExpandProperty PermissionSDDL
    
    #if jobcount not eq 0 - wait 5s and run again
    do{
    Start-Sleep -Seconds 5
    $jobcount = Get-Printer -name $Printername -computername $Servername -Full | Where {$_.DeviceType -eq "Print"} | select JobCount
    }
    until($jobcount -ne 0)

    #set permisission from permission template
   $tP = Get-Printer -name $Printername -computername $Servername -Full | Where {$_.DeviceType -eq "Print"}}

   set-printer $tP.name -computer $Server -PermissionSDDL $newprintsecurity.PermissionSDDL

 }
