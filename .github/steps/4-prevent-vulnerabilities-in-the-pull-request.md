## Step 4: Prevent Vulnerabilities in a Pull Request

In this step, we will add a vulnerability back into the `routes.py` file to trigger an alert.
However, this time the change will be on a pending pull request, being detected before it reaches production.

### ⌨️ Activity: Recreate a vulnerability

1. In the top navigation, select the **Code** tab.

1. Navigate to the `server` folder and select the `routes.py` file.

1. In the top right of the preview, click the **Edit** button.

   <img width="400" alt="edit button" src="https://github.com/user-attachments/assets/19462cc5-a360-4dae-a97b-ecfd571aa403"/>

1. Navigate to about **line 16** and modify it to the below to re-introduce the vulnerability.

   ```py
   "SELECT * FROM books WHERE name LIKE '%" + name + "%'"
   ```

1. Above the editor in the top-right, click the **Commit changes...** button. Don't commit it to `main`. Select the radio button next to **Create a new branch**.

1. Click **Propose changes** option and click **Create pull request**.

### ⌨️ Activity: Review pull request

At this point, we've edited the file `routes.py` to add our vulnerable code, committed those changes to our new branch, and created a pull request to merge the new branch into our `main` branch. These are the same steps a developer would take to introduce new, vulnerable code into a repository.

Now, let's take a look at the pull request to see what the experience is like.

1. In the previous activity, we created the pull request. After creating the pull request, you were brought directly to the pull request page. At the bottom of the pull request, you will see a check called "Code scanning/CodeQL". This is the CodeQL analysis job scanning the code introduced in the pull request.

   <img width="400" alt="pr panel" src="https://github.com/user-attachments/assets/1c29ee0f-cc1d-4568-9e71-338d45ad1d54"/>

1. Once the check is complete, you will see a new comment in the pull request from CodeQL indicating a new security vulnerability; a SQL query built from user-controlled data. This is our SQL injection vulnerability.

   <img width="400" alt="image" src="https://github.com/user-attachments/assets/677cc104-9116-44a9-8061-091e8126442a">

1. Review the data flow paths by clicking **Show paths**.

1. If you would like, add a comment and tag one of your friends by using their GitHub handle (example: `@username`). This will notify them that you made a comment on the issue and need their help solving the problem. 😄

   If this were a real-world situation, the developer would fix the SQL statement in their branch. Once fixed, the vulnerability will automatically close out.

   If you would like to learn more about pull request integrations for code scanning, see "[Triage code scanning alerts in pull requests](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/triaging-code-scanning-alerts-in-pull-requests)."

1. With the pull request started, Mona will check your progress and share a final review. Nice work! You are done! 🥳
