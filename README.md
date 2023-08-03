<!--
  <<< Author notes: Header of the course >>>
  Read <https://skills.github.com/quickstart> for more information about how to build courses using this template.
  Include a 1280×640 image, course name in sentence case, and a concise description in emphasis.
  In your repository settings: enable template repository, add your 1280×640 social image, auto delete head branches.
  Next to "About", add description & tags; disable releases, packages, & environments.
  Add your open source license, GitHub uses the MIT license.
-->

# Secure Your Repository Source Code 

Ensuring the security of application source code is a critical step in modern software development.  In this GitHub Skills course, you will learn to use GitHub code scanning to identify, resolve, and prevent insecure coding patterns.

<!--
  <<< Author notes: Start of the course >>>
  Include start button, a note about Actions minutes,
  and tell the learner why they should take the course.
  Each step should be wrapped in <details>/<summary>, with an `id` set.
  The start <details> should have `open` as well.
  Do not use quotes on the <details> tag attributes.
-->

<details id=0 open>
<summary><h2>Welcome</h2></summary>

👋 Hello!  Welcome to the GitHub Skills course: Secure Your Repository Source Code!  In this course, we will explore using GitHub code scanning, powered by [CodeQL](https://codeql.github.com/), to identify common coding practices that can lead to security vulnerabilities.  During this course, we will enable code scanning on your repository to identify, remediate, and prevent vulnerabilities.
  
Code scanning is part of the [GitHub Advanced Security (GHAS)](https://docs.github.com/en/get-started/learning-about-github/about-github-advanced-security) product suite.  All of the features of Advanced Security are 100% free for open source, public repositories.

- **Who is this for**: Developers, security engineers, open source maintainers.
- **What you'll learn**: Enabling code scanning, identifying SQL injection vulnerabilities with CodeQL.
- **What you'll build**: A secure software development pipeline that allows you to identify and prevent new security vulnerabilities from being introduced into your production code.
- **Prerequisites**: A baseline knowledge of GitHub concepts such as pull requests, Actions, and source code.  You'll also need to be familiar with the concepts of Static Application Security Testing (SAST).  Don't worry, we'll demistify the complex parts for you 🙂.
- **How long**: This course is four steps long and takes less than 30 minutes to complete.

## How to start this course

<!-- For start course, run in JavaScript:
'https://github.com/new?' + new URLSearchParams({
  template_owner: 'TBD-organization',
  template_name: 'TBD-course-name',
  owner: '@me',
  name: 'TBD-organization-TBD-course-name',
  description: 'My clone repository',
  visibility: 'public',
}).toString()
-->

[![start-course](https://user-images.githubusercontent.com/1221423/235727646-4a590299-ffe5-480d-8cd5-8194ea184546.svg)](https://github.com/new?owner=&template_name=enable-code-scanning&template_owner=leftrightleft)

1. Right-click **Start course** and open the link in a new tab.
2. In the new tab, most of the prompts will automatically fill in for you.
   - For owner, choose your personal account or an organization to host the repository.
   - We recommend creating a public repository, as private repositories will [use Actions minutes](https://docs.github.com/en/billing/managing-billing-for-github-actions/about-billing-for-github-actions).
   - Scroll down and click the **Create repository** button at the bottom of the form.
3. After your new repository is created, wait about 20 seconds, then refresh the page. Follow the step-by-step instructions in the new repository's README.

</details>

<!--
  <<< Author notes: Step 1 >>>
  Choose 3-5 steps for your course.
  The first step is always the hardest, so pick something easy!
  Link to docs.github.com for further explanations.
  Encourage users to open new tabs for steps!
  TBD-step-1-notes.
-->

<details id=1>
<summary><h2>Step 1: Enable CodeQL</h2></summary>

👋 Hello! Welcome to the GitHub Skills course: Secure Your Repository Source Code! 

Let's get started!  

In this first step, we'll be learning more about CodeQL and how to use it to secure your source code. 

**What is GitHub code scanning**: [Code scanning](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/about-code-scanning) is a capability that allows development teams to integrate security testing tools into the software development process.  This is done using GitHub Actions.  With code scanning, you can integrate many different types of tools including SAST, container, and infrastructure as code security tools.

**What is CodeQL**: [CodeQL](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/about-code-scanning-with-codeql) is a static analysis testing tool created by the team at GitHub.  CodeQL is a deep semantic analysis tool that helps you identify security weaknesses such as SQL injection, cross-site scripting, and code injection issues.  

### :keyboard: Activity: Enable code scanning with CodeQL

  1. Open a new browser tab, and work on the steps in your second tab while you read the instructions in this tab.
  2. Navigate the to **settings** tab at the top of your repository.
  3. Inside the repository settings page navigate to **Code security and analysis** in the left-hand navigation, under the **Security** heading
  4. Scroll down to the section titled **Code scanning**.  Here we will configure the CodeQL analysis.  There are two sections, "CodeQL analysis" and "Other tools"  for now we will focus on CodeQL analysis.  Feel free to browse the other code scanning tool integrations by choosing "Explore other workflows".  We're not going to set up any other tools in this course, though. 
  5. Select the **Set up** dropdown and choose **Default**
  <img width="837" alt="image" src="https://github.com/leftrightleft/enable-code-scanning/assets/4910518/c539dc7a-0c94-4137-b17f-18f965039165">

  6. Let's take a look at the config options in the modal:
  
      - **Languages to analyze:** These are the languages that will be scanned by CodeQL.  In this case, it's `Python`.  
      - **Query suites:** CodeQL [queries](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/about-code-scanning-with-codeql#about-codeql-queries) are packaged per language and are grouped into "suites".  The `Default` query suite is a highly precise group of security queries, while the `Extended` query suite includes additional queries with slightly lower precision and severity.  This section allows you to choose which query suite to use.  We'll leave this set as **Default** for this exercise
      - **Events:** This section tells CodeQL when to scan.  In this case, it's set to scan on any pull request to the `main` branch.
        <img width="903" alt="image" src="https://github.com/leftrightleft/enable-code-scanning/assets/4910518/516b6b43-e172-4324-86e9-21c4a74ca610">

7. Press **Enable CodeQL**
8. Wait about 20 seconds then refresh this page for the next step.

</details>

<!--
  <<< Author notes: Step 2 >>>
  Start this step by acknowledging the previous step.
  Define terms and link to docs.github.com.
  TBD-step-2-notes.
-->

<details id=2>
<summary><h2>Step 2: Review and Triage CodeQL Alerts</h2></summary>

_Way to go! You got CodeQL running! :tada:_

In this exercise, we'll review the CodeQL findings and understand how to triage the alerts.  We have 5 activities we'll accomplish in this step:
  1. View the status of a CodeQL scan
  2. View the CodeQL alerts
  3. Review an alert
  4. Dismiss an alert
  5. Create a GitHub issue to track an alert

**What is GitHub Actions**:  GitHub Actions is the automation and CI/CD platform within GitHub.  We use Actions to orchestrate and execute security scans with code scanning.  More information on GitHub Actions is available [here](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions)
**What is CWE**: CWE stands for Common Weakenss Enumeration.  You can think of it as a way to describe and categorize security issues in application source code.  More information on CWEs is available in this [wikipedia article](https://en.wikipedia.org/wiki/Common_Weakness_Enumeration)

### :keyboard: Activity 1: View the status of a CodeQL scan

  In this activity, we'll explore GitHub Actions to view the status of a CodeQL scan.  
  1. Go to your Actions page by selecting **Actions** from the top navigation bar
  2. If the CodeQL Action run is still executing, you will see a yellow spinner indicating the scan is still in progress.  This typically takes about 4 minutes to complete.
    ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/77acac2d-49df-4ef8-a23b-db9260dce01d)

  3. Select the run by clicking on **CodeQL Setup**
  4. Much more information in available inside the Actions run.  Feel free to explore this section to view information such as the CodeQL logs, duration, status, and artifacts generated by CodeQL 
  5. Once the scan is complete, a green check will show next to the execution.  
  
### :keyboard: Activity 2: View all CodeQL Alerts

  In this activity, we will view the CodeQL findings in the Security page of your repository.  The Security page is where all security related information is displayed. 
  1. Navigate to the **Security** tab in the top navigation bar of your repository
    ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/b9d39c6c-34a7-45e8-8a84-ccfe89f9ac65)
  
  2. Select **Code scanning** under the "Vulnerability alerts" heading in left-side navigation bar
  3. This screen will contain all the vulnerabilities identified by CodeQL inside this repository's codebase.  Explore the different filters and search capabilities in this page.  These filtering capabilities become very helpful when you're working with many findings!


### :keyboard: Activity 3: Review an Alert
In this activity, we will work through a CodeQL alert.  We'll understand how to view the data-flow of the vulnerability, understand what part of the code the alert impacts, and learn how to get more information about the alert.  There are no changes in this activity, we're just working through the alert UI. 

* **Alert status:** This section shows the current alert status (open or closed), as well as which branch this alert was found in and when it was found
  
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/5c34e1ac-d7ab-47b4-a83a-4a86a473cb9b)

* **Location information:**  This section describes which part of the code is vulnerable.  
  
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/b402aef6-ca19-491b-a2a0-1d402106e64f)
  
* **Paths:** Feel free to click on **Show paths** to get more insights into the alert's data-flow.  The modal that opens up is very helpful in understanding where the user input (we call that a source) flows through the application until it's acted on (we call this the sink).  This modal helps to understand the flow of data through your application
  
* **Recommendations:** This section includes some more very useful information.  In the top bar, you can see the tool (CodeQL in this case), Rule ID, and even view the CodeQL query used to find this vulnerabilitiy.  You can view the query by clicking **View source**.  Additionally, this pane includes recommendations for fixing this vulnerability.  Click **Show more** to view the full recommendation
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/fc149d1f-6593-4f6f-9f3c-e3b64b4bd2ab)

* **Audit trail:** The audit trail section of the alert shows the history of the alert.  As users mark a finding as closed, or fix a finding in code, we track those changes here
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/6cc9e07e-c32c-4868-a4c3-0fb97544ea3f)

* **Alert tirage:** To triage an alert, or open a new issue, you will use these buttons.  Don't do anything yet 😄. We'll get into these buttons in a moment!
  
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/604e4812-eaa3-4732-8520-00fae0ea68cd)

* **Additional info:** Finally, the right-side panel contains information such as tags, CWE information, and the severity of the alert
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/eecd7776-1dfc-4d40-856b-0a7a1a81f653)


### :keyboard: Activity 4: Dismiss an Alert
Now that we're familiar with the alert layout, let's work through the process of closing one!

1. Inside the same alert you just opened, click the **Dismiss alert** button, then choose any reason for dismissal, and add a short note.
2. Click **Dismiss alert**
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/5eb98ae6-2bb2-4ebd-a302-a30cb4e058c8)

3. At this point, the alert will change state to "Dismissed".  You also see that the change you made has been added to the audit trail at the bottom of the alert
4. Navigate back to **Security** > **Code scanning alerts**.  You'll see that you only have 1 alert listed.
5. Click **1 Closed**.  This will bring you to the closed alerts where you can view the alert you just closed
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/9842b7b7-d6fe-4755-83dc-048425dc55ce)

6. Feel free to reopen the alert by opening it, then selecting **Reopen alert**

### :keyboard: Activity 5: Create a GitHub Issue for an Alert
This last step will show you how to create a GitHub Issue to track the work that goes into resolving a vulnerability.  Issues are nice because they can provide a location to collaborate on a security problem, the same way we would a traditional software bug.  Additionally, issues can be assigned to people or teams.
  
1. Open one of the open alerts that CodeQL originally found.  
2. Click the green **Create issue** button at the top right of the alert.  TIP: If you don't see this button, you might be working in a closed alert.  Try with an alert that's currently open
  
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/a446baf6-18e5-442d-b0fc-8e4110e422dd)

3. A new issue creation page will open.  You don't need to make any changes in this page, but feel free to add additional information.  
4. Click **Submit new issue**
5. View the issue you just created by clicking **Issues** in the top navigation bar of your repository. Your issue will be listed in that page. 
6. Wait about 20 seconds then refresh this page for the next step.
  
</details>

<!--
  <<< Author notes: Step 3 >>>
  Start this step by acknowledging the previous step.
  Define terms and link to docs.github.com.
  TBD-step-3-notes.
-->

<details id=3>
<summary><h2>Step 3: Fix Security Vulnerabilites</h2></summary>

_Nice work finishing Step 2: Reviewing and Triaging CodeQL Alerts :sparkles:_
  
In this step, we will work to fix the existing security vulnerabilities already identified by CodeQL.  Remember, at this point we have introduced CodeQL into our repository and had it scan the existing code.  The vulnerabilities it found are real-world issues and they need to be fixed!  We'll fix this issue by editing the `/server/routes.py` file.  

### :keyboard: Activity 1: Review alerts
This step is important!  Before we fix these alerts, we need to make sure the alerts are still open.  We'll also need to get some information on which files we need to fix, and how best to fix these issues.

1. Navigate to your code scanning alerts page: **Security** > **Code scanning**
1. You should see 2 alerts listed as Open. If any of the alerts are listed as **Closed**, open the alert page and choose **Reopen alert**
![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/c9d9f1b7-5f17-423c-8b43-81e8912aaf9c)

Now that both of these alerts are back to an "Open" state, we can come up with a plan to fix them.  If you look at the alerts, they are both calling out one specific file containing the issues: `server/routes.py`.  The issue is in how we're crafting the SQL query for the database.  These queries are vulnerable to SQL injection attacks.  We need to get these SQL statements re-written more securely.  
  
If you expand the **More info** section at the bottom of the alert, there are very clear suggestions to fix this query.  We're going to implement those suggestions in the next activity.

### :keyboard: Activity 2: Edit routes.py
Now that we know where the issues exist and how to fix them, we're going to modify the file `routes.py` to fix the problems.  Again, you'll want to do these next steps in a separate browser window or tab.
  
1. In the **Code** pane, click on the folder named `server`, then click on the file named `routes.py`.  The code view page will open.
  
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/2af87da0-b39a-469c-ab37-d3121660978e)
  
2. Click the edit button
  
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/ac53e02c-a169-439f-b04a-37c36048514d)
  
3. Edit line 16 by highlighting the SQL statement and replace it with this text: `"SELECT * FROM books WHERE name LIKE %s", name`.  Your page should look like this:
  
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/0513c535-a4a1-4be4-b7e0-efb0ed49827e)
  
4. Next we're going to edit line 22.  We'll replace the SQL statement with this text: `"SELECT * FROM books WHERE author LIKE %s", author`
  
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/a5f7b863-aa06-4302-846b-82af27f1fa84)
  
5. Select **Commit changes...** from the top right 
  
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/daffc4b7-b137-4441-92c6-6e65bfd654d4)
  
6. The "Propose changes" window will pop up.  Leave the defaults configured, and choose **Commit changes**
9. Now that the code has been committed into your main branch, CodeQL will initiate a new scan. Check the status of that scan by navigating to **Actions** then choose the **CodeQL** action.  Once the scan job completes, Actions will display a green check next to the last run
10. Once that CodeQL scan is done, navigate to **Security** > **Code scanning** to see the alerts.  You should have 0 open alerts and 2 closed alerts 🎉.  Feel free to review the closed alerts, especially the audit trail.  
11. Wait about 20 seconds then refresh this page for the next step.
  
</details>

<!--
  <<< Author notes: Step 4 >>>
  Start this step by acknowledging the previous step.
  Define terms and link to docs.github.com.
  TBD-step-4-notes.
-->

<details id=4>
<summary><h2>Step 4: Prevent Vulnerabilities in the Pull Request</h2></summary>

_Nicely done!  You finished Step 3: Fix Security Vulnerabilites! :partying_face:_

Way to go!  You made it this far.  We're almost done! The last step is to test out the pull request integration with CodeQL.  In this step, we will be adding a vulnerability back into the `routes.py` file to trigger an alert for a SQL injection vulnerability.  This is going to be the same issue we saw originally.  
  
The goal here is to understand what developers experience when a new vulnerability is found.  
  
We will edit the `routes.py` file, edit the SQL statement to make it insecure, commit that code, create a pull request to merge that insecure code into the main branch, then experience the alert inside the pull request. 
  
Let's get started 👍

**What is pull request**: A pull request (PR) is a utility available in GitHub that allows new code to be reviewed before being "merged" with the main code in the repository.  This method allows multiple people to work on the same code at the same time.  For more information, check out the GitHub Skills course [Introduction to GitHub](https://github.com/skills/introduction-to-github)

**What is branch**: A branch is a separate copy of the code inside our repository.  Branches allow developers to work on a different copy of the code, separate from the main branch.  For more information see the GitHub docs: [About branches](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-branches#).

### :keyboard: Activity 1: Edit `routes.py` and create a new pull request

In this first activity, we'll introduce the same insecure SQL statement from before to the `routes.py` file.  Once we update the file, we'll commit it to a new branch, then create a pull request.

  1. In the **Code** pane, click on the folder named `server`, then click on the file named `routes.py`.  The code view page will open.
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/2af87da0-b39a-469c-ab37-d3121660978e)
  
  2. Click the edit button
  <img width="700" alt="image" src="https://github.com/leftrightleft/enable-code-scanning/assets/4910518/ac53e02c-a169-439f-b04a-37c36048514d">
  
  3. Edit line 16 by highlighting the SQL statement and replace it with this text: `"SELECT * FROM books WHERE name LIKE '%" + name + "%'"`.  Your page should look like this:
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/dd460da6-5097-45e4-b949-36f62b0c45e0)

  4. Select **Commit changes** from the top right 
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/daffc4b7-b137-4441-92c6-6e65bfd654d4)
  
  5. The "Propose changes" window will open.  This time, you're going to select the radio button next to **Create a new branch**.  You can create a new name for this branch, or leave it the default suggestion.
  ![image](https://github.com/leftrightleft/enable-code-scanning/assets/4910518/62586097-2099-4f24-b7f6-30509933db2e)

  6. Click **Propose changes**.  This opens a new pull request
  7. In the "Open a pull request" window, click **Create pull request**
  

### :keyboard: Activity 2: Review pull request

At this point, we've edited the file `routes.py` with our vulnerable code, committed those changes to our new branch, and created a pull request to merge the new branch into our `main` branch.  This is the exact same set of steps a developer would take as they introduce new, vulnerable code into a repository.  
  
Now, let's take a look at the pull request to see what the experience is like.
  
1. In the previous activity, we created the pull request.  After creating the pull request, you were brought directly to the pull request page.  Take a look at the checks at the bottom of the pull request.  You will see a check called "Code scanning/CodeQL".  This is the CodeQL analysis job scanning the code introduced in the pull request
  
  <img width="530" alt="image" src="https://github.com/leftrightleft/enable-code-scanning/assets/4910518/ce5868ba-c0a4-4be5-9eaa-ff4b8a1ed682">

2.  Once the check is complete, you will see a new comment in the pull request from CodeQL indicating that there is a new security vulnerability; a SQL query built from user controlled data.  This is our SQL injection vulnerability
  
  <img width="1180" alt="image" src="https://github.com/leftrightleft/enable-code-scanning/assets/4910518/378bd766-ef61-4619-ab3c-bf2c8d9618d7">

3. Review the data flow paths by clicking **Show paths**
  
4. Add a comment and tag one of your friends by using their GitHub handle ex: `@username`.  This will notify them that you made a comment on the issue and need their help solving the problem 😄

5. Wait about 20 seconds then refresh this page for the next step.

If this were a real-world situation, the developer would need to fix the SQL statement in their branch.  Once that occurs, the vulnerability will automatically close out.

If you would like to learn more about pull request integrations for code scanning, take a look at our documentation [here](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/triaging-code-scanning-alerts-in-pull-requests).

</details>

<!--
  <<< Author notes: Finish >>>
  Review what we learned, ask for feedback, provide next steps.
-->

<details id=5>
<summary><h2>Finish</h2></summary>

_Congratulations friend, you've completed this course!_ 🏆

Here's a recap of all the tasks you accomplished in your repository:
  - Enabled CodeQL on your repository
  - CodeQL scanned the code in your repository and notified us of two SQL injection vulenrabilities
  - We reviewed the findings, marked the findings as closed, and explored the audit trail 
  - Fixed your code in the main branch and saw that the findings automatically closed out
  - Introduced a new vulnerability in a new branch
  - Created a pull request, and were notified of the vulnerability

### What's next?

- Continue your learning!  Our [code scanning documentation](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/about-code-scanning) is a great resource for learning more about CodeQL.
- Lern more about CodeQL.  Take a look at the [CodeQL documenation](https://codeql.github.com/docs/) site to learn about all of the features of this powerful tool.
- [We'd love to hear what you thought of this course](TBD-feedback-link).
- [Take another TBD-organization Course](https://github.com/TBD-organization).
- [Read the GitHub Getting Started docs](https://docs.github.com/en/get-started).
- To find projects to contribute to, check out [GitHub Explore](https://github.com/explore).

</details>

<!--
  <<< Author notes: Footer >>>
  Add a link to get support, GitHub status page, code of conduct, license link.
-->

---

Get help: [TBD-support](TBD-support-link) &bull; [Review the GitHub status page](https://www.githubstatus.com/)

&copy; 2022 TBD-copyright-holder &bull; [Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/code_of_conduct.md) &bull; [MIT License](https://gh.io/mit)
