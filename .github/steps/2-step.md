## Step 2: Detect Vulnerabilities in a Pull Request

To see how Code Scanning works, we will introduce a vulnerability into the `routes.py` file to trigger an alert.

### ⌨️ Activity: Create a vulnerability

1. In the top navigation, select the **Code** tab.

1. Navigate to the `server` folder and select the `routes.py` file.

1. In the top right of the preview, click the **Edit** button.

   <img width="500" alt="edit button" src="https://github.com/user-attachments/assets/19462cc5-a360-4dae-a97b-ecfd571aa403"/>

1. Navigate to about **line 16** and modify it to the below.

   ```py
   "SELECT * FROM books WHERE name LIKE '%" + name + "%'"
   ```

1. Above the editor in the top-right, click the **Commit changes...** button. In the prompt window, select the radio button for the **Create a new branch** option. **DO NOT commit to the main branch.**

1. Click the **Propose changes** option and click **Create pull request**. Use the below branch name.

   ```txt
   learning-codeql
   ```

### ⌨️ Activity: Review pull request

1. If needed, navigate to the newly created pull request from the previous activity.

1. Scroll to the bottom of the pull request and search for a check named `CodeQL`. This is the analysis job scanning the proposed code changes in the pull request.

   <img width="500" alt="pr panel" src="https://github.com/user-attachments/assets/1c29ee0f-cc1d-4568-9e71-338d45ad1d54"/>

1. If the job is still running, wait a few minutes for it to complete.

1. Search the comments to find a report from the analysis.

   - Notice that the results found a SQL injection vulnerability. It is also suggesting a fix.
   - Don't worry about responding or resolving this problem (yet).

   <img width="500" alt="image" src="https://github.com/user-attachments/assets/677cc104-9116-44a9-8061-091e8126442a">

### ⌨️ Activity: View the CodeQL scanning logs

1. In the top navigation, select the **Actions** tab.

1. Click on the **CodeQL Setup** workflow run entry to open a page showing more details.

   <img width="500" alt="codeql setup" src="https://github.com/user-attachments/assets/016a729e-3b41-466c-8edf-3d4b41a86b7d"/>

   > 💡 Tip: The workflow run contains additional CodeQL information such as the run duration, logs, and analysis artifacts.

1. With the pull request started and CodeQL scan finished, Mona will check your progress and share the next steps.

> [!TIP]
> Check out the [Triage code scanning alerts in pull requests](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/triaging-code-scanning-alerts-in-pull-requests) page to learn more about integration of code scanning into pull requests.

<!-- > 💡 Tip: Clicking the **Show paths** link will provide additional insights about the alert's data flow from user input (source), through the application, and when it is acted on (sink). -->
