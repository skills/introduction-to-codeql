<!--
  <<< Author notes: Header of the course >>>
  Read <https://skills.github.com/quickstart> for more information about how to build courses using this template.
  Include a 1280×640 image, course name in sentence case, and a concise description in emphasis.
  In your repository settings: enable template repository, add your 1280×640 social image, auto delete head branches.
  Next to "About", add description & tags; disable releases, packages, & environments.
  Add your open source license, GitHub uses the MIT license.
-->

# Secure Your Repository's Source Code 

Ensuring the security of application source code is a critical step in modern software development.  In this GitHub Skills course, you will learn to use GitHub code scanning to identify, resolve, and prevent insecure coding patterns.

<!--
  <<< Author notes: Start of the course >>>
  Include start button, a note about Actions minutes,
  and tell the learner why they should take the course.
  Each step should be wrapped in <details>/<summary>, with an `id` set.
  The start <details> should have `open` as well.
  Do not use quotes on the <details> tag attributes.
-->

<details id=0>
<summary><h2>Welcome</h2></summary>

👋 Hello!  Welcome to the GitHub Skills course: Secure Your Repository's Source Code!  In this course, we will explore using GitHub code scanning, powered by [CodeQL](https://codeql.github.com/), to identify common coding practices that can lead to security vulnerabilities.  During this course, we will enable code scanning on your repository to identify, remediate, and prevent SQL injection vulnerabilities.
  
Code scanning is part of the [GitHub Advanced Security (GHAS)](https://docs.github.com/en/get-started/learning-about-github/about-github-advanced-security) product suite.  All of the features of Advanced Security are 100% free for open source, public repositories.

- **Who is this for**: Developers, security engineers, open source maintainers.
- **What you'll learn**: Enabling code scanning, identifying SQL injection vulnerabilities with CodeQL.
- **What you'll build**: A secure software development pipeline that allows you to identify and prevent new security vulnerabilities from being introduced into your production code.
- **Prerequisites**: A baseline knowledge of GitHub concepts such as pull requests, Actions, and source code.  You'll also need to be familiar with the concepts of Static Application Security Testing (SAST).  Don't worry, we'll demistify the complex parts for you 🙂.
- **How long**: This course is TBD-step-count steps long and takes less than TBD-duration to complete.

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

[![start-course](https://user-images.githubusercontent.com/1221423/235727646-4a590299-ffe5-480d-8cd5-8194ea184546.svg)](TBD-generate)

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

<details id=1 open>
<summary><h2>Step 1: Enable CodeQL</h2></summary>

👋 Hello! Welcome to the GitHub Skills course: Secure Your Repository's Source Code! 

Let's get started!  

In this first step, we'll be learning more about CodeQL and how to use it to secure your source code. 

**What is GitHub code scanning**: Code scanning is a capability that allows development teams to integrate security testing tools into the software development process.  This is done using GitHub Actions.  With code scanning, you can integrate many different types of tools including SAST, container, and infrastructure as code security tools.

**What is CodeQL**: CodeQL is a static analysis testing tool created by the team at GitHub.  CodeQL is a deep semantic analysis tool that helps you identify security weaknesses like SQL injection, cross-site scripting, and code injection issues.  

### :keyboard: Activity: Enable code scanning with CodeQL

1. Open a new browser tab, and work on the steps in your second tab while you read the instructions in this tab.
1. Navigate the to **settings** tab at the top of your repository.
1. Inside the repository settings page navigate to **Code security and analysis** in the left-hand navigation, under the **Security** heading
1. Scroll down to the section titled **Code scanning**.  Here we will configure the CodeQL analysis.  There are two sections, "CodeQL analysis" and "Other tools"  for now we will focus on CodeQL analysis.  Feel free to browse the other code scanning tool integrations by choosing "Explore other workflows".  We're not going to set up any other tools in this course, though. 
1. Select the **Set up** dropdown and choose **Default**
  <img width="837" alt="image" src="https://github.com/leftrightleft/enable-code-scanning/assets/4910518/c539dc7a-0c94-4137-b17f-18f965039165">

6. Let's take a look at the config options in the modal:
  - **Languages to analyze:** These are the languages that will be scanned by CodeQL.  In this case, it's `Python`.  
  - **Query suites:** CodeQL [queries](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/about-code-scanning-with-codeql#about-codeql-queries) are packaged in bundles called "suites".  This section allows you to choose which query suite to use.  We'll leave this set as **Default** for this exercise
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
<summary><h2>Step 2: TBD-step-2-name</h2></summary>

_You did TBD-step-1-name! :tada:_

TBD-step-2-information

**What is _TBD-term-2_**: TBD-definition-2

### :keyboard: Activity: TBD-step-2-name

1. TBD-step-2-instructions.
1. Wait about 20 seconds then refresh this page for the next step.

</details>

<!--
  <<< Author notes: Step 3 >>>
  Start this step by acknowledging the previous step.
  Define terms and link to docs.github.com.
  TBD-step-3-notes.
-->

<details id=3>
<summary><h2>Step 3: TBD-step-3-name</h2></summary>

_Nice work finishing TBD-step-2-name :sparkles:_

TBD-step-3-information

**What is _TBD-term-3_**: TBD-definition-3

### :keyboard: Activity: TBD-step-3-name

1. TBD-step-3-instructions.
1. Wait about 20 seconds then refresh this page for the next step.

</details>

<!--
  <<< Author notes: Step 4 >>>
  Start this step by acknowledging the previous step.
  Define terms and link to docs.github.com.
  TBD-step-4-notes.
-->

<details id=4>
<summary><h2>Step 4: TBD-step-4-name</h2></summary>

_Nicely done TBD-step-3-name! :partying_face:_

TBD-step-4-information

**What is _TBD-term-4_**: TBD-definition-4

### :keyboard: Activity: TBD-step-4-name

1. TBD-step-4-instructions.
1. Wait about 20 seconds then refresh this page for the next step.

</details>

<!--
  <<< Author notes: Step 5 >>>
  Start this step by acknowledging the previous step.
  Define terms and link to docs.github.com.
  TBD-step-5-notes.
-->

<details id=5>
<summary><h2>Step 5: TBD-step-5-name</h2></summary>

_Almost there TBD-step-4-name! :heart:_

TBD-step-5-information

### :keyboard: Activity: TBD-step-5-name

1. TBD-step-5-instructions.
1. Wait about 20 seconds then refresh this page for the next step.

</details>

<!--
  <<< Author notes: Finish >>>
  Review what we learned, ask for feedback, provide next steps.
-->

<details id=X>
<summary><h2>Finish</h2></summary>

_Congratulations friend, you've completed this course!_

<img src=TBD-celebrate-image alt=celebrate width=300 align=right>

Here's a recap of all the tasks you've accomplished in your repository:

- TBD-recap.

### What's next?

- TBD-continue.
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
