## Step 1: Enable Code Scanning

Let's start by learning a bit about code scanning with [CodeQL](https://codeql.github.com/) and how it helps secure your code.

### What is GitHub Code Scanning?

[Code scanning](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/about-code-scanning) is part of the [GitHub Advanced Security (GHAS)](https://docs.github.com/en/get-started/learning-about-github/about-github-advanced-security) product suite. It allows development teams to integrate security testing tools directly into the same process you already use for shipping code. It supports many types such as SAST, container, and infrastructure as code. And, the best part is that the results can also live directly in GitHub next to your code. No need for context switching! 🎉

> [!TIP]
> All features of GitHub Advanced Security are free for public repositories. However, private repositories require a compatible [paid account](https://docs.github.com/en/billing/managing-billing-for-your-products/managing-billing-for-github-advanced-security/about-billing-for-github-advanced-security).

### What is CodeQL?

[CodeQL](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/about-code-scanning-with-codeql) is a static analysis testing tool that helps you identify security weaknesses such as SQL injection, cross-site scripting, and code injection issues.

Typically CodeQL [queries](https://codeql.github.com/docs/writing-codeql-queries/about-codeql-queries/) are collected into [query suites](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/about-code-scanning-with-codeql#about-codeql-queries) to cover multiple patterns. When combined well, this can be a very powerful! To help with this, teams of security experts have pre-populated suites for many common scenarios and programming languages.

In many cases, taking advantage of CodeQL is as simple as accepting the default suite, but you can also select the extended suite or customize your own with [GitHub Actions]().

<img width="200" align="right" alt="codeql default configuration box" src="https://github.com/user-attachments/assets/cf5ba96b-98bb-4db5-b743-bd31bceaabac"/>

Here are some of the options the default configuration provides:

- **Languages:** Supported languages will automatically detected in your repository and scanning will be enabled.

- **Query suites:** A list of the available suites of patterns that will be used. The **Default** or **Extended** are provided automatically.

- **Events:** Triggers for running a CodeQL scan. It's common to run before merging and on a schedule for production code.

### ⌨️ Activity: Enable code scanning with CodeQL

1. Open a second tab and navigate to this repository. Ensure you are on the **Code** tab.

1. In the top navigation, select the the **Settings** tab.

1. In the left navigation, fine the **Security** section and select **Advanced Security**.

1. Scroll down and find the **Code scanning** area.

1. In the **CodeQL** setting, click the **Set up** dropdown menu and choose **Default**.

   <img width="400" alt="enable code scanning" src="https://github.com/user-attachments/assets/0d639af3-a8fb-4ea7-8b94-44621a34fc3c"/>

1. Click **Enable CodeQL**.

   > 💡 Tip: This will trigger a first run of CodeQL. You can view the progress in the **Actions** tab.

1. With CodeQL now enabled, Mona will check your progress and share the next steps.
