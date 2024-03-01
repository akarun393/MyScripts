#region

# In PowerShell, you can use various types of validation attributes in advanced functions to validate input parameters. These attributes help ensure that the input provided to a function meets certain criteria before the function is executed. Here are some common validation attributes you can use:

## [Parameter()]: While not a validation attribute per se, you can use the [Parameter()] attribute to define various parameters for your advanced function. You can specify properties like Mandatory, Position, and ValueFromPipeline.

## [ValidateNotNull()]: Ensures that the parameter is not null. Use this when you want to ensure a parameter has a value.

## [ValidateNotNullOrEmpty()]: Ensures that the parameter is neither null nor an empty string. This is useful when you want to make sure a string parameter contains some content.

## [ValidateCount()]: Validates that an array parameter has a specific number of elements within a specified range.

## [ValidateLength()]: Validates the length of a string or array parameter within a specified range.

## [ValidateRange()]: Validates that a numeric parameter falls within a specified numeric range.

## [ValidatePattern()]: Validates that a string parameter matches a regular expression pattern.

## [ValidateScript()]: Allows you to provide a custom script block that evaluates the parameter. The function will only execute if the script block returns $true.

## [ValidateSet()]: Limits the parameter's value to a predefined set of allowed values.

## [ValidateScript({})]: You can also use a script block within the [ValidateScript()] attribute to define custom validation logic.

#endregion


function New-VirtualMachine
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory)]
		[ValidateCount(1, 5)]
		[string[]]$Name,
		
		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[ValidateRange(1, 5)]
		[int]$Count = 1,
		
		[Parameter()]
		[ValidateNotNull()]
		[ValidateRange(512MB, 1024MB)]
		[int]$MemoryStartupBytes,
		
		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[ValidateSet('1', '2')]
		[int]$Generation = 2,
		
		[Parameter()]
		[ValidateScript({
			if (Test-Connection -ComputerName $_ -Quiet -Count 1)
			{
				throw "The computer [$_] is offline. Try another"
			}
			else
			{
				$true
			}
		})]
		[ValidatePattern('^C:\\')]
		[string]$Path = 'C:\somebogusfolder',
		
		[Parameter()]
		[AllowNull()]
		[string]$OperatingSystem,
		
		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$NullParamTest,
		
		[Parameter()]
		[AllowNull()]
		[string]$AllowNullParam
	)
}

New-VirtualMachine

New-VirtualMachine -Name 'MYNEWVM'

#region Get-Help to find Mandatory parameters in cmdlets

## Using help optional parmameters and their values are shown in brackets

## No mandatory params
(Get-Help -Name Get-Service -Detailed).syntax

## Only Path is mandatory
(Get-Help -Name Get-Content -Detailed).syntax

#endregion

#region Get-Command to find Mandatory parameters in cmdlets

(Get-Command -Name 'Get-Content').Parameters.Path.Attributes

#endregion