# Windows Autopilot
<!-- Start Document Outline -->

* [Windows Autopilot](#windows-autopilot)
	* [✅ Technical Requirements](#-technical-requirements)
	* [Windows Autopilot Overview](#windows-autopilot-overview)
	* [Uploading the hardware ID to Windows Autopilot](#uploading-the-hardware-id-to-windows-autopilot)
		* [Command](#command)
			* [CSV file contents](#csv-file-contents)

<!-- End Document Outline -->



## :white_check_mark: Technical Requirements
Windows Autopilot has some prerequisites:

	• Microsoft Entra ID automatic enrollment needs to be configured.
	• The user needs an Intune license.
	• Microsoft Entra ID P1 or P2 subscription
	• The device needs to be registered in the Windows Autopilot service.
	• Entra ID branding needs to be configured.
## Windows Autopilot Overview

<small>Windows Autopilot is a provisioning method for modern devices. 
It is not OSD in the traditional manner.
Windows Autopilot requires a cloud identity and cloud device identity, which can be either a hybrid Entra ID join or an  Entra ID join.</small>
![Autopilot Overview](WindowsAutopilot/AutopilotOverview.png)
* <small> You get started with Autopilot by getting your devices uploaded to the Autopilot service, creating and assigning an Autopilot profile.
* Then creating and assigning an ESP profile (this step is optional but recommended).
* After your device is shipped, the user simply has to enter their credentials before automatic enrollment starts.
* After entering the correct credentials, you will be met by the Entra ID sign-in workflow.
* Then, enrollment starts, and all your configuration items, policies, certificates, and applications are applied to your physical endpoint device.
* As soon as this phase is completed, the user can see the desktop.
</small>

## Uploading the hardware ID to Windows Autopilot
The Windows Autopilot hardware hash is a 4K string retrieved from the Windows 10 or Windows 11 OS on the device by running `Get-WindowsAutoPilotInfo.ps1`

### Command
**Offline:**
```powershell
Install-Script -Name Get-WindowsAutoPilotInfo
Get-WindowsAutoPilotInfo.ps1 -OutputFile Hash.csv
```
Collect the csv and upload to the listed location below in Intune.

>  Devices ->Enrollment ->Windows (tab) ->Windows Autopilot (section) ->Devices

#### CSV file contents

The csv file contains the listed below.

* Device Serial Number
* Windows Product ID
* Hardware Hash
* GroupTag (optional)

The recommended way to get your brand-new devices into the Windows Autopilot service is to have your OEM or a Microsoft Cloud Solution Provider (CSP) partner upload the information.

**Online:**
```powershell
Set-ExecutionPolicy Bypass -Force
Install-PackageProvider Nuget -Confirm:$false -Force
Install-Module WindowsAutopilotIntune -Force
Install-Script -Name Get-WindowsAutoPilotInfo -Force
Get-WindowsAutoPilotInfo.ps1 -GroupTag "GroupName" -Online
```
* We can ignore group tag if we want to go by default "ZTDid"
* -online switch opens up the Authentication window.. Need to enter our Intune tenant login details and get authenticated so the device get registered.
* Once device is added, we need to wait for the profile status to assigned then go for autopilot OOBE process



