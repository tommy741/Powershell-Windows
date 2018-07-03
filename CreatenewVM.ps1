$VMname = "test"

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
