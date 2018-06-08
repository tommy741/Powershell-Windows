Die Aktivierung ist eigentlich in wenigen Schritten m�glich: 
 
#run on target 
Enable-PSRemoting -force

#testing on client 
Test-WsMan target

#enter an PS Session on target
Enter-PSSession -computername target

#run single command on target
Invoke-Command -ComputerName target -ScriptBlock { Get-ChildItem C:\ }