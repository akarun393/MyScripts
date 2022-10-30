## 1. SystemRAM

[int32]$envSystemRAM = Get-WMIObject -Class Win32_PhysicalMemory -ComputerName $env:COMPUTERNAME -ErrorAction 'SilentlyContinue' | Measure-Object -Property Capacity -Sum -ErrorAction SilentlyContinue | ForEach-Object {[Math]::Round(($_.sum / 1GB),2)}
$envSystemRAM

#  2. Get the OS Architecture
[boolean]$Is64Bit = [boolean]((Get-WmiObject -Class 'Win32_Processor' -ErrorAction 'SilentlyContinue' | Where-Object { $_.DeviceID -eq 'CPU0' } | Select-Object -ExpandProperty 'AddressWidth') -eq 64)
If ($Is64Bit) { [string]$envOSArchitecture = '64-bit'; $envOSArchitecture } Else { [string]$envOSArchitecture = '32-bit'; $envOSArchitecture}



## Variables: Current Process Architecture
[boolean]$Is64BitProcess = [boolean]([IntPtr]::Size -eq 8)
If ($Is64BitProcess) { [string]$psArchitecture = 'x64'; $psArchitecture} Else { [string]$psArchitecture = 'x86'; $psArchitecture }


