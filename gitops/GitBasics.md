# Git basics

Git is a version control system that allows you to track changes to your code over time. It's also a great way to collaborate with others on a project.

It allows you to go back in time and see what your code looked like at a certain point in time. 

It also allows you to see who made what changes to the code, and when. It even allows you to undo changes that you made to your code.

# Terminology

## Repository

A Git repository, often referred to as a "repo", is a storage space where your project lives. It can be local storage on your computer, or it can be a remote storage on a service like GitHub or another online host.

The repository is used to track changes in the project, coordinate work among multiple people, and track the project's history.

When you init a Git repository in that directory, Git creates a hidden subdirectory named .git where all the information about the repository is stored. This includes the history of all the changes that were made to the repository, as well as the current state of the repository.

## Commit

Think of a commit as a snapshot of your repository at a certain point in time. 

A commit only carries information about the changes that were made to the repository since the last commit. 

It doesn't contain the entire repository (unless it's a first commit).

## Branch

A branch is a parallel version of a repository. It allows you to work on a new feature of your project without affecting the main version of the project. 

Once you are done working on the new feature, you can merge the branch back into the main version of the project.

# Git credentials

## Setting up name and email address

```
git config --global user.name "Your Name"
git config --global user.email "your_email@whatever.com"
```

## Default branch name

We will use main as the default branch name. 

```
git config --global init.defaultBranch main
```

## Line endings treatment

Line endings (also called "newline characters") are special characters used to mark the end of a line in a text file.
When you press Enter in a text editor, it inserts a line ending — but different operating systems use different characters for this.

Why it matters?

 - Different contributors may use different systems.
 - Without consistent line endings, Git will show false diffs.
 - A shell script written in Windows might break on Linux because of unexpected \r characters.
 - A shell script written in Windows might break on Linux because of unexpected \r characters.

For Unix/Mac
 
```
# When committing: Converts Windows-style CRLF line endings to Unix-style LF. When checking out: Leaves line endings unchanged (LF stays LF, CRLF stays CRLF).
git config --global core.autocrlf input

# Warns you when Git detects a potential problem with line endings that may lead to corruption or inconsistencies. It helps alert you, but still allows the commit to go through.

git config --global core.safecrlf warn
```

For Windows

```
# Converts LF to CRLF on checkout, back to LF on commit
git config --global core.autocrlf true
git config --global core.safecrlf warn
```

# Creating a project 

## Create a “Hello, World!” page

```
mkdir work
cd work
touch hello.html
```

## Create a repository
 
```
git init
```

## Add the page to the Repository

```
git add hello.html
git commit -m "Initial commit"
```

# Checking the status of the repo

## Check the status of the repository

The command checks the status and reports that there’s nothing to commit, meaning the repository stores the current state of the working directory, and there are no changes to record.

We will use the git status command to keep monitoring the states of both the working directory and the repository

```
git status
```

## Renaming master branch to main - If your current branch is main

```
git branch -m master main
```

# Making Changes

```<h1>Hello, world</h2>```

After changing the hello.html, check the status

## Checking the status

```git status```

The status message hints about what to do next. If you want to add these changes to the repository, use ```git add <file>```. To undo the changes use ```git restore <file>```.


#  Staging the changes

## Adding Changes

```
git add hello.html
git status
```
Changes to the hello.html have been staged. This means that Git knows about the change, but it is not permanent in the repository. The next commit will include the changes staged.

Should you decide not to commit the change, the status command will remind you that you can run 
``` git restore --staged <file ``` command to unstage these changes.

# Staging and committing