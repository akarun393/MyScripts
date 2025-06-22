# Windows Autopilot
<!-- Start Document Outline -->

* [Windows Autopilot](#windows-autopilot)
	* [Technical Requirements](#markdigsyntaxinlineshtmlinlinemarkdigsyntaxinlineshtmlinline-technical-requirements)
	* [Windows Autopilot Overview](#windows-autopilot-overview)

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




