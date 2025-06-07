## Step 1: Enable CodeQL

In this first step, we'll be learning more about CodeQL and how to use it to secure your source code.

### What is GitHub code scanning?

[Code scanning](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/about-code-scanning) is a capability that allows development teams to integrate security testing tools into the software development process. This is done using GitHub Actions. With code scanning, you can integrate many different types of tools including SAST, container, and infrastructure as code security tools.

### What is CodeQL?

[CodeQL](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/about-code-scanning-with-codeql) is a static analysis testing tool that helps you identify security weaknesses such as SQL injection, cross-site scripting, and code injection issues.

### ⌨️ Activity: Enable code scanning with CodeQL

First, we will enable code scanning with CodeQL in our repository.

1. Open a new browser tab, and work on the steps in your second tab while you read the instructions in this tab.

1. Navigate to the **Settings** tab at the top of your newly created repository.

1. Under the **Security** section on the left side, select **Code security and analysis**.

1. Scroll down to the section titled **Code scanning**. For the purpose of this exercise, we will focus on CodeQL analysis.

1. Click on the **Set up** dropdown menu and choose **Default**.

   <img width="400" alt="enable code scanning" src="https://github.com/user-attachments/assets/0d639af3-a8fb-4ea7-8b94-44621a34fc3c"/>

   Let's take a look at the configuration options in the modal:

   - **Languages to analyze:** These are the languages that will be scanned by CodeQL. In this case, we will be scanning in `Python`.
   - **Query suites:** CodeQL [queries](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/about-code-scanning-with-codeql#about-codeql-queries) are packaged in bundles called "suites". This section allows you to choose which query suite to use. We'll leave this set as **Default** for this exercise. For more information, see "[About CodeQL queries](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/about-code-scanning-with-codeql#about-codeql-queries)."
   - **Events:** This section tells CodeQL when to scan. In this case, it's set to scan on any pull request to the `main` branch.

   <img width="400" alt="codeql default configuration box" src="https://github.com/user-attachments/assets/cf5ba96b-98bb-4db5-b743-bd31bceaabac"/>

1. Click **Enable CodeQL**

1. With CodeQL now enabled, Mona will check your progress and share the next steps.
