<!--
  <<< Author notes: Step 4 >>>
  Start this step by acknowledging the previous step.
  Define terms and link to docs.github.com.
  TBD-step-4-notes.
-->

## Step 4: Prevent Vulnerabilities in the Pull Request

_Nicely done! You finished Step 3: Fix Security Vulnerabilites! :partying_face:_

Way to go! You made it this far. We're almost done! The last step is to test out the pull request integration with CodeQL. In this step, we will add a vulnerability back into the `routes.py` file to trigger an alert for a SQL injection vulnerability. This is going to be the same issue initially saw.  
  
Our goal is to understand what developers experience when they find a new vulnerability.  

In this step, we will:
- edit the `routes.py` file.
- change the SQL statement to make it insecure.
- commit those changes and merge the insecure code into the main branch.
- experience the alert inside the pull request.
  
Let's get started 👍

**What is pull request**: Pull requests are proposed changes to a repository submitted by a user and accepted or rejected by a repository's collaborators. This allows multiple people to work on the same code at the same time. For more information, check out the GitHub Skills course "[Introduction to GitHub](https://github.com/skills/introduction-to-github)" or "[About pull requests](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests)" from the GitHub docs.

**What is branch**: A branch is a parallel version of your repository. By default, your repository has one branch named main and it is considered to be the definitive branch. Creating additional branches allows you to copy the main branch of your repository and safely make any changes without disrupting the main project. For more information, see "[About branches](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-branches#)" in the GitHub docs.

### :keyboard: Activity 1: Edit `routes.py` and create a new pull request

In this first activity, we'll introduce the same insecure SQL statement from before to the `routes.py` file. Once we update the file, we'll commit it to a new branch, then create a pull request.

  1. Click the **Code** tab in your repository.
  2. Select the `server` folder.
  3. Select the `routes.py` file.
  4. Click the **Edit** button to the right.

![edit-button.png](/images/edit-button.png)
  
  5. Edit line 16 by highlighting the SQL statement and replace it with this text: `"SELECT * FROM books WHERE name LIKE '%" + name + "%'"`.
  6. Click **Commit changes...** from the top right. The "Propose changes" window will pop up.
  7. This time, select the radio button next to **Create a new branch**. You can create a new name for this branch or leave it as the default suggestion.
  8. Click **Propose changes**. This opens a new pull request.
  9. In the "Open a pull request" window, click **Create pull request**.
  

### :keyboard: Activity 2: Review pull request

At this point, we've edited the file `routes.py` to add our vulnerable code, committed those changes to our new branch, and created a pull request to merge the new branch into our `main` branch. These are the same steps a developer would take to introduce new, vulnerable code into a repository. 
  
Now, let's take a look at the pull request to see what the experience is like.
  
1. In the previous activity, we created the pull request.  After creating the pull request, you were brought directly to the pull request page. At the bottom of the pull request, you will see a check called "Code scanning/CodeQL". This is the CodeQL analysis job scanning the code introduced in the pull request.

![pr-panel](/images/pr-panel.png)

2.  Once the check is complete, you will see a new comment in the pull request from CodeQL indicating a new security vulnerability; a SQL query built from user-controlled data. This is our SQL injection vulnerability.
  
  <img width="1180" alt="image" src="https://github.com/leftrightleft/enable-code-scanning/assets/4910518/378bd766-ef61-4619-ab3c-bf2c8d9618d7">

3. Review the data flow paths by clicking **Show paths**.
  
4. If you would like, add a comment and tag one of your friends by using their GitHub handle (example: `@username`). This will notify them that you made a comment on the issue and need their help solving the problem. 😄

If this were a real-world situation, the developer would fix the SQL statement in their branch. Once fixed, the vulnerability will automatically close out.

If you would like to learn more about pull request integrations for code scanning, see "[Triaging code scanning alerts in pull requests](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/triaging-code-scanning-alerts-in-pull-requests)."

5. Wait about 20 seconds then refresh this page (the one you're following instructions from). [GitHub Actions](https://docs.github.com/en/actions) will automatically update to the next step.
