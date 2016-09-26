#This intro script is pretty almost the same like the previous one. But this lab is connected to the internet over the external virtual switch.
#The IP addresses are assigned automatically like in the previous samples but AL also assignes the gateway and the DNS servers to all machines
#that are part of the lab. AL does that if it finds a machine with the role 'Routing' in the lab.

New-LabDefinition -Name 'Lab0' -DefaultVirtualizationEngine HyperV

Add-LabVirtualNetworkDefinition -Name Lab0
Add-LabVirtualNetworkDefinition -Name Internet -HyperVProperties @{ SwitchType = 'External'; AdapterName = 'Wi-Fi' }

$netAdapter = @()
$netAdapter += New-LabNetworkAdapterDefinition -VirtualSwitch Lab0
$netAdapter += New-LabNetworkAdapterDefinition -VirtualSwitch Internet -UseDhcp
Add-LabMachineDefinition -Name DC1 -Memory 1GB -OperatingSystem 'Windows Server 2012 R2 SERVERDATACENTER' -Roles RootDC, Routing -NetworkAdapter $netAdapter -DomainName contoso.com

Add-LabMachineDefinition -Name Client1 -Memory 1GB -Network Lab0 -OperatingSystem 'Windows 10 Pro' -DomainName contoso.com

Install-Lab

Show-LabInstallationTime