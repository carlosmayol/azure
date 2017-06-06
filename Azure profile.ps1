# Create the profile file launch:
# new-item -type file -path $profile -Force
# Then copy below lines in the profile file: C:\Users\YOURUSERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
# Alternatively you can create a shorcut and call the script E.G.
# C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -NoExit -ExecutionPolicy Bypass -File "C:\Azure_profile.ps1"
#---------------------------------------------

#Functions

Function Get-MyModule 
{ 
Param([string]$name) 
if(-not(Get-Module -name $name)) 
{ 
if(Get-Module -ListAvailable | Where-Object { $_.name -eq $name }) 
{ 
Import-Module -Name $name 
} #end if module available then import 
else 
{ 
write-host "Module not available" -ForegroundColor Red 
} # end if not module 
} # end inf
} # end function

function Get-WindowsAzurePowerShellVersion
{
[CmdletBinding()]
Param ()
 
## - Section to query local system for Windows Azure PowerShell version already installed:
Write-Host "`r`n Comparing Windows Azure PowerShell Installed version with last available: " -ForegroundColor 'Yellow'
 
## - Section to query web Platform installer for the latest available Windows Azure PowerShell version:
Write-Host "`r`n Windows Azure PowerShell available download version: " -ForegroundColor 'Green'
[reflection.assembly]::LoadWithPartialName("Microsoft.Web.PlatformInstaller") | Out-Null
$ProductManager = New-Object Microsoft.Web.PlatformInstaller.ProductManager
$ProductManager.Load()
$PV=$ProductManager.Products | Where-Object {$_.title -eq "Microsoft Azure PowerShell"}
$PV | Format-List Version, Title, Published, Author 

};


# Body

$host.ui.rawui.foregroundcolor  = “Green”
$host.ui.rawui.backgroundcolor = “Black”
$a = (Get-Host).UI.RawUI
$a.WindowTitle = "My PowerShell Session"
Clear-host
Write-Host "Current Username: $env:USERNAME"
Write-Host "Current Computername: $env:COMPUTERNAME"
$PSVersion = (Get-Host).Version
Write-Host "PS Version: $PSVersion"
Get-MyModule “Azure”
$AzureVersion= (Get-Module -Name Azure).Version
write-host "Azure Version: $AzureVersion"
$AS= (Get-AzureSubscription).SubscriptionName
$ASID= (Get-AzureSubscription).SubscriptionId
write-host "Current Azure Subscription: $AS , ID: $ASID"
Get-WindowsAzurePowerShellVersion
