## Step 3: Fix Security Vulnerabilities

Let's fix the existing security vulnerabilities already identified by CodeQL. Remember, at this point, we have introduced CodeQL into our repository and it has scanned the existing code. The vulnerabilities it found are real-world issues, and they need to be fixed!

Now that both of these alerts are open, let's fix them. If you look at the alerts, they both call out one specific file containing the issues: `server/routes.py`. The issue is in crafting the SQL query for the database. These queries are vulnerable to SQL injection attacks. We should rewrite these SQL statements more securely.

If you expand the **More info** section at the bottom of the alert, there are very clear suggestions to fix this query. We're going to implement those suggestions in the next activity.

### ⌨️ Activity: Resolve an open alert

1. In the top navigation, select the **Security** tab.

1. In the left navigation, find the **Vulnerability alerts** area and select the **Code scanning** option. You should see two open alerts.

   > 🪧 Note: If any of the alerts are `Closed`, go to the alert's page and choose **Reopen alert**.

1. Review the 2 open alerts and review the recommendations to decide changes to make.

1. In the top navigation, select the **Code** tab.

1. Navigate to the `server` folder and select the `routes.py` file.

1. In the top right of the preview, click the **Edit** button.

   <img width="400" alt="edit button" src="https://github.com/user-attachments/assets/19462cc5-a360-4dae-a97b-ecfd571aa403"/>

1. Navigate to about **line 16** and modify it to the below.

   ```py
   "SELECT * FROM books WHERE name LIKE %s", name
   ```

1. Above the editor in the top-right, click the **Commit changes...** button. Use the defaults options to commit the changes to `main`.

   - CodeQL will now initiate a another scan.

1. In the top navigation, navigate to the **Actions** tab. Wait for the **CodeQL** workflow to finish.

1. Return the the open alerts page and review the open alerts.

   - There should be zero open alerts and two closed alerts. Nice work! 🎉
   - Feel free to review the closed alerts, especially the audit trail.

<!-- 1. With the CodeQL job finished, Mona will check your progress and share the next steps. -->

1. With the pull request started, Mona will check your progress and share a final review. Nice work! You are done! 🥳




<!-- 1. Navigate back to **Security** tab and **Code scanning alerts** area.

1. Click the **1 Closed** text to switch to a view showing closed alerts.

   <img width="500" alt="one closed alert" src="https://github.com/user-attachments/assets/b10005b6-9ef8-4d46-a160-4c9849d2c898"/> -->