# Get-AzurePublishSettingsFile
#Explore on a Private Session: https://manage.windowsazure.com/publishsettings/index?client=powershell for Subscriptions not associated with your default MS Account.

# Use 
# Add-AzureAccount
# to import subscription information into the PowerShell session window


Import-AzurePublishSettingsFile "C:\Users\carlosm\Documents\Tech Virtualization\Azure\Windows Azure MSDN - Visual Studio Ultimate-5-15-2013-credentials.publishsettings"
#Set-AzureSubscription -SubscriptionName '[YOUR-SUBSCRIPTION-NAME]' -CurrentStorageAccount '[YOUR-STORAGE-ACCOUNT]'

Get-AzureSubscription | Fl SubscriptionName, SubscriptionId, IsDefault 
#Set-AzureSubscription -DefaultSubscription '[YOUR-SUBSCRIPTION-NAME]'  # deprecated, use: 

Classic:
Select-AzureSubscription [-SubscriptionName] <String> [[-Account] <String>] -Default [<SwitchParameter>] [-PassThru [<SwitchParameter>]] [-Profile <AzureProfile>] [<CommonParameters>]
ARM:
Select-AzureRmSubscription -SubscriptionName azurepfe-carlosm