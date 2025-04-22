# Shell Basics

<p align="center">
  <img src="https://img.shields.io/badge/Shell-Scripting-green.svg" alt="Shell Scripting">
  <img src="https://img.shields.io/badge/Unix-Linux-blue.svg" alt="Unix/Linux">
  <img src="https://img.shields.io/badge/File-Management-orange.svg" alt="File Management">
  <img src="https://img.shields.io/badge/Command-Line-yellow.svg" alt="Command Line">
</p>

## Project Overview

This project introduces the fundamental concepts of Unix/Linux shell navigation, file manipulation, and basic command-line operations. It focuses on mastering essential commands for navigating through the file system, managing files and directories, understanding file permissions, and creating simple shell scripts to automate tasks.

## Learning Objectives

By the end of this project, you should be able to explain:

* What the shell is and its role in the operating system
* How to navigate directories using shell commands
* What the home directory is and how to return to it
* The difference between absolute and relative paths
* How to display the contents of a directory in different formats
* How to create, move, and delete files and directories
* How to use options and arguments with commands
* How to use wildcards and special characters in shell
* How to identify different file types
* How to create symbolic links
* How to use commands like `ls`, `cd`, `pwd`, `cp`, `mv`, `rm`, `mkdir`
* How to use the `file` command to determine file types

## Requirements

* Ubuntu 20.04 LTS
* All scripts must pass Shellcheck verification
* The first line of all Bash scripts should be `#!/bin/bash`
* All files must be executable (`chmod +x filename`)
* No use of backticks, &&, || or ; in scripts
* All scripts must be exactly two lines long (the shebang and one command)

## Project Tasks

### 0. Current Working Directory
**[0-current_working_directory](0-current_working_directory)**

Write a script that prints the absolute path name of the current working directory.

```bash
#!/bin/bash
pwd
```

### 1. List Directory Contents
**[1-listit](1-listit)**

Display the contents list of your current directory.

### 2. Change to Home Directory
**[2-bring_me_home](2-bring_me_home)**

Write a script that changes the working directory to the user's home directory.

### 3. List Files in Long Format
**[3-listfiles](3-listfiles)**

Display current directory contents in a long format.

### 4. List Hidden Files
**[4-listmorefiles](4-listmorefiles)**

Display current directory contents, including hidden files, in long format.

### 5. List Files with User and Group IDs
**[5-listfilesdigitonly](5-listfilesdigitonly)**

Display current directory contents in long format with user and group IDs displayed numerically.

### 6. Create a Directory
**[6-firstdirectory](6-firstdirectory)**

Create a script that creates a directory named `my_first_directory` in the `/tmp/` directory.

### 7. Move a File
**[7-movethatfile](7-movethatfile)**

Move the file `betty` from `/tmp/` to `/tmp/my_first_directory`.

### 8. Delete a File
**[8-firstdelete](8-firstdelete)**

Delete the file `betty` in `/tmp/my_first_directory`.

### 9. Delete a Directory
**[9-firstdirdeletion](9-firstdirdeletion)**

Delete the directory `my_first_directory` that is in the `/tmp` directory.

### 10. Change to Previous Directory
**[10-back](10-back)**

Write a script that changes the working directory to the previous one.

### 11. List Multiple Directories
**[11-lists](11-lists)**

Write a script that lists all files in the current directory, parent directory, and `/boot` directory in long format.

### 12. File Type
**[12-file_type](12-file_type)**

Write a script that prints the type of the file named `iamafile` in the `/tmp` directory.

### 13. Symbolic Link
**[13-symbolic_link](13-symbolic_link)**

Create a symbolic link to `/bin/ls` named `__ls__` in the current directory.

### 14. Copy HTML Files
**[14-copy_html](14-copy_html)**

Create a script that copies all HTML files from the current directory to the parent directory, but only copy files that didn't exist or are newer.

### 15. Move Uppercase Files
**[100-lets_move](100-lets_move)**

Create a script that moves all files beginning with an uppercase letter to the directory `/tmp/u`.

### 16. Clean Emacs
**[101-clean_emacs](101-clean_emacs)**

Create a script that deletes all files in the current directory that end with the character `~`.

### 17. Create Directory Tree
**[102-tree](102-tree)**

Create a script that creates the directories `welcome/`, `welcome/to/`, and `welcome/to/school` in the current directory.

### 18. List Files with Commas
**[103-commas](103-commas)**

Write a script that lists all files and directories of the current directory, separated by commas.

### 19. Magic File
**[school.mgc](school.mgc)**

Create a magic file that can be used with the `file` command to detect `School` data files.

## Shell Commands Guide

### Navigation Commands

| Command | Description | Example |
|---------|-------------|---------|
| `pwd`   | Print working directory | `pwd` |
| `cd`    | Change directory | `cd /tmp` |
| `ls`    | List directory contents | `ls -la` |
| `cd -`  | Go to previous directory | `cd -` |
| `cd ~`  | Go to home directory | `cd ~` |

### File Operations

| Command | Description | Example |
|---------|-------------|---------|
| `cp`    | Copy files/directories | `cp file.txt /tmp` |
| `mv`    | Move/rename files | `mv file.txt newname.txt` |
| `rm`    | Remove files | `rm file.txt` |
| `mkdir` | Create directory | `mkdir new_dir` |
| `rmdir` | Remove empty directory | `rmdir empty_dir` |
| `touch` | Create empty file | `touch newfile.txt` |
| `file`  | Determine file type | `file document.txt` |

### Common ls Options

| Option | Description |
|--------|-------------|
| `-l`   | Long format listing |
| `-a`   | Show hidden files |
| `-h`   | Human-readable sizes |
| `-t`   | Sort by modification time |
| `-r`   | Reverse order |
| `-R`   | Recursive listing |
| `-d`   | List directories themselves, not contents |

### Path Types

**Absolute Path**: Specifies the exact location from the root directory (starts with `/`)
```
/home/user/documents/file.txt
```

**Relative Path**: Specifies the location relative to current directory
```
documents/file.txt  # From current directory
../documents/file.txt  # From parent directory
```

### Special Directories

| Symbol | Meaning |
|--------|---------|
| `.`    | Current directory |
| `..`   | Parent directory |
| `~`    | Home directory |
| `/`    | Root directory |

### Symbolic Links

A symbolic link is a special type of file that points to another file or directory. Created with:

```bash
ln -s target_path link_name
```

Example:
```bash
ln -s /bin/ls __ls__
```

### File Type Detection

The `file` command is used to determine the type of a file:

```bash
file filename
```

Example output:
```
document.txt: ASCII text
image.jpg: JPEG image data
script.sh: Bourne-Again shell script, ASCII text executable
```

### Magic Files

Magic files contain patterns that help the `file` command recognize file types. A basic magic file structure:

```
0 string SCHOOL School data
!:mime School
```

This pattern looks for the string "SCHOOL" at offset 0 in the file and identifies it as "School data" with MIME type "School".

## Resources

* [Linux Command Line Basics](https://ubuntu.com/tutorials/command-line-for-beginners)
* [Bash Guide](https://guide.bash.academy/)
* [ShellCheck](https://www.shellcheck.net/)
* [Linux File System Hierarchy](https://www.tldp.org/LDP/Linux-Filesystem-Hierarchy/html/)
* [Linux Documentation Project](https://tldp.org/)

---

*Project by ALX System Engineering & DevOps*

