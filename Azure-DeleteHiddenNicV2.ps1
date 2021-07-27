Import-Module .\DeviceManagement.psd1 -Verbose
$hiddenHypVNics = Get-Device -ControlOptions DIGCF_ALLCLASSES | 
    Sort-Object -Property Name | 
        Where-Object { ($_.IsPresent -eq $false) -and ($_.Name -like "Microsoft Hyper-V Network Adapter*") }
 
$hiddenHypVNics | ForEach-Object {
    Write-Verbose "Removing ""@$($_.InstanceId.Replace("`0", ''))"""
    .\devcon.exe remove """@$($_.InstanceId.Replace("`0", ''))"""
}
