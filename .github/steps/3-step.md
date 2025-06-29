## Step 3: Review and Triage CodeQL Alerts

With our pull request changes now reviewed by CodeQL, let's take a moment to learn about managing alerts.

GitHub provides a dedicated **Security** tab for securely managing all security related issues. CodeQL saves alerts using the same standard as many other analysis tools with the results showing up under the **Code scanning** area.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/cf4fc6ec-e40e-4df6-8984-b6ec35341737" />

### What information do alerts provide?

The main area of an alert provides the resolution status, affected branch, code location, and classification information like severity and [CVE identification number](https://docs.github.com/en/code-security/security-advisories/working-with-repository-security-advisories/about-repository-security-advisories#cve-identification-numbers).


<img width="500" alt="additional information" src="https://github.com/user-attachments/assets/9a5aaf3f-e063-4d07-8cdd-6272eec8a411"/>

<!-- > 💡 Tip: Clicking the **Show paths** link will provide additional insights about the alert's data flow from user input (source), through the application, and when it is acted on (sink). -->

### What is 'CWE'

Many of the patterns CodeQL scans for come from existing databases of vulnerabilities.

The Common Weakness Enumeration (CWE) is a category system for hardware and software weaknesses and vulnerabilities. Think of it as a way to describe and categorize security issues in an application's source code. For more information on CWEs, see the Wikipedia article [Common Weakness Enumeration](https://en.wikipedia.org/wiki/Common_Weakness_Enumeration).

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

1. Click on an alert.

1. Notice the description, related vulnerability information and a recommended solution.

    <img width="500" alt="recommendations" src="https://github.com/user-attachments/assets/a5653b45-b66f-4e5b-8e03-a7b8cd3b91b4"/>

1. (Optional) Click the **View source** link to view the CodeQL query that detected the alert.

1. (Optional) Click the **Show more** link to view the full recommendation.

1. Inspect the audit trail to see a secure history of the alert, including open/close information.

    <img width="500" alt="audit trail" src="https://github.com/user-attachments/assets/25ec5256-20c7-4e9d-8160-ff40f3763872"/>

### ⌨️ Activity: Dismiss and Reopen an Alert

1. In the top right, click **Dismiss alert** dropdown.

1. Select any reason and add a short explanation then click the **Dismiss alert** button.

   - The alert state will change to `Dismissed`.
   - An entry is added to the audit trail, which can't be removed or edited.

1. Reopen the alert.

   - The alert state will change to `Open`.
   - An entry is added to the audit trail, which can't be removed or edited.

