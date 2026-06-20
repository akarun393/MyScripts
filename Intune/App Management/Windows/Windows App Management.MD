<!-- Start Document Outline -->

* [Windows App Management](#windows-app-management)
	* [App Types](#app-types)
	* [Line-of-business app - Windows](#line-of-business-app---windows)
		* [MSI](#msi)
			* [Configure a self-updating mobile MSI app to ignore the version check process.](#configure-a-self-updating-mobile-msi-app-to-ignore-the-version-check-process)
			* [Logging](#logging)
		* [MSIXBUNDLE](#msixbundle)
			* [Logging](#logging)
		* [MSIX](#msix)
			* [Logging](#logging)
		* [APPX](#appx)
			* [Logging](#logging)
		* [APPXBUNDLE](#appxbundle)
			* [Logging](#logging)
	* [Windows Web Link](#windows-web-link)
	* [Microsoft 365 Apps](#microsoft-365-apps)
		* [Office App Suite Configuration](#office-app-suite-configuration)
		* [Update Channel](#update-channel)
		* [File format](#file-format)
		* [Downloads](#downloads)
		* [Troubleshooting](#troubleshooting)

<!-- End Document Outline -->

# Windows App Management

## App Types

There are different Application types for the Windows Apps as listed below

1. Microsoft Store app (new)
2. Microsoft Store app (legacy)
3. Microsoft Edge for Windows 10 and later
4. Microsoft 365 Apps for Windows 10 and later
5. Windows web link
6. Web link
7. Line-of-business app
8. Windows app (Win32)

![App 1](Img/App_1.PNG)

## Line-of-business app - Windows

* A line-of-business (LOB) app is an app that you add to Microsoft Intune from an app installation file.
* Line-of-business (LOB) apps are commonly referred to as custom apps and in-house apps because they're typically created by your organization. These apps support a specific purpose for your organization.
* LOB apps are a staple of Intune and date back to its earliest days. LOB apps only require the creator to provide an installation file for the created application. 
* To include LOB apps in your managed environment, you upload the app installation file to Intune and assign the app to devices or groups from Intune.
* Intune supports LOB apps for Android devices, iOS/iPadOS devices, Windows devices, and macOS devices.

> NOTE: LOB Intune Windows apps are managed via native MDM, not the Intune Management Extension (IME).


Line of business app supports following format for Windows envrionment.

1. .MSI 
2. .MSIX
3. .APPX
4. .APPXBUNDLE
5. .MSIXBUNDLE


### MSI

* For instance Notepad++ app is taken as an example.
* Upload the MSI to Intune which automatically detects the product code.
* Add the command line arguments.
* Assign the app to the user groups as available.
* Maximum file size limit of 8GB per app.
* Default app install context is system.
* Does not have Win32 capabilities like Requirements, Detection rules, Dependencies, Supersedence.

![App 2](Img/App_2.PNG)

#### Configure a self-updating mobile MSI app to ignore the version check process.

* **What it does:** Prevents Intune from enforcing a specific MSI version on the client when the app updates itself independently.
* **When to use:** For MSI apps that have built-in auto-update mechanisms (e.g., Chrome, Zoom, Slack, or custom mobile apps that update themselves).

```Text
Scenario without "Ignore version":
1. Intune deploys App v1.0 → installed on device
2. App auto-updates to v2.0 (developer's update service)
3. Intune detects v2.0 (not matching deployed v1.0)
4. Intune reinstalls v1.0 (overwrites v2.0)
5. App auto-updates to v2.0 again
6. LOOP → Constant install/uninstall conflict
```
* **Result:** User sees repeated installations, failed statuses, and app instability.

#### Logging

* The LOB MSI application downloads in `C:\WINDOWS\system32\config\systemprofile\AppData\Local\mdm`
* LOB for windows apps install/unistall are logged in the below Intune specific events.


> Applications and Services Logs &rarr; Microsoft &rarr; Windows &rarr; DeviceManagement-Enterprise-Diagnostics-Provider/Admin

![Appevent 1](Img/Appevent_1.PNG)

**Event Results for NotePad ++ x64 MSI app**

* Filter the events as Level: Information its value is 4 and look for event IDs: 1900 to 3000. 

![Appevent 2](Img/Appevent_2.PNG)

* Look for the message column from bottom to top as we can see the Notepad++ installation process.
* We can see the Notepad++ MSI Product Code: `{B7579944-AC05-42A8-A5DF-57334855822A}` but the app name is not mentioned.
* Additionally we can see the Bits Job: `(9473d75a-8cfa-448e-8f99-cee030c7575a)` for the download.
* We can confirm the Bits job download from the below event.

> Applications and Services Logs &rarr; Microsoft &rarr; Windows &rarr; Bits-Client/Operational

### MSIXBUNDLE


![msixbundle 1](Img/msixbundle_1.PNG)

![msixbundle 2](Img/msixbundle_2.PNG)

![msixbundle 3](Img/msixbundle_3.PNG)

#### Logging

MSIXBUNDLE for windows apps install/unistall are logged in the below events.

> Applications and Services Logs &rarr; Microsoft &rarr; AppXDeployment-Server &rarr; Windows &rarr; Microsoft-Windows-AppXDeploymentServer/Operational

There are multiple events for the app install/uninstall. Consider the main event **ID: 400**

![msixbundle 4](Img/msixbundle_4.PNG)

![msixbundle 5](Img/msixbundle_5.PNG)

![msixbundle 6](Img/msixbundle_6.PNG)

### MSIX

![MSIX 1](Img/MSIX_1.PNG)

![MSIX 2](Img/MSIX_2.PNG)

![MSIX 3](Img/MSIX_3.PNG)

#### Logging

MSIX for windows apps install/unistall are logged in the below events.

> Applications and Services Logs &rarr; Microsoft &rarr; AppXDeployment-Server &rarr; Windows &rarr; Microsoft-Windows-AppXDeploymentServer/Operational

![MSIX 4](Img/MSIX_4.png)

![MSIX 5](Img/MSIX_5.png)

### APPX

![APPX 1](Img/APPX_1.PNG)

![APPX 2](Img/APPX_2.PNG)

When importing the main APPX application into Intune, it automatically detects the required dependencies, so we also need to upload the dependency file.

![APPX 3](Img/APPX_3.PNG)

#### Logging

APPX for windows apps install/unistall are logged in the below events.

> Applications and Services Logs &rarr; Microsoft &rarr; AppXDeployment-Server &rarr; Windows &rarr; Microsoft-Windows-AppXDeploymentServer/Operational

![APPX 4](Img/APPX_4.png)

![APPX 5](Img/APPX_5.png)

### APPXBUNDLE

![APPXBUNDLE 1](Img/APPXBUNDLE_1.PNG)

![APPXBUNDLE 2](Img/APPXBUNDLE_2.PNG)

![APPXBUNDLE 3](Img/APPXBUNDLE_3.PNG)

#### Logging

![APPXBUNDLE 5](Img/APPXBUNDLE_5.png)

![APPXBUNDLE 6](Img/APPXBUNDLE_6.png)

## Windows Web Link

![WindowsWebLink 1](Img/WindowsWebLink_1.PNG)

![WindowsWebLink 2](Img/WindowsWebLink_2.PNG)

![WindowsWebLink 3](Img/WindowsWebLink_3.PNG)

## Microsoft 365 Apps

* Office Click-to-Run is the new way of deploying Microsoft 365 apps – Office to your endpoints.
* It involves active downloading from the internet. Therefore, the installation elements are very small.
* Microsoft 365 apps are not like other apps in Microsoft Intune, as there is a policy that is deployed to the managed devices.
* The policy is similar to other CSPs deployed through the MDM channel to the device:
![Office365 5](Img/Office365_5.PNG)
* As it is a CSP policy and not a Win32 app, that is also the reason why you cannot use it as a dependency in a Win32 app.
* The CSP writes to the registry key **Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\OfficeCSP**, where it creates a default key with the value http://go.microsoft.com/fwlink/?LinkID=829801, at which point the setup.exe file downloads the file to the local device together with the XML file stored in the same registry location with a GUID.
* The combination of **setup.exe/configure** (the name of the Microsoft 365 Apps XML file) will then start downloading all the binaries from the Office CDN (the default option in the Microsoft Intune UI and configuration XML).

**Default reg key without office:**

![Office365 6](Img/Office365_6.PNG)

Once installation is complete, the FinalStatus registry key will be updated as follows:

* **status** = 0: 70 (succeeded)
* **status** = 0: 60 (failed)
* **status** = 0: 997  (Installation in Progress)



### Office App Suite Configuration

![Office365 1](Img/Office365_1.PNG)

![Office365 2](Img/Office365_2.PNG)

![Office365 3](Img/Office365_3.PNG)

![Office365 4](Img/Office365_4.PNG)

### Update Channel

| Feature                         | Current Channel (Preview)                                                                                                                | Current Channel                                                                                        | Monthly Enterprise Channel                                                                                                               |
|---------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| Primary Purpose                 | Provides organizations with **early access** to preview new features coming to the next Current Channel release, for testing and validation. | Delivers new features to users **as soon as they are ready**. This is the default and recommended channel. | Delivers new features on a predictable **monthly schedule**, giving IT administrators better planning and control.                           |
| Feature Update Frequency        | No fixed schedule. Typically released at least one week before the version is promoted to Current Channel.                               | No fixed schedule. Typically at least once per month, but may occur more frequently.                   | Once per month, on the second Tuesday of each month.                                                                                     |
| Security & Non-Security Updates | Delivered as needed, typically on the second Tuesday of each month.                                                                      | Typically delivered on the second Tuesday of each month, but may have 2-3 releases per month.          | Once per month, on the second Tuesday of each month.                                                                                     |
| Support Duration                | Until the next preview version is released (approximately 1 month).                                                                      | Until the next version is released (approximately 1 month).                                            | 2 months (extended from 1 month starting July 2025).                                                                                     |
| Recommended For                 | Testing with a limited set of users to identify compatibility issues early.                                                              | The majority of users who want the latest features as quickly as possible.                             | Enterprise environments that need a balance between new features and stability, with predictable update cycles for easier IT management. |


**NOTE:**

> Beginning in July 2026, Microsoft will unify the Semi-Annual Enterprise Channel (SAEC) and Monthly Enterprise Channel (MEC) into a single enterprise-focused update channel for Microsoft 365 Apps. This change is designed to simplify update management while continuing to provide a predictable, enterprise-ready servicing experience.

### File format

![Office365 7](Img/Office365_7.PNG)

### Downloads

 Using delivery optimization so the files will first be downloaded in the
 
> C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\cache

After that these files will be moved to the 

> C:\Program Files\Microsoft Office\Updates\Download\PackageFiles

After it finished downloading all the required installations files, it will start installing the Microsoft 365 apps on the device by triggering the OfficeClickToRun.exe

> C:\Program Files\Microsoft Office 15\ClientX64

### Troubleshooting

* Identify the issue is Intune or Office related.
* The device is properly enrolled into Microsoft Intune.
* Check Intune and Microsoft Office 365 network requirements and IP ranges are accessible.

**Known Issue:**  Office installed with Click-to-Run and Windows Installer on same computer isn't supported.

**Verbose logging**

* verbose logging for Office installation on the target machines. To do this, run the following command to modify the registry: 

> reg add HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v LogLevel /t REG_DWORD /d 3

* Deploy the Microsoft 365 Apps to the target devices again.
* Wait approximately 15 to 20 minutes and go to the %temp% folder and the %windir%\temp folder
* sort by Date Modified, pick the {Machine Name}-{TimeStamp}.log files that are modified according to your repro time.

**For sign-in or activation issues, run the following commands to add or delete the registry key:**

**Enable:**

reg add HKCU\Software\Microsoft\Office\16.0\Common\Logging /v EnableLogging /t REG_DWORD /d 1

**Disable:**

reg delete HKCU\Software\Microsoft\Office\16.0\Common\Logging /v EnableLogging

**For installation or patching issues, run the following commands to add or delete the registry keys:**

**Enable:**

reg add HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v LogLevel /t REG_DWORD /d 3
reg add HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v PipelineLogging /t REG_DWORD /d 1

**Disable:**

reg delete HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v PipelineLogging

reg delete HKLM\SOFTWARE\Microsoft\ClickToRun\OverRide /v LogLevel

* Restart the Microsoft Office Click-to-Run Service inside Services.msc for the logging to take effect.
* Reproduce the issue and collect the logs for review.
* The logs are stored under %windir%\temp and %temp% for installation or patching issues, in the format of **MachineName-Date-time.log**.

**ETL Log**

Look for additional information

> C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs


