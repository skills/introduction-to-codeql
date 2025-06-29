## Step 2: Prevent Vulnerabilities in a Pull Request

In this step, we will introduce a vulnerability into the `routes.py` file to trigger an alert.

### ⌨️ Activity: Recreate a vulnerability

1. In the top navigation, select the **Code** tab.

1. Navigate to the `server` folder and select the `routes.py` file.

1. In the top right of the preview, click the **Edit** button.

   <img width="400" alt="edit button" src="https://github.com/user-attachments/assets/19462cc5-a360-4dae-a97b-ecfd571aa403"/>

1. Navigate to about **line 16** and modify it to the below.

   ```py
   "SELECT * FROM books WHERE name LIKE '%" + name + "%'"
   ```

1. Above the editor in the top-right, click the **Commit changes...** button. Select the radio button next to **Create a new branch**. **DO NOT commit it to main branch.**

1. Click **Propose changes** option and click **Create pull request**.

### ⌨️ Activity: Review pull request

1. If needed, navigate to the newly created pull requests from the previous activity.

1. Scroll to the bottom of the pull request. Search for a check named `CodeQL`. This is the analysis job scanning the proposed code changes in the pull request.

   <img width="500" alt="pr panel" src="https://github.com/user-attachments/assets/1c29ee0f-cc1d-4568-9e71-338d45ad1d54"/>

1. If the job is still running, wait a few minutes for it to complete.

1. Search the comments to find a report from the analysis.

   - Notice that the results found a SQL injection vulnerability. It is also suggesting a fix.
   - Don't worry about responding or resolving this problem (yet).

   <img width="500" alt="image" src="https://github.com/user-attachments/assets/677cc104-9116-44a9-8061-091e8126442a">

1. With the pull request started, Mona will check your progress and share the next steps.


<!-- If you would like to learn more about pull request integrations for code scanning, see "[Triage code scanning alerts in pull requests](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/triaging-code-scanning-alerts-in-pull-requests)." -->