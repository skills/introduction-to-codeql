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

1. On the new page, below the pull request description, press the **Create pull request** button.

### ⌨️ Activity: Review pull request

1. If needed, navigate to the newly created pull request from the previous activity.

1. Scroll to the bottom of the pull request and search for a check named `CodeQL`. This is the analysis job scanning the proposed code changes in the pull request.

   <img width="500" alt="CodeQL check in progress" src="https://github.com/user-attachments/assets/3c1721cf-e18d-4b8a-8feb-615033d53f4c" />

1. If the job is still running, wait a few minutes for it to complete.

1. Search the comments to find the results of the analysis.

   - Notice that the results found a SQL injection vulnerability. It also suggests a fix.
   - Don't worry about responding to this or resolving the problem (yet).

   <img width="500" alt="code scan results" src="https://github.com/user-attachments/assets/1914befe-e091-4905-bfdc-a5a252a73d2d" />

   > 💡 Tip: Clicking the **Show paths** link will provide additional insights about the alert's data flow from user input (source), through the application, and when it is acted on (sink).

### ⌨️ Activity: View the CodeQL scanning logs

1. In the top navigation, select the **Actions** tab.

1. In the left navigation, select the **CodeQL** entry to filter the workflow runs.

   <img width="500" alt="codeql filter" src="https://github.com/user-attachments/assets/9b66339d-0fba-4a72-be2e-5a0b2b5677b7"/>

1. Click on the workflow run with the name **PR #2** to open a page with more details.

   <img width="500" alt="codeql setup" src="https://github.com/user-attachments/assets/016a729e-3b41-466c-8edf-3d4b41a86b7d"/>

1. Expand the run jobs by clicking **Show all jobs** then click on the **Analyze (python)** entry. The list of all workflow steps is now shown.

   <img height="250" alt="matrix jobs" src="https://github.com/user-attachments/assets/36516944-5728-4f81-82ba-2d60658e88ff" />

   <img height="250" alt="list of codeql jobs" src="https://github.com/user-attachments/assets/418e1729-b406-444f-93b9-3d05d072d7de" />

1. Find the analysis entry and consider reviewing the logs.

   <img width="500" alt="python analysis logs" src="https://github.com/user-attachments/assets/56ac1cf6-8e51-4e1f-b7f5-2dd48a5e5614" />

1. With the pull request started and CodeQL scan finished, Mona will check your progress and share the next steps.

> [!TIP]
> Check out the [Triage code scanning alerts in pull requests](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/triaging-code-scanning-alerts-in-pull-requests) page to learn more about integration of code scanning into pull requests.
