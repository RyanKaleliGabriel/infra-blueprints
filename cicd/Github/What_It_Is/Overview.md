## Overview

GitHub Actions is a continuous integration and continuous delivery (CI/CD) platform that allows you to automate your build, test, and deployment pipeline.

You can create workflows that build and test every pull request to your repository, or deploy merged pull requests to production.

GitHub Actions goes beyond just DevOps and lets you run workflows when other events happen in your repository. For example, you can run a workflow to automatically add the appropriate labels whenever someone creates a new issue in your repository.

GitHub provides Linux, Windows, and macOS virtual machines to run your workflows, or you can host your own self-hosted runners in your own data center or cloud infrastructure.

# The components of GitHub Actions

You can configure a GitHub Actions **workflow** to be triggered when an **event** occurs in your repository, such as a pull request being opened or an issue being created. Your **workflow** contains one or more jobs which can run in <u>sequential</u> order or in <u>parallel</u>. Each job will run inside its own virtual machine **runner**, or inside a container, and has one or more **steps** that either run a script that you define or run an **action**, which is a <u>reusable extension that can simplify your workflow.</u>

# Workflows

A workflow is a configurable automated process that will run one or more jobs. Workflows are defined by a YAML file checked in to your repository and will run when triggered by an event in your repository, or they can be triggered manually, or at a defined schedule.

Workflows are defined in the .github/workflows directory in a repository. 

 A repository can have multiple workflows, each of which can perform a different set of tasks such as:

  1. Building and testing pull requests
  2. Deploying your application every time a release is created
  3. Adding a label whenever a new issue is opened.
  4 Run code formatting/linting. Automatically check code style and apply linters (e.g., ESLint, Prettier, Black, Flake8).
  5. Run security scans. Use tools like Dependabot, CodeQL, or Trivy to detect security vulnerabilities in dependencies or source code.
  6. Package and publish libraries. Automatically publish packages to npm, PyPI, Docker Hub, Maven Central, etc.
  7. Rollback on failure. Detect failures and revert to a previous stable version automatically.
  8. Close stale issues and PRs. Automatically close or comment on old issues/PRs with no activity.
  9. Enforce commit message conventions. Ensure all commits follow a given pattern (e.g., Conventional Commits).
  10. Auto-merge pull requests. Automatically merge PRs that pass all checks and meet approval rules.
  11. Notify teams or Slack channels. Send deployment status or test results to Slack, email, or Discord.
  12. Scheduled Tasks: Workflows can be triggered on a schedule to perform tasks like database backups or data analysis. 

# Events 

An event is a specific activity in a repository that triggers a workflow run. For example, an activity can originate from GitHub when someone creates a pull request, opens an issue, or pushes a commit to a repository. You can also trigger a workflow to run on a schedule, by posting to a REST API, or manually.

# Jobs

A job is a set of steps in a workflow that is executed on the same runner. Each step is either a shell script that will be executed, or an action that will be run.

Steps are executed in order and are dependent on each other. Since each step is executed on the same runner, you can share data from one step to another. For example, you can have a step that builds your application followed by a step that tests the application that was built.

You can configure a job's dependencies with other jobs; by default, jobs have no dependencies and run in parallel. When a job takes a dependency on another job, it waits for the dependent job to complete before running.

For example, you might configure multiple build jobs for different architectures without any job dependencies and a packaging job that depends on those builds. The build jobs run in parallel, and once they complete successfully, the packaging job runs.

# Runner

A runner is a server that runs your workflows when they're triggered. Each runner can run a single job at a time. GitHub provides Ubuntu Linux, Microsoft Windows, and macOS runners to run your workflows. Each workflow run executes in a fresh, newly-provisioned virtual machine.

GitHub also offers larger runners, which are available in larger configurations.

If you need a different operating system or require a specific hardware configuration, you can host your own runners.