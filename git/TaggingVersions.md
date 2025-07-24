## Tagging versions


For most people working with hashes directly is annoying at best. Wouldn't it be great if you could label specific commits with human-readable names? This way you could clearly see important milestones in the project history. Moreover, you could easily check out to a specific version of the project by its name. For this reason, Git has a feature called "tags".

Let's call the current version of the hello.html page as version 1: v1.

```
git tag v1
git log
```

Result 

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log
8338e4c 2025-07-23 | Added HTML header (HEAD -> main, tag: v1) [RyanKaleliGabriel]
28e8c62 2025-07-23 | Added standard HTML page tags [RyanKaleliGabriel]
6c48d39 2025-07-23 | Added p tag [RyanKaleliGabriel]
6ff32a5 2025-07-23 | Unreleated change to c [RyanKaleliGabriel]
0393825 2025-07-23 | Changes for a and b [RyanKaleliGabriel]
8d61987 2025-07-22 | Initial commit [RyanKaleliGabriel]
```

Now, the current version of the page is referred to as v1.

# Tags for previous versions

Let's tag the version prior to the current version with the name v1-beta. First of all we will check out the previous version. Instead of looking up the hash of the commit, we are going to use the ^ notation, specifically v1^, indicating the commit previous to v1.

If the v1^ notation gives you any trouble, you can also try v1~1, which will reference the same version. The V~N notation means "the N-th version prior to V", or in case of v1~1, first version prior to v1.

```
git checkout v1^
```

Result

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git checkout v1^
Note: switching to 'v1^'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at 28e8c62 Added standard HTML page tags
sysadmin@spacial-sys:~/githowto/repositories/work$ cat hello.html 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1>Hello, world!</h1>
</body>
```

This is the version with <html> and <body> tags, but without <head>. Let's make it’s the v1-beta version.

```
git tag v1-beta
git log
```

Result 

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log
28e8c62 2025-07-23 | Added standard HTML page tags (HEAD, tag: v1-beta) [RyanKaleliGabriel]
6c48d39 2025-07-23 | Added p tag [RyanKaleliGabriel]
6ff32a5 2025-07-23 | Unreleated change to c [RyanKaleliGabriel]
0393825 2025-07-23 | Changes for a and b [RyanKaleliGabriel]
8d61987 2025-07-22 | Initial commit [RyanKaleliGabriel]
```

# Check out by the tag name

```
git checkout v1
git checkout v1-beta
```

Result 

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git checkout v1
Previous HEAD position was 28e8c62 Added standard HTML page tags
HEAD is now at 8338e4c Added HTML header
sysadmin@spacial-sys:~/githowto/repositories/work$ git checkout v1-beta
Previous HEAD position was 8338e4c Added HTML header
HEAD is now at 28e8c62 Added standard HTML page tags
sysadmin@spacial-sys:~/githowto/repositories/work$ 
```

# Viewing tags with the tag command
 
You can see the available tags using git tag

```
git tag
```

Result

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git tag
v1
v1-beta
```

# Viewing tags in logs

```
git log main --all
```

Result:

```
sysadmin@spacial-sys:~/githowto/repositories/work$ git log main --all
8338e4c 2025-07-23 | Added HTML header (tag: v1, main) [RyanKaleliGabriel]
28e8c62 2025-07-23 | Added standard HTML page tags (HEAD, tag: v1-beta) [RyanKaleliGabriel]
6c48d39 2025-07-23 | Added p tag [RyanKaleliGabriel]
6ff32a5 2025-07-23 | Unreleated change to c [RyanKaleliGabriel]
0393825 2025-07-23 | Changes for a and b [RyanKaleliGabriel]
8d61987 2025-07-22 | Initial commit [RyanKaleliGabriel]
```

You can see tags (v1 and v1-beta) listed in the log together with the name of the branch (main). The HEAD marker shows the commit you checked out (currently v1-beta).