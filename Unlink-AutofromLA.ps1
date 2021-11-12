The link cannot be updated or deleted because it is linked to Update Management and/or ChangeTracking Solutions. Error code: Conflict


# if you are not connected to Azure run the next command to login
Login-AzureRmAccount

$workspaceId = "your workspace id (a guid) copied from the portal"

$automationSolutions = "Updates", "ChangeTracking", "AzureAutomation"
$automationAccount = ""

$workspace = (Get-AzureRmOperationalInsightsWorkspace).Where({$_.CustomerId -eq $workspaceId})

if (! $workspace ) {
    $subs = Get-AzureRmSubscription

    if ($subs.Count -gt 1) {
        $subs
        Write-Error "You have access to multiple subscriptions. Run Select-AzureRmSubscription to select the subscription with your workspace."
    } else {
        Write-Error "WorkspaceId not found: $workspaceId"
    }
    return
}

# If there is a linked automation account, remove the Automation and Control solutions
# unlink the automation account
try {
    $automationAccount = Get-AzureRmResource -ResourceId ($workspace.ResourceId + "/linkedServices/automation") -ErrorAction Stop
    }
catch {
    # continue
}

if ( $automationAccount ) {
    $enabledautomationSolutions = (Get-AzureRmOperationalInsightsIntelligencePacks -ResourceGroupName $workspace.ResourceGroupName -WorkspaceName $workspace.Name).Where({$_.Name -in $AutomationSolutions -and $_.Enabled -eq $true})
    foreach ($soln in $enabledAutomationSolutions.Name) {
        Set-AzureRmOperationalInsightsIntelligencePack -ResourceGroupName $workspace.ResourceGroupName -WorkspaceName $workspace.Name -IntelligencePackName $soln -Enabled $false
    }
    Remove-AzureRmResource -ResourceId $automationAccount.ResourceId
}

# Remove-AzureRmResource -ResourceId $workspace.resourceid #if you like to remove the LA workspace too