
## Processes and the Linux security Model.

 A running instance of a program is called a process and it runs in its own memory space. Each time you execute a command a new process starts 

A process is an active entity which means the binary code is running in the ram as opposed to a program, which is considered to be a passive entity 

A new process is created only when running an executable file (not when running Shell built in commands). 

Process properties:
 - PID (Process ID) - a unique positive integer number 
 - User 
 - Group 
 - Priority/ Nice. 

A single command can create many processes when run multiple times. Each instance of a running command is a process but not all commands create a process.

There are 2 types of commands in linux:
 - Commands that are executable files on the disk 
 - Shell built in commands 

To check if a command is an executable command use the type command  

```
type ls
type cp
type cd
type mv
```

Only when running a command that is an executable file, a new process is created. 

If an executable file that represents a command does not have the SUID set, then the process has the permission of the user who executes it.

```
sysadmin@spacial-sys:~/githowto/repositories/work$ ls -l /bin/ls
-rwxr-xr-x 1 root root 142312 Apr  5  2024 /bin/ls

# No s in the permission string — meaning SUID is not set, so it runs with the user’s own privileges.
```

If the binary file that represents the command has the suid set, then the process has the permissions of the owner of the binary file no matter who executes the command. 
```
sysadmin@spacial-sys:~/githowto/repositories/work$ ls -l /usr/bin/passwd 
-rwsr-xr-x 1 root root 64152 May 30  2024 /usr/bin/passwd
```

When a process terminates its execution, the os releases most of the resources and information for that process.

Types of processes :
 - Parent – Process that has created one or more child processes. 
 - Child – has only one parent process 
 - Daemon - Daemons are processes that run in the background and are not interactive, they have no controlling terminals. 
 - Zombie(defunct) - processes that their data have not been collected. Normally they are removed quickly from the memory 
 - Orphan – A parent process terminates before it child. E.g when you execute a command and close the terminal before it closes.  

# Process and Thread difference.

Multiple threads can exist within the same process and share resources such as memory and different resources 
Example of threads in the same process are automatic spellcheck, automatic spelling of the file and maybe auto completion. 
Threads are subprocess that run in the same memory of the same process and make the application responsive, threads may share the same data when executing. 

# Listing Processes

```ps``` (process status) - Reports a snapshot of the current processes.

Explaining the output of ps 0
 - PID -  Process ID  that is automatically assigned and used by the kernel to uniquely identify each process. 
 - TTY – Represents the name of the controlling terminal for the process  
 - Time – Cumulative cpu time of the process shown in minutes and seconds 
 - CMD – name of the command used to start the process. 

```pgrep``` -  Looks through the current running processes and lists the process IDs which match the selection criteria to stdout - ``pgrep bash```.

```pstree``` -  Display a tree of processes

```top``` - Displays a realtime ciew of running processes.

```ps -e``` - lists all running processes on the system

```ps -f``` -  Tailed information about the process

```ps -ef``` -  displaying all processes with the tail information
Explaining Ps –ef output.:
 - PPID -  Parent process Id 
 - STIME – Start time of the process 

# Ps –aux or ps aux output explanation. 

- %CPU -  Percent utilization of the CPU by the process  
- %MEM – Percent utilization of the RAM used by the process. Its the ratio of the process residential set size to the physical memory on the machine, expressed as a percentage. 
- VSZ – virtual memory size of the process in kilobytes, it  includes all the memory that the process can access including memory that is swapped out, the memory that is allocated but not used and the memory that is from shared libraries 
- RSS -  size of the physical memory that the process is using it indicates how much memory is allocated to each process does not include memory that is swapped out but it includes memory from shared libraries as long as they are in the memory. 
- STAT – Status of the process 
         1. S – sleeping 
         2. R- running 
         3. Z – Zombie 
         4. T – stopped 
         5. I – Idle kernel thread 
         6. < - High priority 
         7. N- low priority 

A cpu core can run a single process at a specific moment, if you have a cpu with 4 cores then no more than 4 processes can run simultaneously. 
It appears that the OS is performing the jobs simultaneously, in reality it is running only one process per core at a time but quickly switching across tasks/processes. This process is called process scheduling. 

```ps aux --sort=%mem | less``` - Sorting process according to memory. 
```ps -f -u sysadmin``` - Seeing the processes of a particular user.
```ps -ef | grep sshd``` -  Filtering to check if a process is running 
```pgrep -l sshd``` - If you want to filter a specific running process apart from grep when using grep and listing the pid and the process name.
```pgrep -u root -l sshd``` - filtering processes by name and the user running it 

# Getting a dynamic relatime view of the running system (htop, top). 

While top is running you can press some letters which are interactive commands 
 - “h” - to see help summary
 - “1” - for multi cpu machines, to see individual activities for each cpu. 
 - “t” – to show percentage of usage for each cpu
 - “m” – to change the memory and swap lines to different display options. 
 - “d” – Enter new delay value for top 
 - “y” - to highlight running processes in the process list and “x” to highlight the column used to sort the process list. “b” toggle between bold and text highlighting “>” to change the sorting columns. 
 - R – reverses the sort order of a column 
 - “e” - change the size units of a column 
 - P – to sort by cpu 
 - M - SORT BY MEMORY
 - T- time 
 - “u” - sort to see the processes of a user. 
 - “f” - enters the field management screen. Here you can change the column display. Select a field you wish to display by pressing the spacebar. To move a field elsewhere press the right arrow key and use the up arrow key to move and press esc/enter. The changes will be lost if you exit top. To permanently set the configuration press W which stands for write.

 Challenge 

When top refreshes its display goes so fast that you cannot see what each process is doing or what has changed between refreshes, make top produce three iterations with a delay of 1 second between each iteration and save the entire output in a text file. 
Solution: 

```
top –d 1 –n 3 –b > top_processes.txt
```

 - “d” - delay 
 - “n - iterations 
 - “b” - start/stop in batch mode which is useful for sending the output from top to other files.

 #  Signals and Killing processes (kill, pkill, killall, pidof).

 Sometimes you will have applications that consume large server resources and become unresponsive and you want to stop them. 

 ``` kill``` -  Sends a signal to a process or a group of prcesses causing them to act according to the signal, when the signal is not specified it defaults to 15 pr SIGTERM. 

 ```kill -l``` - gets a list of all signals. Each signal is identified by a number or a name 

 A signal is an asynchronous notification sent to a process that determines how the process should behave when the signal is delivered. 

 Commands

  ```
  kill -2 process_id
  ```

  ```
  kill -SIGINT $(PIDOF FIREFOX)
  ```

  Non privileged users can send signals only to their own processes while the root users can send signals to other user’s processes. 


# Reloading a process 

The process id of a server is typically located in a file /var/run directory. Here You will find the files where the process ids  of diffrent daemons. Like the docker daemon, ssh daemon, etc 

Example of restarting the ssh process

```
#Get the ssh pid
pgrep -l sshd

#Restart
sudo kill -1 4561

#Restart
sudo kill -1 $(cat /var/run/sshd.pid)
```

A process can catch some signals and ignore them. 
When sending the SIGTERM signal the process may stop immediately, after a short delay after cleaning up resources or it may run indefinitely. For some processes that ignore the SIGTERM signal, it is necessary to send the SIGKILL signal (9), which is also known as a hard kill. 

You can also use

```
# Create an instance of sleep
sleep 123&

# Create another instance of sleep
sleep 311&

# Kill all processes with a particular name
killall -15 sleep

# Kill using partial names
pkill sleep
```

# Foreground and background processes

Foreground processes are started by the user and not by the system services and while they are running a user cannot start another process in the same terminal. 

Example

```sleep 15```
 Stops everything in the terminal for 15 seconds

Background process are uninteractive and are started or executed by system services or by the users, while they are running you can start other processes within the same terminal. To start a background process you add a “&” at the end of the command 

```sleep 20&```

Note that even though you start a process in the background, it still redirects its output and errors to the terminal it started from. 

```ls -l /etc/&```

It is common to redirect the output to a file.

```
sysadmin@spacial-sys:~$ ifconfig > output.txt 2> errors.txt&
[1] 463833
sysadmin@spacial-sys:~$ cat errors.txt 
[1]+  Done                    ifconfig > output.txt 2> errors.txt
sysadmin@spacial-sys:~$ cat output.txt 
```

If you are not interested in the output or the errors of a background process you can redirect both the output and the errors to /dev/null. The null file is called the blackhole, it immediately discards anything written to it. 

```
ping -c 1 google.com > /dev/null  2>&1 &
```

# Job Control (jobs, fg, bg) 

When starting a process in the background you will see two numbers being printed in the terminal, each background  process is identified by a job id besides its process id. The first one is a job ID the second one is the process ID. 

If you hit enter and it has executed successfully, you will get the job ID with a + and the word done. 

```
sysadmin@spacial-sys:~$ sleep 3&
[1] 466341
sysadmin@spacial-sys:~$ 
[1]+  Done                    sleep 3
```

If you start different background processes you can list their job and process ids 

```
sleep 15&
sleep 20&

# Displays the job ID
jobs

# Displays the process id as well
jobs -l
```

Note that the jobs are maintained by the current shell so the job ID is local to the current shell or you can have the same job id in different shell sessions but the process id is maintained by the system kernel and has a global scope. 

You can bring a background process to the foreground by running the fg command. 

```
# Start a background process
sleep 30&

# List the job
jobs

# Bring it to the foreground with its jib id
fg % 1
```

When you close the terminal or when you logout the process is killed. The SIGHUP signal which stands for hang up is sent to the process and the process is killed. 

Use the nohup command to ignore the SIGHUP signal 

```
nohup sleep 123&
```

If a process is started by nohup and it parent which is the bash shell is terminated the process will be adopted by init or systemd which runs as the first process on boot and has PID 1.  

Alternatives to nohup are screen and tmux. 