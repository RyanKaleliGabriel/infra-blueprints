## Cancel staged changes (before committing)

# Edit file and stage changes

Make changes to the hello.html file in the form of an unwanted comment

```
<html>
  <head>
    <!-- This is an unwanted but staged comment -->
  </head>
  <body>
    <h1>Hello, World!</h1>
  </body>
</html>
```

```
git add hello.html 
```
# Check the status

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	modified:   hello.html

sysadmin@spacial-sys:~/githowto/repositories/work$ 
```
# Restore the staging area

```
git restore --staged hello.html
```

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git status
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   hello.html

no changes added to commit (use "git add" and/or "git commit -a")
```

The restore command with the --staged option does not change the actual files in the working directory. Therefore, the hello.html still contains unwanted comments. You should be careful, though, because restore without the --staged flag will also drop the changes in the working directory.

# Restore the working tree

```
git restore hello.html
git status
```

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git restore hello.html 
sysadmin@spacial-sys:~/githowto/repositories/work$ git status
On branch main
nothing to commit, working tree clean
```

