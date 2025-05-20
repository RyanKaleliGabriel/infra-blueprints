## Implementation of a Full Backup with Cron jobs.

> This documentation is about how to execute a shell script that will implement a fullbackup for files or folders.

## Tools

 - A server / computer (your host) {for practical cases it could act as the computer holding the file to be backed up}
 - A virtual Machine / another computer {for practical cases it could act as your backup server}
 - Your attention

## Guidelines

1. Have your computer and virtual machine ready, to set up a virtual machine check [here](https://github.com/RyanKaleliGabriel/infra-blueprints/blob/master/virtual_machines/Create.md). Your computer will act as where the file you want to be backed up is and your virtual machine will act as the backup server.

2. After that have your script ready and transfer it in your backup server. 

3. Make your shell script executable. For example:
   - Adding a shebang at the top of your shell script 

     ```
     #!/bin/bash
     ```
   - Give your script the right permission to execute

     ```
     chmod +x /path/to/your/script.sh
     ```

4. Open your crontab and select your editor (Nano is the preferred one).
   
     ```
     crontab -e
     ```

5. Schedule a cronjob

   - The cronjob format. Cronjobs are written in 24 hr systems. 
    
      ```
       * * * * * command-to-run
       │ │ │ │ │
       │ │ │ │ └─ Day of week(dow) (0–7) (Sunday is both 0 and 7)
       │ │ │ └─── Month(mon) (1–12)
       │ │ └───── Day of month(dom) (1–31)
       │ └─────── Hour(h) (0–23)
       └───────── Minute(m) (0–59)
      ```

    - Add a cron job at the bottom of the crontab you opened. Examples 

       Daily at 2:00 AM
          
          ```
          0 2 * * * /path/to/script.sh >> /path/to/logfile.log 2>&1
          ```

       Weekly on Sunday at 3:00 PM
           
           ```
           0 15 * * 0 /path/to/script.sh >> /path/to/logfile.log 2>&1
           ```

       Monthly on the 1st at 4:30 AM

            ```
            30 4 1 * * /path/to/script.sh >> /path/to/logfile.log 2>&1
            ```
    This example will add a cronjob that will display is logs in a file with the .log extension

6. Close the crontab by pressing

   ```
   Ctrl + O
   enter 
   Ctrl + X
   ```


---

**Author** : Ryan Kaleli Gabriel
**Date** : May 20, 2025

> "Cron is the heartbeat of automation - quiet, reliable and essential."

---
