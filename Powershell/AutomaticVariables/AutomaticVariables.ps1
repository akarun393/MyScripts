
#1. $MyInvocation - Determining the directory in which a script is located

If (Test-Path -LiteralPath 'variable:HostInvocation') { $InvocationInfo = $HostInvocation; Write-Host "hostinvocation"} Else { $InvocationInfo = $MyInvocation; Write-Host "myinvocation"}
	[string]$scriptDirectory = Split-Path -Path $InvocationInfo.MyCommand.Definition -Parent

return $scriptDirectory

