<!-- Start Document Outline -->

* [What’s New in Microsoft Intune – April 2025 Updates](#whats-new-in-microsoft-intune--april-2025-updates)
	* [1. A Brand New Intune Icon](#1-a-brand-new-intune-icon)
	* [2. OneDrive Personal Account Pop-Up on Business Devices](#2-onedrive-personal-account-pop-up-on-business-devices)
		* [Why This Matters:](#why-this-matters)
	* [3. Security Baseline Updates – Now with “Bonus Features”](#3-security-baseline-updates--now-with-bonus-features)
		* [Key Takeaways:](#key-takeaways)
	* [4. Delivery Optimization – New Settings Catalog Template](#4-delivery-optimization--new-settings-catalog-template)
		* [What’s Changing?](#whats-changing)
	* [5. Android Updates – More Settings Catalog Integration](#5-android-updates--more-settings-catalog-integration)
	* [6. Endpoint Privilege Management (EPM) – Granular PowerShell Control](#6-endpoint-privilege-management-epm--granular-powershell-control)
		* [What’s New?](#whats-new)
	* [7. Conditional Access – Token Protection for AVD & Windows 365](#7-conditional-access--token-protection-for-avd--windows-365)
		* [Key Details:](#key-details)
	* [Final Thoughts](#final-thoughts)

<!-- End Document Outline -->


# **What’s New in Microsoft Intune – April 2025 Updates**  

**Source:** Workplace Ninja Netherlands

In this blog post, we’ll dive into the key announcements and features released in **April 2025**, as discussed in the **Workplace Ninja Netherlands** podcast.  

Our panelists—**Kenneth Forssström**, **Joost Gelijsteen**, **Sander Rozemuller**, and **Frans Arundorp**—shared their insights on the latest Intune developments. Let’s break it all down.  

---  

## **1. A Brand New Intune Icon**  
Microsoft has introduced a **new icon** for Intune—not a full logo redesign, but a refreshed look. This change aligns with Microsoft’s broader modernization efforts across its security and endpoint management products.  

- **Why the change?** Microsoft is updating icons for a more cohesive and modernized look (similar to recent Defender updates).  
- **Impact:** Admins should update documentation, presentations, and training materials to reflect the new icon.  
- **Fun fact:** Some MVPs joked about avoiding Microsoft product tattoos since logos can change unexpectedly!  

**Pro Tip:** If you’re using the old icon in presentations, check out resources (like Simon Skotheim’s LinkedIn video) on updating them.  

---  

## **2. OneDrive Personal Account Pop-Up on Business Devices**  
Microsoft has introduced a new feature where users logged into **OneDrive for Business** with a **personal Microsoft account** will see a pop-up prompting them to connect their **personal OneDrive** as well.  

### **Why This Matters:**  
- **Potential data leakage risk:** Employees might accidentally sync corporate files to personal storage.  
- **Current workarounds:**  
  - **Block personal Microsoft accounts** via Intune (though this may be too restrictive for some orgs).  
  - Use **AllowedTenantList** (restricting sync to approved orgs only).  
- **Missing CSP setting:** Microsoft released a **Group Policy (GPO) setting** but hasn’t yet provided an Intune **CSP equivalent**.  

**What’s Next?** Expect Microsoft to add the CSP setting soon. For now, admins must rely on registry edits or GPOs if they need granular control.  

---  

## **3. Security Baseline Updates – Now with “Bonus Features”**  
Microsoft has **updated the Endpoint Security Baseline** with **new settings**, but with a twist:  

- **New settings are automatically added** when you **edit and save** an existing baseline policy.  
- **Example:** SMBv2 is now **disabled by default**—which could break legacy file-sharing if not tested.  

### **Key Takeaways:**  
✔ **Check before saving:** If you modify an existing baseline, new settings will apply immediately.  
✔ **Use deployment rings:** Test updates in phases to avoid disruptions.  
✔ **Consider Settings Catalog:** For more granular control, manually configure settings instead of relying on baselines.  

**Pro Tip:** Monitor the **Intune update GitHub page** for change logs.  

---  

## **4. Delivery Optimization – New Settings Catalog Template**  
Microsoft is **deprecating the old Delivery Optimization template** in favor of a **new Settings Catalog-based template**.  

### **What’s Changing?**  
- Admins must **migrate** existing policies to the new template.  
- The new approach provides **better organization** of related settings.  
- **Future-proofing:** More settings will be added to the catalog over time.  

**Recommendation:** Start transitioning to the new template to avoid issues when the old one is fully deprecated.  

---  

## **5. Android Updates – More Settings Catalog Integration**  
Microsoft continues to expand **Android management** within Intune:  

- **New Settings Catalog policies** for Android devices.  
- **Enrollment grouping:** Devices can now be dynamically assigned to groups post-enrollment (similar to Windows Autopilot).  
- **Teams Rooms Devices:** Many vendors are updating firmware to **Android AOSP**, allowing **Intune management** (including compliance policies).  

**Why This Matters:**  
- Better security and compliance for **shared Android devices** (like Teams Rooms).  
- More granular control over **app deployments and restrictions**.  

---  

## **6. Endpoint Privilege Management (EPM) – Granular PowerShell Control**  
EPM now supports **file arguments and parameters** in elevation rules.  

### **What’s New?**  
- Admins can now **restrict PowerShell execution** to **specific scripts + arguments** (e.g., `PowerShell.exe -ServiceName "ServiceX"`).  
- **Reduces risk:** Prevents misuse of elevated PowerShell sessions.  

**Use Case:** Allow users to restart a specific service without granting full admin rights.  

---  

## **7. Conditional Access – Token Protection for AVD & Windows 365**  
Microsoft is rolling out **Token Protection** (currently in **preview**) to prevent **token theft and replay attacks**.  

### **Key Details:**  
- **Binds tokens to the original device**, preventing reuse on unauthorized machines.  
- **Currently supports:**  
  - Exchange Online  
  - SharePoint Online  
  - **AVD & Windows 365 (via the new Windows App)**  
- **Not yet available for:** Local RDS environments.  

**Why This Matters?**  
- Adds an extra layer of security for **remote desktop sessions**.  
- Requires **Phishing-Resistant MFA** (e.g., FIDO2, Windows Hello for Business).  

**Recommendation:** Start testing in **non-production environments**.  

---  

## **Final Thoughts**  
April brought several **important updates**, from **security enhancements** to **UI changes**. Key takeaways:  

✅ **Update your Intune icon** in documentation.  
✅ **Monitor OneDrive sync settings** to prevent data leaks.  
✅ **Review Security Baselines**—new settings may apply automatically.  
✅ **Migrate Delivery Optimization policies** to the new template.  
✅ **Test Token Protection** for AVD/Windows 365 (if using P2 licenses).  

  

---  

