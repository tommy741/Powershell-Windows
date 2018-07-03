$VMname = Read-Host 'Bitte geben Sie Rechnernamen ein'
$Srviso = "C:\iso\SW_DVD9_Win_Server_STD_CORE_2016_64Bit_English_-4_DC_STD_MLF_X21-70526.ISO"
#$Srviso = "C:\iso\en_windows_10_enterprise_x64_dvd_6851151.iso"

$NewVMParam = @{
  Name = $VMname
  MemoryStartUpBytes = 1GB
  Path = "C:\HyperV\$VMname\Virtual Machines\"
  SwitchName =  "net-Internal"
  NewVHDPath =  "C:\HyperV\$VMname\Virtual  Hard Disks\$VMname.vhdx"
  NewVHDSizeBytes =  60GB 
  ErrorAction =  'Stop'
  Verbose =  $True
  }


$VM = New-VM @NewVMParam
Set-VMDvdDrive -VMName $VMname -Path $Srviso
Start-vm $VMname
