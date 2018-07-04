 #Create Cluster
New-Cluster -name "Demo" -node hyperv01, hyperv02

#Enable Spaces Direct
Enable-ClusterStorageSpacesDirect

#Create Volumes
1..5 | ForEach {
    New-Volume -FriendlyName "Volume1" -FileSystem CSVFS_ReFS -StoragePoolFriendlyNsme "S2D*" -Size 200GB -ResiliencySettingName Mirror
    }

#Scale-Out
Add-ClusterNode -Name hyperv-03

#Scale-in
Remove-ClusterNode -Name hyperv03 -CleanupDisks

#List Cluster nodes
Get-ClusterNode

#List unpooles Devices
Get-PhysikalDisk -CanPool $True | Sort Model

#List Pooles Drives
Get-StoragePool S* | Get-PhysicalDisk | Sort Model 
