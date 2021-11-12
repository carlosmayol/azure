install-module devicemanagement #(from Nuget)

Import-Module devicemanagement


$hiddenHypVNics = Get-Device -ControlOptions DIGCF_ALLCLASSES | 
    Sort-Object -Property Name | 
        Where-Object { ($_.IsPresent -eq $false) -and ($_.Name -like "Microsoft Hyper-V Network Adapter*") }
 
$hiddenHypVNics | ForEach-Object {
    Write-Verbose "Removing ""@$($_.InstanceId.Replace("`0", ''))"""
    .\devcon.exe remove """@$($_.InstanceId.Replace("`0", ''))"""
}


<#
Prerequisites for the powershell script:

DeviceManagement.psd1

https://gallery.technet.microsoft.com/scriptcenter/Device-Management-7fad2388

Devcon

https://support.microsoft.com/en-gb/kb/311272
#>