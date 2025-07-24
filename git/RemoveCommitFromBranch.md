## Removing a commit from a branch

Revert is a powerful command of the previous section that allows you to cancel any commits to the repository. However, both original and cancelled commits are seen in the history of the branch (when using git log command).

Often after a commit is already made, we realize it was a mistake. It would be nice to have an undo command which allows the incorrect commit(s) to be immediately deleted. This command would prevent the appearance of one or more unwanted commits in the git log history.

# The reset command

When you run the reset command along with a commit reference (HEAD, branch or tag name, commit hash, etc.), the command will...
 - Point the current branch to the specified commit.
 - Optionally reset the staging area so it will comply with the specified commit.
 - Optionally reset the working directory so it will match the specified commit.

# Check our history

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log
b202305 2025-07-24 | Revert "Oops, we didn't want this commit" (HEAD -> main) [RyanKaleliGabriel]
da0e81d 2025-07-24 | Oops, we didn't want this commit [RyanKaleliGabriel]
8338e4c 2025-07-23 | Added HTML header (tag: v1) [RyanKaleliGabriel]
28e8c62 2025-07-23 | Added standard HTML page tags (tag: v1-beta) [RyanKaleliGabriel]
6c48d39 2025-07-23 | Added p tag [RyanKaleliGabriel]
6ff32a5 2025-07-23 | Unreleated change to c [RyanKaleliGabriel]
0393825 2025-07-23 | Changes for a and b [RyanKaleliGabriel]
8d61987 2025-07-22 | Initial commit [RyanKaleliGabriel]
sysadmin@spacial-sys:~/githowto/repositories/work$ 
```
We see the last two commits in this branch are "Oops" and "Revert Oops". Let us remove them with the reset command.

# Mark this branch first

```
git tag oops
```

Result

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log
b202305 2025-07-24 | Revert "Oops, we didn't want this commit" (HEAD -> main, tag: oops) [RyanKaleliGabriel]
da0e81d 2025-07-24 | Oops, we didn't want this commit [RyanKaleliGabriel]
8338e4c 2025-07-23 | Added HTML header (tag: v1) [RyanKaleliGabriel]
28e8c62 2025-07-23 | Added standard HTML page tags (tag: v1-beta) [RyanKaleliGabriel]
6c48d39 2025-07-23 | Added p tag [RyanKaleliGabriel]
6ff32a5 2025-07-23 | Unreleated change to c [RyanKaleliGabriel]
0393825 2025-07-23 | Changes for a and b [RyanKaleliGabriel]
8d61987 2025-07-22 | Initial commit [RyanKaleliGabriel]
```
# Reset commit to before oops

```
git reset --hard v1
```

Our main branch is pointing at commit v1 and the "Revert Oops" and "Oops" commits no longer exist in the branch. The --hard parameter makes the working directory reflect the new branch head.

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log
8338e4c 2025-07-23 | Added HTML header (HEAD -> main, tag: v1) [RyanKaleliGabriel]
28e8c62 2025-07-23 | Added standard HTML page tags (tag: v1-beta) [RyanKaleliGabriel]
6c48d39 2025-07-23 | Added p tag [RyanKaleliGabriel]
6ff32a5 2025-07-23 | Unreleated change to c [RyanKaleliGabriel]
0393825 2025-07-23 | Changes for a and b [RyanKaleliGabriel]
8d61987 2025-07-22 | Initial commit [RyanKaleliGabriel]
sysadmin@spacial-sys:~/githowto/repositories/work$ 
```

# Nothing is ever lost

What happened to the wrong commits? They are still in the repository. Actually, we can still refer to them. At the beginning of the lesson, we created the oops tag for the canceled commit. Let us take a look at all commits.

```
git log --all
```

```
git log --all
b202305 2025-07-24 | Revert "Oops, we didn't want this commit" (tag: oops) [RyanKaleliGabriel]
da0e81d 2025-07-24 | Oops, we didn't want this commit [RyanKaleliGabriel]
8338e4c 2025-07-23 | Added HTML header (HEAD -> main, tag: v1) [RyanKaleliGabriel]
28e8c62 2025-07-23 | Added standard HTML page tags (tag: v1-beta) [RyanKaleliGabriel]
6c48d39 2025-07-23 | Added p tag [RyanKaleliGabriel]
6ff32a5 2025-07-23 | Unreleated change to c [RyanKaleliGabriel]
0393825 2025-07-23 | Changes for a and b [RyanKaleliGabriel]
8d61987 2025-07-22 | Initial commit [RyanKaleliGabriel]
```

We can see that the wrong commits are not gone. They are not listed in the main branch anymore but still remain in the repository. They would still be in the repository if we did not tag them, but then we could reference them only by their hashes. Unreferenced commits remain in the repository until the garbage collection software is run by system.

# Reset dangers

Resets on local branches are usually harmless. The consequences of any "accident" can be reverted by using the proper commit.

However, other users sharing the branch can be confused if the branch is shared on remote repositories.

