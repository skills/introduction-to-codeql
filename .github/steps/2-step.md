## Step 2: Review and Triage CodeQL Alerts

Now we will review the CodeQL scan results, triage an alert, and create a GitHub issue to track an alert.

### What is CWE

Common Weakness Enumeration (CWE) is a category system for hardware and software weaknesses and vulnerabilities. Think of it as a way to describe and categorize security issues in an application's source code. For more information on CWEs, see the Wikipedia article [Common Weakness Enumeration](https://en.wikipedia.org/wiki/Common_Weakness_Enumeration).

### ⌨️ Activity: View the status of a CodeQL scan

1. In the top navigation, select the **Actions** tab.

1. If needed, wait a moment for the CodeQL run to finish (about 4 minutes).

1. Click on the **CodeQL Setup** workflow run entry to open a page showing more details.

   <img width="500" alt="codeql setup" src="https://github.com/user-attachments/assets/016a729e-3b41-466c-8edf-3d4b41a86b7d"/>

   > 💡 Tip: The workflow run contains additional CodeQL information such as the run duration, logs, and analysis artifacts.

### ⌨️ Activity: Review an Alert

1. In the top navigation, select the **Security** tab.

1. In the left navigation, find the **Vulnerability alerts** area and select the **Code scanning** option.

1. (Optional) Use the filters and search bar to explore the open and closed security alerts, including from the CodeQL scan.

#### Alert status and location

The main area of the alert provides the resolution status, affected branch, code location, and classification information like severity and [CVE identification number](https://docs.github.com/en/code-security/security-advisories/working-with-repository-security-advisories/about-repository-security-advisories#cve-identification-numbers).

> 💡 Tip: Clicking the **Show paths** link will provide additional insights about the alert's data flow from user input (source), through the application, and when it is acted on (sink).

<img width="500" alt="alert status" src="https://github.com/user-attachments/assets/2fecc67d-52ef-44fc-ad89-1eb28ceb9437">

<img width="500" alt="location information" src="https://github.com/user-attachments/assets/1a450118-f200-436b-8433-04b7e5e4f1a8"/>

<img width="500" alt="additional information" src="https://github.com/user-attachments/assets/9a5aaf3f-e063-4d07-8cdd-6272eec8a411"/>

#### Explanation and Recommendation

This alert is further described, justified, and a recommended solution is provided when possible.

- Click the **View source** link to view the CodeQL query that detected the alert.
- Click the **Show more** link to view the full recommendation.

<img width="500" alt="recommendations" src="https://github.com/user-attachments/assets/a5653b45-b66f-4e5b-8e03-a7b8cd3b91b4"/>

#### Audit trail

The audit trail provides a secure history of the alert for future reference, like who marked the vulnerability as closed/fixed.

<img width="500" alt="audit trail" src="https://github.com/user-attachments/assets/25ec5256-20c7-4e9d-8160-ff40f3763872"/>

### ⌨️ Activity: Dismiss an Alert

1. On the alert page, in the top right, click **Dismiss alert** dropdown.

1. Select any reason and add a short explanation then click the **Dismiss alert** button.

    - The alert state will change to `Dismissed` and an audit trail entry will be added.

1. Navigate back to **Security** tab and **Code scanning alerts** area.

1. Click the **1 Closed** text to switch to a view showing closed alerts.

   <img width="500" alt="one closed alert" src="https://github.com/user-attachments/assets/b10005b6-9ef8-4d46-a160-4c9849d2c898"/>