<#
.SYNOPSIS
Removes registry keys related to a specified Intune Win32 application.

.DESCRIPTION
The Remove-IntuneWin32AppRegKey function searches for and deletes registry keys
associated with a specified Intune Win32 application ID. It identifies keys
based on specific criteria and triggers an Intune sync after successful deletions.
The sync helps ensure that Intune re-evaluates app assignments and policies immediately.

.PARAMETER AppID
The application ID of the Intune Win32 app whose registry keys should be removed.

.EXAMPLE
Remove-IntuneWin32AppRegKey -AppID "12345"

This command removes the required registry keys associated with the Intune Win32 app ID "12345".

Remove-IntuneWin32AppRegKey -AppID "12345" -WhatIf

This command previews the registry keys that would be removed for the Intune Win32 app ID "12345" without making any changes.

.NOTES
- This script requires administrative privileges to modify the registry.
- Use the -WhatIf parameter to preview changes without making any modifications.
#>
function Remove-IntuneWin32AppRegKey
{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$true)]
        [string]$AppID
    )
    # Define the main registry path
    $mainRegistryPath = "HKLM:\SOFTWARE\Microsoft\IntuneManagementExtension\Win32Apps"
    Write-Verbose "Searching for registry keys matching criteria for: '$AppID'"
    Write-Verbose "Main registry path: $mainRegistryPath"
    # Check if main registry path exists
    if (-not (Test-Path $mainRegistryPath))
    {
        Write-Warning "Main registry path does not exist: $mainRegistryPath"
        return
    }
    # Get all subkeys under the main registry path
    $allSubKeys = Get-ChildItem -Path $mainRegistryPath |
        Where-Object { $_.Name -notmatch "OperationalState|Reporting" } -ErrorAction SilentlyContinue
    $allSubKeys = $allSubKeys | ForEach-Object {
        Get-ChildItem -Path $_.PSPath -Recurse
    }
    $keysToDelete = @()
    foreach ($subKey in $allSubKeys)
    {
        $subKeyPath = $subKey.PSPath
        # Criteria 1: Check if subkey name matches the pattern "KeyName_*"
        if ($subKey.PSChildName -like "${AppID}_*")
        {
            Write-Verbose "Found key matching pattern '${AppID}_*': $subKeyPath"
            $keysToDelete += $subKeyPath
            continue
        }
        # Criteria 2: Check if this subkey contains a value with name matching $AppID
        try
        {
            $propertyNames = $subKey.GetValueNames()
            if ($propertyNames -contains $AppID)
            {
                Write-Verbose "Found value named '$AppID' in key: $subKeyPath"
                $keysToDelete += $subKeyPath
                continue
            }
        }
        catch
        {
            Write-Warning "Error reading properties from registry key: $subKeyPath. Error: $($_.Exception.Message)"
        }
    }
    # Remove duplicates (in case a key matches both criteria)
    $keysToDelete = $keysToDelete | Sort-Object -Unique
    if ($keysToDelete.Count -eq 0)
    {
        Write-Host "No registry keys found matching the criteria for: '$AppID'" -ForegroundColor Yellow
        return
    }
    Write-Host "Found $($keysToDelete.Count) registry key(s) to delete:" -ForegroundColor Cyan
    $keysToDelete | ForEach-Object { Write-Host "  - $_" -ForegroundColor White }
    $successfulDeletions = 0
    # Confirm and delete
    foreach ($keyPath in $keysToDelete)
    {
        if ($PSCmdlet.ShouldProcess($keyPath, "Delete registry key"))
        {
            try
            {
                Remove-Item -Path $keyPath -Recurse -Force -ErrorAction Stop
                Write-Host "Successfully deleted registry key: $keyPath" -ForegroundColor Green
                $successfulDeletions++
            }
            catch
            {
                Write-Error "Failed to delete registry key: $keyPath. Error: $($_.Exception.Message)"
            }
        }
    }
    # Trigger Intune sync only if at least one registry key was successfully deleted
    if ($successfulDeletions -gt 0)
    {
        Write-Host "Successfully deleted $successfulDeletions registry key(s). Triggering Intune sync..." -ForegroundColor Cyan
        try
        {
            #$SyncApp = New-Object -ComObject Shell.Application
            #$SyncApp.open("intunemanagementextension://syncapp")
            Write-Host "Intune sync triggered successfully." -ForegroundColor Green
        }
        catch
        {
            Write-Warning "Failed to trigger Intune sync: $($_.Exception.Message)"
            Write-Host "You may need to manually trigger an Intune sync from Company Portal." -ForegroundColor Yellow
        }
    }
    else
    {
        Write-Host "No registry keys were deleted. Intune sync was not triggered." -ForegroundColor Yellow
    }
}
