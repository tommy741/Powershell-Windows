
$Path  = "c:\Path\"
$BackupPath = "c:\Backuppath\"
if (-Not(Test-Path -Path $BackupPath)) 
{ New-Item -ItemType Directory $BackupPath -Force}
Copy-Item -Path $Path -Destination $BackupPath
exit
