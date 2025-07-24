##  Discarding local changes (before staging)

# Checking out the main branch

```
git switch main
```

# Change hello.html

Sometimes you have modified a file in your local working directory, and you wish to just revert to what has already been committed. The restore command will handle that.

Make changes to the hello.html file in the form of an unwanted comment.

```
# Change the contents

vi hello.html 
```

# Check the status

We see that the hello.html file has been modified, but not staged yet.

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git status
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   hello.html

no changes added to commit (use "git add" and/or "git commit -a")
sysadmin@spacial-sys:~/githowto/repositories/work$ 
```


# Undoing the changes in the working directory

```
git restore hello.html
```

Result 

The status command shows there were no unstaged changes in the working directory. And the "bad comment" is no longer contained in the file.

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git restore hello.html 
sysadmin@spacial-sys:~/githowto/repositories/work$ cat hello.html 
<!DOCTYPE html>
<html lang="en">
<head>
</head>
<body>
    <h1>Hello, world!</h1>
</body>
</html>sysadmin@spacial-sys:~/githowto/repositories/work$ git status
On branch main
sysadmin@spacial-sys:~/githowto/repositories/work$ 
```

