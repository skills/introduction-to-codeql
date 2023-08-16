<!--
  <<< Author notes: Step 3 >>>
  Start this step by acknowledging the previous step.
  Define terms and link to docs.github.com.
  TBD-step-3-notes.
-->

## Step 3: Fix Security Vulnerabilities

_Nice work finishing Step 2: Reviewing and Triaging CodeQL Alerts :sparkles:_
  
In this step, we will work to fix the existing security vulnerabilities already identified by CodeQL. Remember, at this point, we have introduced CodeQL into our repository and had it scan the existing code. The vulnerabilities it found are real-world issues, and they need to be fixed! We'll fix this issue by editing the `/server/routes.py` file.  

### :keyboard: Activity 1: Review alerts
First, before we fix these alerts, we need to make sure the alerts are still open. We'll also need to gather information on which files to fix and how best to fix them.

1. Navigate to your code scanning alerts page: **Security** > **Code scanning**. 
1. You should see two alerts listed as "**Open**". If any of the alerts are listed as "**Closed**", open the alert page and choose **Reopen alert**.

Now that both of these alerts are open, let's fix them. If you look at the alerts, they both call out one specific file containing the issues: `server/routes.py`. The issue is in crafting the SQL query for the database. These queries are vulnerable to SQL injection attacks. We should rewrite these SQL statements more securely. 
  
If you expand the **More info** section at the bottom of the alert, there are very clear suggestions to fix this query. We're going to implement those suggestions in the next activity.

### :keyboard: Activity 2: Edit routes.py
We now know where the issues exist and how to fix them. We'll start by modifying the file `routes.py`. Again, you'll want to do these next steps in a separate browser window or tab.
  
1. Click the **Code** tab in your repository.
2. Select the `server` folder.
3. Select the `routes.py` file.
4. Click the **Edit** button to the right.
  
  ![edit-button.png](/images/edit-button.png)
  
5. Edit line 16 by highlighting the SQL statement and replace it with this text: `"SELECT * FROM books WHERE name LIKE %s", name`.
  
6. Edit line 22 to replace the SQL statement with this text: `"SELECT * FROM books WHERE author LIKE %s", author`.
  
7. Click **Commit changes...** from the top right. The "Propose changes" window will pop up. Leave the defaults configured, and click **Commit changes** again.
8. CodeQL will now initiate a new scan. Check the status of that scan by navigating to **Actions** then choose the **CodeQL** action. Once the scan job completes, Actions will display a green check next to the last run.
9. Once that CodeQL scan is done, navigate to **Security** > **Code scanning** to review the alerts. You should have zero open alerts and two closed alerts 🎉. Feel free to review the closed alerts, especially the audit trail.  
10. Wait about 20 seconds then refresh this page (the one you're following instructions from). [GitHub Actions](https://docs.github.com/en/actions) will automatically update to the next step.
