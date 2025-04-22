# Processes and Signals

<p align="center">
  <img src="https://img.shields.io/badge/Shell-Processes-green.svg" alt="Shell Processes">
  <img src="https://img.shields.io/badge/Linux-Signals-blue.svg" alt="Linux Signals">
  <img src="https://img.shields.io/badge/Process-Management-orange.svg" alt="Process Management">
  <img src="https://img.shields.io/badge/Daemon-Creation-yellow.svg" alt="Daemon Creation">
</p>

## Project Overview

This repository provides an introduction to Linux processes and signals, focusing on process creation, identification, management, and termination through signal handling. It covers essential commands and techniques for monitoring system processes, implementing signal handlers in scripts, and creating daemon processes for background operations.

## Learning Objectives

By the end of this project, you should be able to explain:

* What a PID (Process ID) is and its significance
* What a process is and how to find a process' PID
* How to kill a process using signals
* What a signal is and which signals can be handled in scripts
* How to create background and foreground processes
* How to use the `ps`, `pgrep`, `pkill`, `kill`, and `trap` commands
* How to implement signal handlers in Bash scripts
* How to create and manage daemon processes
* The difference between parent and child processes
* How to properly terminate processes and ensure cleanup

## Requirements

* Ubuntu 20.04 LTS
* All scripts must pass Shellcheck version 0.7.0 verification
* The first line of all Bash scripts should be `#!/usr/bin/env bash`
* The second line should be a comment explaining what the script does
* All files must be executable (`chmod +x filename`)
* All Bash scripts must pass Shellcheck without any errors

## Project Tasks

### Process Information and Display

#### 1. List Your Processes
**[1-list_your_processes](1-list_your_processes)**

Write a Bash script that displays a list of currently running processes.
* Must show all processes, for all users, including those which might not have a TTY
* Display in a user-oriented format
* Show process hierarchy

```bash
#!/usr/bin/env bash
# script that displays a list of currently running processes.
# Must show all processes, for all users, including those which might not have a TTY
# Display in a user-oriented format
# Show process hierarchy

ps auxf
```

#### 2. Show Your Bash PID
**[2-show_your_bash_pid](2-show_your_bash_pid)**

Write a Bash script that displays lines containing the bash word, thus allowing you to easily get the PID of your Bash process.
* You cannot use pgrep
* The third line of your script must be `# shellcheck disable=SC2009`

#### 3. Show Your Bash PID Made Easy
**[3-show_your_bash_pid_made_easy](3-show_your_bash_pid_made_easy)**

Write a Bash script that displays the PID, along with the process name, of processes whose name contain the word bash.
* You cannot use ps

#### 4. To Infinity and Beyond
**[4-to_infinity_and_beyond](4-to_infinity_and_beyond)**

Write a Bash script that displays "To infinity and beyond" indefinitely.
* In between each iteration of the loop, add a sleep 2

### Process Control and Termination

#### 5. Don't Stop Me Now!
**[5-dont_stop_me_now](5-dont_stop_me_now)**

Write a Bash script that stops the 4-to_infinity_and_beyond process.
* You must use kill

#### 6. Stop Me If You Can
**[6-stop_me_if_you_can](6-stop_me_if_you_can)**

Write a Bash script that stops the 4-to_infinity_and_beyond process.
* You cannot use kill or killall

#### 7. Highlander
**[7-highlander](7-highlander)**

Write a Bash script that displays:
* "To infinity and beyond" indefinitely
* With a sleep 2 in between each iteration
* "I am invincible!!!" when receiving a SIGTERM signal
* Make a copy of your 6-stop_me_if_you_can script, name it 67-stop_me_if_you_can, that kills the 7-highlander process instead of the 4-to_infinity_and_beyond one.

#### 8. Beheaded Process
**[8-beheaded_process](8-beheaded_process)**

Write a Bash script that kills the process 7-highlander.

### Advanced Process Management

#### 9. Process and PID File
**[100-process_and_pid_file](100-process_and_pid_file)**

Write a Bash script that:
* Creates the file /var/run/myscript.pid containing its PID
* Displays "To infinity and beyond" indefinitely
* Displays "I hate the kill command" when receiving a SIGTERM signal
* Displays "Y U no love me?!" when receiving a SIGINT signal
* Deletes the file /var/run/myscript.pid and terminates itself when receiving a SIGQUIT or SIGTERM signal

#### 10. Manage My Process
**[101-manage_my_process](101-manage_my_process)**, **[manage_my_process](manage_my_process)**

Write a manage_my_process Bash script that:
* Indefinitely writes "I am alive!" to the file /tmp/my_process
* In between every "I am alive!" message, the program should pause for 2 seconds

Write a 101-manage_my_process Bash script that manages manage_my_process.
* When passing the argument start:
  * Starts manage_my_process
  * Creates a file containing its PID in /var/run/my_process.pid
  * Displays "manage_my_process started"
* When passing the argument stop:
  * Stops manage_my_process
  * Deletes the file /var/run/my_process.pid
  * Displays "manage_my_process stopped"
* When passing the argument restart:
  * Stops manage_my_process
  * Deletes the file /var/run/my_process.pid
  * Starts manage_my_process
  * Creates a file containing its PID in /var/run/my_process.pid
  * Displays "manage_my_process restarted"
* Displays "Usage: manage_my_process {start|stop|restart}" if any other argument or no argument is passed

#### 11. Zombie Process Creation
**[102-zombie.c](102-zombie.c)**

Write a C program that creates 5 zombie processes.
* For every zombie process created, it displays "Zombie process created, PID: ZOMBIE_PID"
* Your code should use the Betty style
* When your code is done creating the parent process and the zombies, use the function sleep with a large enough number to allow the examination of the zombie processes

## Linux Processes

### What is a Process?

A process is an instance of a running program, with its own memory space, system resources, and unique Process ID (PID). Every time you execute a command in Linux, you're creating a new process.

Processes in Linux have the following characteristics:
- Each has a unique Process ID (PID)
- Each has a Parent Process ID (PPID)
- Processes can create child processes
- They consume system resources like CPU, memory, and I/O
- They have different states: running, sleeping, stopped, zombie, etc.

### Process Creation

In Linux, new processes are created by:

1. **fork()**: Creates a child process by duplicating the parent process
2. **exec()**: Replaces the current process image with a new one
3. **system()**: Creates a sub-shell to execute a command

Bash scripts typically create processes when running commands.

### Process States

| State | Description |
|-------|-------------|
| Running (R) | Process is either running or ready to run |
| Sleeping (S) | Process is waiting for an event or resource |
| Uninterruptible Sleep (D) | Process is in sleep state that cannot be interrupted |
| Stopped (T) | Process has been stopped, usually by a signal |
| Zombie (Z) | Process has completed execution but still has an entry in the process table |
| Dead (X) | Process is being killed |

## Process Commands

### Viewing Processes

| Command | Description | Example |
|---------|-------------|---------|
| `ps` | Display information about active processes | `ps aux` |
| `top` | Dynamic real-time view of processes | `top` |
| `htop` | Interactive process viewer (more user-friendly) | `htop` |
| `pgrep` | Find processes by name and other attributes | `pgrep bash` |
| `pstree` | Display processes in a tree format | `pstree` |

### Process Options for `ps`

| Option | Description |
|--------|-------------|
| `a` | Show processes for all users |
| `u` | Display in user-oriented format |
| `x` | Include processes without a controlling terminal |
| `f` | Show process hierarchy (forest view) |
| `e` | Show all processes (equivalent to -A) |
| `-o` | Select specific columns to display |
| `--sort` | Sort output by specified criteria |

### Managing Processes

| Command | Description | Example |
|---------|-------------|---------|
| `kill` | Send a signal to a process | `kill -15 1234` |
| `pkill` | Send signal to processes based on name | `pkill firefox` |
| `killall` | Kill processes by name | `killall nginx` |
| `nice` | Start a process with modified scheduling priority | `nice -n 10 command` |
| `renice` | Alter priority of an existing process | `renice -n 10 -p 1234` |
| `bg` | Resume jobs in the background | `bg %1` |
| `fg` | Bring jobs to the foreground | `fg %1` |
| `jobs` | List active jobs | `jobs -l` |
| `nohup` | Run a command immune to hangups | `nohup command &` |

## Linux Signals

Signals are software interrupts sent to a process to indicate that an event has occurred. They are a form of inter-process communication (IPC).

### Common Signals

| Signal | Number | Description | Can Be Caught/Ignored |
|--------|--------|-------------|----------------------|
| SIGHUP | 1 | Hangup detected | Yes |
| SIGINT | 2 | Interrupt from keyboard (Ctrl+C) | Yes |
| SIGQUIT | 3 | Quit from keyboard (Ctrl+\\) | Yes |
| SIGILL | 4 | Illegal instruction | Yes |
| SIGTRAP | 5 | Trace/breakpoint trap | Yes |
| SIGABRT | 6 | Abort signal | Yes |
| SIGFPE | 8 | Floating point exception | Yes |
| SIGKILL | 9 | Kill signal (cannot be caught) | No |
| SIGSEGV | 11 | Invalid memory reference | Yes |
| SIGPIPE | 13 | Broken pipe | Yes |
| SIGALRM | 14 | Timer signal from alarm | Yes |
| SIGTERM | 15 | Termination signal (default for kill) | Yes |
| SIGUSR1 | 10 | User-defined signal 1 | Yes |
| SIGUSR2 | 12 | User-defined signal 2 | Yes |
| SIGCHLD | 17 | Child stopped or terminated | Yes |
| SIGCONT | 18 | Continue if stopped | Yes |
| SIGSTOP | 19 | Stop process (cannot be caught) | No |
| SIGTSTP | 20 | Stop typed at terminal (Ctrl+Z) | Yes |

### Sending Signals

To send a signal to a process, you can use these commands:

```bash
# Send SIGTERM (15) to process with PID 1234
kill 1234

# Send SIGKILL (9) to process with PID 1234
kill -9 1234

# Send SIGTERM to all processes named "firefox"
pkill firefox

# Send SIGKILL to all processes named "firefox"
pkill -9 firefox
```

## Signal Handling in Bash

In Bash scripts, you can set up handlers to trap signals and perform actions when they're received:

```bash
#!/usr/bin/env bash
# Example of signal trapping

# Function to handle SIGTERM
function handle_sigterm {
    echo "Received SIGTERM. Cleaning up..."
    # Cleanup code here
    exit 0
}

# Function to handle SIGINT
function handle_sigint {
    echo "Received SIGINT. Do you really want to exit? (y/n)"
    read answer
    if [[ "$answer" == "y" ]]; then
        exit 0
    fi
}

# Set up signal traps
trap handle_sigterm SIGTERM
trap handle_sigint SIGINT

# Main program
echo "Process started with PID $$"
echo "Press Ctrl+C to interrupt or run 'kill $$' from another terminal"

# Infinite loop
while true; do
    echo "Running..."
    sleep 5
done
```

## Foreground vs Background Processes

### Foreground Processes

Foreground processes are connected to the terminal and receive input from the keyboard. When a foreground process is running, you cannot use the terminal until the process completes or is moved to the background.

```bash
# Running a command in the foreground
sleep 10
```

### Background Processes

Background processes run independently of the terminal, allowing you to continue using the terminal while they run.

```bash
# Running a command in the background
sleep 10 &

# Moving a running process to the background
# First press Ctrl+Z to stop it, then use bg
^Z
[1]+  Stopped                 sleep 10
bg
[1]+ sleep 10 &
```

## Daemon Processes

Daemons are special types of background processes that run unattended and are typically started at system boot time. They often provide services and respond to system or network requests.

Characteristics of daemon processes:
- Detached from any terminal (no controlling terminal)
- Often have parent PID of 1 (init)
- Run in the background
- Often have a 'd' at the end of their name (e.g., sshd, httpd)

### Creating a Daemon Process in Bash

To create a simple daemon in Bash:

```bash
#!/usr/bin/env bash
# Simple daemon process example

# Redirect standard file descriptors to /dev/null
exec 1>/dev/null
exec 2>/dev/null
exec 0</dev/null

# Fork and have the parent exit
if [[ "$(($$ - $PPID))" != 1 ]]; then
    exit 0
fi

# Detach from any terminal by creating a new session
setsid -f bash -c '
    # Create PID file
    echo $$ > /var/run/mydaemon.pid
    
    # Main daemon loop
    while true; do
        # Do daemon tasks here
        echo "Daemon is running" >> /var/log/mydaemon.log
        sleep 60
    done
'
```

## Zombie Processes

A zombie process is a process that has completed execution but still has an entry in the process table because its parent has not yet read its exit status. These processes typically show up with "Z" state in the ps output.

### Creating a Zombie Process in C

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
    pid_t pid;
    
    pid = fork();
    if (pid < 0) {
        perror("fork");
        exit(1);
    }
    
    if (pid == 0) {
        // Child process
        printf("Child process (PID: %d) is running\n", getpid());
        exit(0);
    } else {
        // Parent process
        printf("Parent process (PID: %d) created child (PID: %d)\n", getpid(), pid);
        printf("Child is now a zombie process\n");
        // Parent sleeps without waiting for the child, creating a zombie
        sleep(60);
    }
    
    return 0;
}
```

## Resources

* [Linux Processes and Signals](https://www.tutorialspoint.com/unix/unix-processes.htm)
* [Bash Signal Handling](https://www.gnu.org/software/bash/manual/html_node/Signals.html)
* [Process Management in Linux](https://www.digitalocean.com/community/tutorials/process-management-in-linux)
* [Kill Command in Linux](https://linuxize.com/post/kill-command-in-linux/)
* [Zombie Processes and How to Prevent Them](https://www.howtogeek.com/119815/htg-explains-what-is-a-zombie-process-on-linux/)
* [Bash trap Command](https://linuxhint.com/bash_trap_command/)
* [Job Control in Bash](https://www.gnu.org/software/bash/manual/html_node/Job-Control.html)

---

*Project by ALX System Engineering & DevOps*
