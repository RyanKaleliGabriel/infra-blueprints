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

A separate indexing step in Git allows you to split large changes into small commits. For example, say, you washed your car and while doing so, also refilled the windshield washer fluid.

These two changes are essentially independent, so it's better to commit them separately. 

Otherwise, the change log of the windshield wiper fluid tank will contain the entry "Washed the car", which does not correspond to the essence of the change and may confuse the person might be looking into this history later.

Suppose you have edited three files (a.html, b.html, and c.html). After that you need to commit all the changes so that the changes to a.html and b.html were a single commit, while the changes to c.html were not logically associated with the first two files and were done in a separate commit.

```
git add a.html
git add b.html
git commit -m "Changes for a and b"
```
```
git add c.html
git commit -m "Unrelated change to c"
```

# Committing the changes

The commit command allows interactively editing comments for the commit. And now, let's see how it works.

If you omit the -m flag from the command line, Git will pop you into the editor of your choice from the list (in order of priority):
 - GIT_EDITOR environment variable;
 - core.editor configuration setting;
 - VISUAL environment variable;
 - EDITOR environment variable.

Setting git editor to vim 

```
git config --global core.editor "vim"
```

When you run ```git commit``` the git editor set will pop out for you to edit or add the commit message.

Result

```
|
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch main
# Changes to be committed:
#       modified:   hello.html
#
```

On the first line, enter the comment: Added h1 tag. Save the file and exit the editor (to do it in default editor, press ESC and then type :wq and hit Enter). You should see:

```
$ git commit
[main 78433de] Added h1 tag
 1 file changed, 1 insertion(+), 1 deletion(-)
```

## Changes, not files

Most version control systems work with files. You add the file to source control and the system tracks changes from that moment on.

Git concentrates on the changes to a file, not the file itself. A git add file command does not tell Git to add the file to the repository, but to note the current state of the file for it to be committed later.

# First Change: Adding default page tags

```
<html>
  <body>
    <h1>Hello, World!</h1>
  </body>
</html>
```

Add this change to the git staging

```
git add hello.html
```

Now add the HTML headers (<head> section) to the "Hello, World" page.

```
<html>
  <head>
  </head>
  <body>
    <h1>Hello, World!</h1>
  </body>
</html>
```

Check the status

```
git status
```

You will see

```
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	modified:   hello.html

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   hello.html
```

Please note that hello.html is listed in the status twice. The first change (the addition of default tags) is staged and ready for a commit. The second change (adding HTML headers) is unstaged. If you were making a commit right now, headers would not have been saved to the repository.

# Commit
 Commit the staged changes (default values), then check the status one more time.

 ```
 sysadmin@spacial-sys:~/githowto/repositories/work$ git commit -m "Added standard HTML page tags"
[main 28e8c62] Added standard HTML page tags
 1 file changed, 11 insertions(+), 2 deletions(-)
sysadmin@spacial-sys:~/githowto/repositories/work$ git status
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   hello.html

no changes added to commit (use "git add" and/or "git commit -a")
 ```

 The status command suggests that hello.html still has unrecorded changes, but the staging area is already clear.

 # Adding the second change

Add the second change to the staging area, after that run the git status command.



```
sysadmin@spacial-sys:~/githowto/repositories/work$ git add .
sysadmin@spacial-sys:~/githowto/repositories/work$ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	modified:   hello.html

```

# Commit the second change

```
git commit -m "Added HTML header"
[main 8338e4c] Added HTML header
 1 file changed, 3 deletions(-)
sysadmin@spacial-sys:~/githowto/repositories/work$ 
```

## History

Getting a list of changes made is a function of the git log command. Here is a list of all the four commits to the repository, which we were able to make so far.



```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log
commit 8338e4cdec21d45735bb3a92bc36bb2f8bde1551 (HEAD -> main)
Author: RyanKaleliGabriel <ryang9241@gmail.com>
Date:   Wed Jul 23 09:58:54 2025 +0300

    Added HTML header

commit 28e8c62042c402f44b5578e7c768ba747c11d5b5
Author: RyanKaleliGabriel <ryang9241@gmail.com>
Date:   Wed Jul 23 09:55:58 2025 +0300

    Added standard HTML page tags

commit 6c48d3957899100722b7e1573dbd5bc70728b9cc
Author: RyanKaleliGabriel <ryang9241@gmail.com>
Date:   Wed Jul 23 09:34:11 2025 +0300

    Added p tag

commit 6ff32a580749b8375c425d69672554f4a300f1fe
Author: RyanKaleliGabriel <ryang9241@gmail.com>
Date:   Wed Jul 23 09:29:06 2025 +0300

    Unreleated change to c
:...skipping...
commit 8338e4cdec21d45735bb3a92bc36bb2f8bde1551 (HEAD -> main)
Author: RyanKaleliGabriel <ryang9241@gmail.com>
Date:   Wed Jul 23 09:58:54 2025 +0300

    Added HTML header

commit 28e8c62042c402f44b5578e7c768ba747c11d5b5
Author: RyanKaleliGabriel <ryang9241@gmail.com>
Date:   Wed Jul 23 09:55:58 2025 +0300

    Added standard HTML page tags

commit 6c48d3957899100722b7e1573dbd5bc70728b9cc
Author: RyanKaleliGabriel <ryang9241@gmail.com>
Date:   Wed Jul 23 09:34:11 2025 +0300

    Added p tag

commit 6ff32a580749b8375c425d69672554f4a300f1fe
Author: RyanKaleliGabriel <ryang9241@gmail.com>
Date:   Wed Jul 23 09:29:06 2025 +0300

    Unreleated change to c

commit 0393825b5a3a9f3418db5f8c6ef9444acbba12be
Author: RyanKaleliGabriel <ryang9241@gmail.com>
Date:   Wed Jul 23 09:28:40 2025 +0300

    Changes for a and b

commit 8d61987e0c318bf5ae78e46b473d126125247281
Author: RyanKaleliGabriel <ryang9241@gmail.com>
Date:   Tue Jul 22 08:43:47 2025 +0300

```

# One line history

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log --oneline
8338e4c (HEAD -> main) Added HTML header
28e8c62 Added standard HTML page tags
6c48d39 Added p tag
6ff32a5 Unreleated change to c
0393825 Changes for a and b
8d61987 Initial commit
```

# Controlling the display of entries

Here are some other interesting options of viewing history:

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log --oneline
8338e4c (HEAD -> main) Added HTML header
28e8c62 Added standard HTML page tags
6c48d39 Added p tag
6ff32a5 Unreleated change to c
0393825 Changes for a and b
8d61987 Initial commit
```

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log --oneline --max-count=2
8338e4c (HEAD -> main) Added HTML header
28e8c62 Added standard HTML page tags
```

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log --oneline --since="5 minutes ago"
```

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log --oneline --until="5 minutes ago"
8338e4c (HEAD -> main) Added HTML header
28e8c62 Added standard HTML page tags
6c48d39 Added p tag
6ff32a5 Unreleated change to c
0393825 Changes for a and b
8d61987 Initial commit
```

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log --oneline --author="RyanKaleliGabriel"
8338e4c (HEAD -> main) Added HTML header
28e8c62 Added standard HTML page tags
6c48d39 Added p tag
6ff32a5 Unreleated change to c
0393825 Changes for a and b
8d61987 Initial commit
```

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log --oneline --author="RyanKaleliGabriel"
8338e4c (HEAD -> main) Added HTML header
28e8c62 Added standard HTML page tags
6c48d39 Added p tag
6ff32a5 Unreleated change to c
0393825 Changes for a and b
8d61987 Initial commit
```

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log --oneline --all
8338e4c (HEAD -> main) Added HTML header
28e8c62 Added standard HTML page tags
6c48d39 Added p tag
6ff32a5 Unreleated change to c
0393825 Changes for a and b
8d61987 Initial commit
```

# Getting fancy

To review the changes made within the last week. I will add --author=RyanKaleliGabriel if I want to see only the changes made by me.

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log --all --pretty=format:"%h %cd %s (%an)" --since="7 days ago"
8338e4c Wed Jul 23 09:58:54 2025 +0300 Added HTML header (RyanKaleliGabriel)
28e8c62 Wed Jul 23 09:55:58 2025 +0300 Added standard HTML page tags (RyanKaleliGabriel)
6c48d39 Wed Jul 23 09:34:11 2025 +0300 Added p tag (RyanKaleliGabriel)
6ff32a5 Wed Jul 23 09:29:06 2025 +0300 Unreleated change to c (RyanKaleliGabriel)
0393825 Wed Jul 23 09:28:40 2025 +0300 Changes for a and b (RyanKaleliGabriel)
8d61987 Tue Jul 22 08:43:47 2025 +0300 Initial commit (RyanKaleliGabriel)
sysadmin@spacial-sys:~/githowto/repositories/work$ 
```

# The ultimate format of the log

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log --pretty=format:"%h %ad | %s%d [%an]" --date=short
8338e4c 2025-07-23 | Added HTML header (HEAD -> main) [RyanKaleliGabriel]
28e8c62 2025-07-23 | Added standard HTML page tags [RyanKaleliGabriel]
6c48d39 2025-07-23 | Added p tag [RyanKaleliGabriel]
6ff32a5 2025-07-23 | Unreleated change to c [RyanKaleliGabriel]
0393825 2025-07-23 | Changes for a and b [RyanKaleliGabriel]
8d61987 2025-07-22 | Initial commit [RyanKaleliGabriel]
```

Let's look at it in detail:
 1. --pretty="..." defines the output format.
 2. %h is the abbreviated hash of the commit.
 3. %ad is the commit date.
 4. | is just a visual separator.
 5. %s is the comment.
 6. %d commit decorations (e.g. branch heads or tags).
 7. %an is the name of the author.
 8. --date=short keeps the date format short and nice.

 So, every time you want to see a log, you'll have to do a lot of typing. Fortunately, there are several Git config options to adjust the default log output format:

 ```
 git config --global format.pretty '%h %ad | %s%d [%an]'
 git config --global log.date short
 ```

 ## Getting older versions

Git make time traveling possible, at least for your project. The checkout command will update your working directory to any previous commit.

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log
8338e4c 2025-07-23 | Added HTML header (HEAD -> main) [RyanKaleliGabriel]
28e8c62 2025-07-23 | Added standard HTML page tags [RyanKaleliGabriel]
6c48d39 2025-07-23 | Added p tag [RyanKaleliGabriel]
6ff32a5 2025-07-23 | Unreleated change to c [RyanKaleliGabriel]
0393825 2025-07-23 | Changes for a and b [RyanKaleliGabriel]
8d61987 2025-07-22 | Initial commit [RyanKaleliGabriel]
```

Check the log data and find the hash of the initial commit. You will find it in the last line of the output. Use the hash (its first 7 characters are enough) in the command below. After that check the contents of the hello.html file.

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git checkout 8d61987
Note: switching to '8d61987'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at 8d61987 Initial commit

```
Note that the current content of the hello.html file is the content that we started with in the very beginning.

# Returning to the latest version in the main branch
To return to the latest version of our code, we need to switch to the default main branch. We can use the switch command to switch between branches.

The checkout command has been a swiss army knife in the world of Git for a long time. It has tons of various options that let you run entirely different things: switch branches, reset code, etc. At some point, the Git team decided to split the command into several commands. The switch command is one of them—its sole purpose is to switch between branches. The checkout command is still available, but it is no longer recommended to use it for switching branches.

```
sysadmin@spacial-sys:~/githowto/repositories/work$ cat hello.html 
<h1>Hello, world</h1>sysadmin@spacial-sys:~/githowto/repositories/work$ git switch main
Previous HEAD position was 0393825 Changes for a and b
Switched to branch 'main'
sysadmin@spacial-sys:~/githowto/repositories/work$ cat hello.html 
<!DOCTYPE html>
<html lang="en">
<head>
</head>
<body>
    <h1>Hello, world!</h1>
</body>
</html>sysadmin@spacial-sys:~/githowto/repositories/work$ 
```