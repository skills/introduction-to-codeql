## Step 4: Fix Security Vulnerabilities

Let's fix the security vulnerability we introduced that CodeQL identified.

### ⌨️ Activity: Resolve an open alert

1. In the top navigation, select the **Security** tab.

1. In the left navigation, find the **Vulnerability alerts** area and select the **Code scanning** option.

1. Review the open alert and review the recommended changes.

1. In the top navigation, select the **Code** tab. Ensure you are on the branch for your pull request (`learning-codeql`).

1. Navigate to the `server` folder and select the `routes.py` file.

1. In the top right of the preview, click the **Edit** button.

   <img width="500" alt="edit button" src="https://github.com/user-attachments/assets/19462cc5-a360-4dae-a97b-ecfd571aa403"/>

1. Navigate to about **line 16** and modify it to the below.

   ```py
   "SELECT * FROM books WHERE name LIKE %s", name
   ```

1. Above the editor in the top-right, click the **Commit changes...** button. Use the defaults options to commit the changes to the `learning-codeql` branch.

   - CodeQL will now initiate a another scan.

1. In the top navigation, navigate to the **Actions** tab. Wait for the **CodeQL** workflow to finish.

1. Return the the open alerts page and review the open alerts.

   - There should be zero open alerts and two closed alerts. Nice work! 🎉
   - Feel free to review the closed alerts, especially the audit trail.

1. With the CodeQL scan finished, Mona will check your progress and share a final review. Nice work! You are done! 🥳
