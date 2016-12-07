Initialize-Disk 1 -PartitionStyle GPT
New-Partition 1 -UseMaximumSize -DriveLetter M
Format-Volume -DriveLetter M -FileSystem NTFS -AllocationUnitSize 65536