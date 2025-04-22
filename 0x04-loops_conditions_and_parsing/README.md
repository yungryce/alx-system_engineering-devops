# Loops, Conditions and Parsing

<p align="center">
  <img src="https://img.shields.io/badge/Shell-Loops-green.svg" alt="Shell Loops">
  <img src="https://img.shields.io/badge/Bash-Conditionals-blue.svg" alt="Bash Conditionals">
  <img src="https://img.shields.io/badge/SSH-Keys-orange.svg" alt="SSH Keys">
  <img src="https://img.shields.io/badge/File-Parsing-yellow.svg" alt="File Parsing">
</p>

## Project Overview

This repository provides an introduction to advanced shell scripting concepts, focusing on control structures like loops and conditional statements, SSH key generation and management, file testing and manipulation, and data extraction from structured text files including log files. These skills are essential for writing efficient, maintainable scripts for system administration and automation tasks.

## Learning Objectives

By the end of this project, you should be able to explain:

* How to create SSH keys and their importance in secure authentication
* The advantages of using `#!/usr/bin/env bash` over `#!/bin/bash`
* How to use while, until, and for loops in Bash scripts
* How to implement if, else, elif, and case condition statements
* How to use the cut command for text processing
* What file and comparison operators are and how to use them
* How to work with /etc/passwd and understand its structure
* How to parse and analyze Apache log files
* How to apply ShellCheck to validate and improve scripts

## Requirements

* Ubuntu 20.04 LTS
* All scripts must pass Shellcheck version 0.7.0 verification
* The first line of all Bash scripts should be `#!/usr/bin/env bash`
* The second line should be a comment explaining what the script does
* All files must be executable (`chmod +x filename`)
* No use of awk (except for the advanced tasks 102 and 103)
* All Bash scripts must pass Shellcheck without any errors

## Project Tasks

### 0. Create a SSH RSA key pair
**[0-RSA_public_key.pub](0-RSA_public_key.pub)**

Generate an RSA key pair:
1. Share your public key in your answer file `0-RSA_public_key.pub`
2. Fill the SSH public key field of your intranet profile
3. Keep the private key secure to use for future projects

**Tips**: 
- Use `ssh-keygen` to generate RSA key pairs
- Protect your private key with a secure passphrase

### Loop Implementation

#### 1. For Best School
**[1-for_best_school](1-for_best_school)**

Write a Bash script that displays "Best School" 10 times using a for loop.

#### 2. While Best School
**[2-while_best_school](2-while_best_school)**

Write a Bash script that displays "Best School" 10 times using a while loop.

#### 3. Until Best School
**[3-until_best_school](3-until_best_school)**

Write a Bash script that displays "Best School" 10 times using an until loop.

#### 4. If 9, say Hi!
**[4-if_9_say_hi](4-if_9_say_hi)**

Write a Bash script that displays "Best School" 10 times, but for the 9th iteration, displays "Best School" and then "Hi" on a new line, using a while loop and if statement.

#### 5. 4 bad luck, 8 is your chance
**[5-4_bad_luck_8_is_your_chance](5-4_bad_luck_8_is_your_chance)**

Write a Bash script that loops from 1 to 10 and:
- Displays "bad luck" for the 4th loop iteration
- Displays "good luck" for the 8th loop iteration
- Displays "Best School" for other iterations
- Use a while loop and if, elif, and else statements

#### 6. Superstitious numbers
**[6-superstitious_numbers](6-superstitious_numbers)**

Write a Bash script that displays numbers from 1 to 20 and:
- Displays "4 and then bad luck from China" for the 4th loop iteration
- Displays "9 and then bad luck from Japan" for the 9th loop iteration
- Displays "17 and then bad luck from Italy" for the 17th loop iteration
- Use a while loop and case statement

#### 7. Clock
**[7-clock](7-clock)**

Write a Bash script that displays the time for 12 hours and 59 minutes:
- Display hours from 0 to 12
- Display minutes from 1 to 59
- Use a while loop

#### 8. For ls
**[8-for_ls](8-for_ls)**

Write a Bash script that displays the content of the current directory:
- In a list format
- Where only the part of the name after the first dash is displayed
- Use a for loop and do not display hidden files

### File Operations and Conditionals

#### 9. To file, or not to file
**[9-to_file_or_not_to_file](9-to_file_or_not_to_file)**

Write a Bash script that gives you information about the `school` file:
- Check if the file exists
- If it exists, print: "school file exists"
- If it does not exist, print: "school file does not exist"
- If the file exists, check if it's empty
  - If empty, print: "school file is empty"
  - If not empty, print: "school file is not empty"
- If the file exists, check if it's a regular file
  - If it's a regular file, print: "school is a regular file"
  - If not, do not print anything

#### 10. FizzBuzz
**[10-fizzbuzz](10-fizzbuzz)**

Write a Bash script that displays numbers from 1 to 100:
- Displays "FizzBuzz" when the number is a multiple of 3 and 5
- Displays "Fizz" when the number is a multiple of 3
- Displays "Buzz" when the number is a multiple of 5
- Otherwise, displays the number
- In a list format

### Log Parsing and Data Extraction

#### 11. Read and cut
**[100-read_and_cut](100-read_and_cut)**

Write a Bash script that displays the content of the file `/etc/passwd`:
- Only display the username, user id, and home directory path for each line
- Use the while loop and cut command

#### 12. Tell the story of passwd
**[101-tell_the_story_of_passwd](101-tell_the_story_of_passwd)**

Write a Bash script that tells a story based on the content of `/etc/passwd`:
- Use the while loop + IFS to extract information from `/etc/passwd`
- Format the output as: "The user USERNAME is part of the GROUP_ID gang, lives in HOME_DIRECTORY and rides COMMAND/SHELL. USER ID's place is protected by the passcode PASSWORD, more info about the user here: USER ID INFO"

#### 13. Let's parse Apache logs
**[102-lets_parse_apache_logs](102-lets_parse_apache_logs)**

Write a Bash script that displays the visitor IP along with the HTTP status code from an Apache log file:
- Format: IP HTTP_CODE
- In a list format
- Use awk
- Analyze the Apache log file in the format: IP - [DATE] "METHOD /PATH HTTP_VERSION" HTTP_CODE SIZE

#### 14. Dig the data
**[103-dig_the-data](103-dig_the-data)**

Write a Bash script that groups visitors by IP and HTTP status code and displays the data:
- Format: OCCURRENCE_NUMBER IP HTTP_CODE
- Ordered from the greatest to the lowest number of occurrences
- Use awk
- Analyze the Apache log file in the same format as Task 13

## Bash Control Structures

### Loops

Loops allow you to execute a block of code repeatedly as long as a specified condition is true or for a defined number of iterations.

#### For Loop

The for loop iterates over a list of items and executes commands for each item:

```bash
for variable in list
do
    commands
done
```

Example:
```bash
for name in John Paul George Ringo
do
    echo "Hello, $name"
done
```

#### While Loop

The while loop executes commands as long as the condition is true:

```bash
while [ condition ]
do
    commands
done
```

Example:
```bash
count=1
while [ $count -le 5 ]
do
    echo "Count: $count"
    ((count++))
done
```

#### Until Loop

The until loop executes commands until the condition becomes true:

```bash
until [ condition ]
do
    commands
done
```

Example:
```bash
count=1
until [ $count -gt 5 ]
do
    echo "Count: $count"
    ((count++))
done
```

### Conditional Statements

Conditional statements allow your script to make decisions based on whether a condition is true or false.

#### If Statement

Basic if statement structure:

```bash
if [ condition ]
then
    commands
fi
```

#### If-Else Statement

```bash
if [ condition ]
then
    commands1
else
    commands2
fi
```

#### If-Elif-Else Statement

```bash
if [ condition1 ]
then
    commands1
elif [ condition2 ]
then
    commands2
else
    commands3
fi
```

#### Case Statement

The case statement allows you to match values against patterns:

```bash
case $variable in
    pattern1)
        commands1
        ;;
    pattern2)
        commands2
        ;;
    *)
        default_commands
        ;;
esac
```

## File Test Operators

File test operators allow you to test various attributes of a file:

| Operator | Description |
|----------|-------------|
| `-e file` | True if file exists |
| `-f file` | True if file is a regular file |
| `-d file` | True if file is a directory |
| `-r file` | True if file is readable |
| `-w file` | True if file is writable |
| `-x file` | True if file is executable |
| `-s file` | True if file exists and is not empty |
| `-L file` | True if file is a symbolic link |

## Comparison Operators

### Integer Comparison

| Operator | Description |
|----------|-------------|
| `-eq` | Equal to |
| `-ne` | Not equal to |
| `-gt` | Greater than |
| `-ge` | Greater than or equal to |
| `-lt` | Less than |
| `-le` | Less than or equal to |

Example:
```bash
if [ "$a" -eq "$b" ]
then
    echo "a is equal to b"
fi
```

### String Comparison

| Operator | Description |
|----------|-------------|
| `=` | Equal to |
| `!=` | Not equal to |
| `-z` | True if string is empty |
| `-n` | True if string is not empty |

Example:
```bash
if [ "$a" = "$b" ]
then
    echo "a equals b"
fi
```

## SSH Key Generation

SSH keys provide a secure way of logging into a server without using a password. A key pair consists of a public key and a private key.

### Steps to Generate SSH Keys:

1. Open terminal
2. Run the SSH key generation command:
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```

3. When prompted, enter a file location or press Enter to accept the default location
4. Enter a secure passphrase (highly recommended)
5. Your keys will be created in `~/.ssh/`:
   - Private key: `~/.ssh/id_rsa`
   - Public key: `~/.ssh/id_rsa.pub`

6. To use your key with a remote server, add your public key to the server's authorized keys:
   ```bash
   ssh-copy-id username@remote_host
   ```

### SSH Key Security Best Practices:

- Never share your private key
- Use a strong passphrase to protect your private key
- Use different keys for different services/servers
- Regularly rotate your keys (every few months)
- Store your private key securely with appropriate permissions (chmod 600)

## Apache Log Format

The common Apache log format contains various fields separated by spaces:

```
%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-agent}i\"
```

Where:
- `%h`: Remote host (IP address)
- `%l`: Remote logname (usually `-`)
- `%u`: Remote user if authenticated
- `%t`: Time the request was received
- `%r`: First line of request (method, path, protocol)
- `%>s`: HTTP status code
- `%b`: Size of response in bytes
- `%{Referer}i`: Referer header
- `%{User-agent}i`: User-agent header

Example log line:
```
127.0.0.1 - frank [10/Oct/2000:13:55:36 -0700] "GET /apache_pb.gif HTTP/1.0" 200 2326 "http://www.example.com/start.html" "Mozilla/4.08 [en] (Win98; I ;Nav)"
```

## Resources

* [Loops, conditions and parsing](https://intranet.alxswe.com/rltoken/wT98UJfv_E2tk4yP9PcLLw)
* [SSH Key Generation Guide](https://www.ssh.com/academy/ssh/keygen)
* [Bash Guide - Loops](https://tldp.org/LDP/Bash-Beginners-Guide/html/chap_09.html)
* [Advanced Bash-Scripting Guide - Tests](https://tldp.org/LDP/abs/html/tests.html)
* [ShellCheck](https://www.shellcheck.net/)
* [Bash Reference Manual](https://www.gnu.org/software/bash/manual/bash.html)
* [AWK Language Programming](https://www.gnu.org/software/gawk/manual/gawk.html)

---

*Project by ALX System Engineering & DevOps*
