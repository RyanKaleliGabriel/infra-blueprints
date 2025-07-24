## Cancelling commits

Sometimes you realize that the new commits are wrong, and you want to cancel them. There are several ways to handle the issue, and we use the safest here.

To cancel the commit we will create a new commit, cancelling the unwanted changes.

# Edit the file and make a commit

Replace hello.html

```
<html>
  <head>
  </head>
  <body>
    <h1>Hello, World!</h1>
    <!-- This is an unwanted but committed change -->
  </body>
</html>
```

```
git add hello.html
git commit -m "Oops, we didn't want this commit"
```

# Make a commit with new changes that discard previous changes

To cancel the commit, we need to create a commit that deletes the changes saved by unwanted commit.

```
git revert HEAD
```

Go to the editor, where you can edit the default commit message or leave it as is. Save and close the file.

You will see

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git revert HEAD
[main b202305] Revert "Oops, we didn't want this commit"
 1 file changed, 1 insertion(+), 2 deletions(-)
sysadmin@spacial-sys:~/githowto/repositories/work$ 
```

Since we have cancelled the last commit, we can use HEAD as the argument for cancelling. We may cancel any random commit in history, pointing out its hash value.

# Check the log 

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
```

This technique can be applied to any commit (however there may be conflicts). It is safe to use even in public branches of remote repositories.