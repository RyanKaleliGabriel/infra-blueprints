## A Section i will be documenting alpine bash commands

## User management

  - Create a user with home and default shell

   ```
   adduser -D genie
   ```

  - Switching to a different user
    
    ```
    su username
    ```

   - Check current user 
      
     ```
     id
     ```

## Paths 

  - Resetting the default path

    ```
    export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
    ```