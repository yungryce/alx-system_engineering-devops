# Shell Redirections and Filters

<p align="center">
  <img src="https://img.shields.io/badge/Shell-Redirections-green.svg" alt="Shell Redirections">
  <img src="https://img.shields.io/badge/Text-Processing-blue.svg" alt="Text Processing">
  <img src="https://img.shields.io/badge/Data-Filtering-orange.svg" alt="Data Filtering">
  <img src="https://img.shields.io/badge/Command-Pipelines-yellow.svg" alt="Command Pipelines">
</p>

## Project Overview

This repository provides an introduction to shell redirections and filters in Unix-like operating systems. It focuses on understanding and mastering input/output stream manipulation, text processing utilities, pattern matching, and command chaining to efficiently handle and transform data through shell commands.

## Learning Objectives

By the end of this project, you should be able to explain:

* What the shell I/O redirections are and how they work
* How to redirect standard output to a file or another command
* How to get standard input from a file instead of the keyboard
* How to send the output from one program to the input of another
* How to combine commands and filters with redirections
* What special characters are and how to escape them
* How to use common text processing commands like `head`, `tail`, `find`, `grep`, etc.
* How to use advanced filters for data manipulation

## Requirements

* Ubuntu 20.04 LTS
* All scripts must pass Shellcheck verification
* The first line of all Bash scripts should be `#!/bin/bash`
* All files must be executable (`chmod +x filename`)
* No use of backticks, &&, || or ; in scripts
* All scripts must be exactly two lines long (the shebang and one command)

## Project Tasks

### Basic Output and File Display

#### 0. Hello World
**[0-hello_world](0-hello_world)**

Write a script that prints "Hello, World", followed by a new line to the standard output.
```bash
#!/bin/bash
echo "Hello, World"
```

#### 1. Confused Smiley
**[1-confused_smiley](1-confused_smiley)**

Write a script that displays a confused smiley `"(Ôo)'`.

#### 2. Let's Display a File
**[2-hellofile](2-hellofile)**

Display the content of the `/etc/passwd` file.

#### 3. What About 2?
**[3-twofiles](3-twofiles)**

Display the content of `/etc/passwd` and `/etc/hosts`.

#### 4. Last Lines of a File
**[4-lastlines](4-lastlines)**

Display the last 10 lines of `/etc/passwd`.

#### 5. First Lines of a File
**[5-firstlines](5-firstlines)**

Display the first 10 lines of `/etc/passwd`.

#### 6. Line #2
**[6-third_line](6-third_line)**

Write a script that displays the third line of the file `iacta`.

### File Manipulation

#### 7. It is a Good File that Cuts Iron Without Making a Noise
**[7-file](7-file)**

Write a shell script that creates a file named exactly `\*\\'"Best School"\'\\*$\?\*\*\*\*\*:)` containing the text "Best School" ending by a new line.

#### 8. Save Current State of Directory
**[8-cwd_state](8-cwd_state)**

Write a script that writes into the file `ls_cwd_content` the result of the command `ls -la`.

#### 9. Duplicate Last Line
**[9-duplicate_last_line](9-duplicate_last_line)**

Write a script that duplicates the last line of the file `iacta`.

#### 10. No More JavaScript
**[10-no_more_js](10-no_more_js)**

Write a script that deletes all the regular files (not the directories) with a `.js` extension that are present in the current directory and all its subfolders.

#### 11. Don't Just Count Your Directories, Make Your Directories Count
**[11-directories](11-directories)**

Write a script that counts the number of directories and sub-directories in the current directory.

#### 12. What's New
**[12-newest_files](12-newest_files)**

Create a script that displays the 10 newest files in the current directory, one file per line, sorted from newest to oldest.

### Text Processing

#### 13. Being Unique is Better than Being Perfect
**[13-unique](13-unique)**

Create a script that takes a list of words as input and prints only words that appear exactly once.

#### 14. It Must Be in That File
**[14-findthatword](14-findthatword)**

Display lines containing the pattern "root" from the file `/etc/passwd`.

#### 15. Count That Word
**[15-countthatword](15-countthatword)**

Display the number of lines that contain the pattern "bin" in the file `/etc/passwd`.

#### 16. What's Next?
**[16-whatsnext](16-whatsnext)**

Display lines containing the pattern "root" and 3 lines after them in the file `/etc/passwd`.

#### 17. I Hate Bins
**[17-hidethisword](17-hidethisword)**

Display all the lines in the file `/etc/passwd` that do not contain the pattern "bin".

#### 18. Letters Only Please
**[18-letteronly](18-letteronly)**

Display all lines of the file `/etc/ssh/sshd_config` starting with a letter.

#### 19. A to Z
**[19-AZ](19-AZ)**

Replace all characters `A` and `c` from input to `Z` and `e` respectively.

#### 20. Without C, You Would Live in Hiago
**[20-hiago](20-hiago)**

Create a script that removes all letters `c` and `C` from input.

#### 21. esreveR
**[21-reverse](21-reverse)**

Write a script that reverse its input.

#### 22. DJ Cut Killer
**[22-users_and_homes](22-users_and_homes)**

Write a script that displays all users and their home directories, sorted by users.

### Advanced Text Processing

#### 23. Empty Casks Make the Most Noise
**[100-empty_casks](100-empty_casks)**

Write a command that finds all empty files and directories in the current directory and all sub-directories.

#### 24. A GIF is Worth Ten Thousand Words
**[101-gifs](101-gifs)**

Write a script that lists all the files with a `.gif` extension in the current directory and all its sub-directories.

#### 25. Acrostic
**[102-acrostic](102-acrostic)**

Create a script that decodes acrostics that use the first letter of each line.

#### 26. The Biggest Fan
**[103-the_biggest_fan](103-the_biggest_fan)**

Write a script that parses web server logs in TSV format as input and displays the 11 hosts or IP addresses which did the most requests.

## Standard Streams

In Unix/Linux systems, there are three standard streams for input/output operations:

1. **Standard Input (stdin)**: The default source of input for commands, typically the keyboard.

2. **Standard Output (stdout)**: The default destination for command output, typically the terminal.

3. **Standard Error (stderr)**: The default destination for error messages, typically the terminal.

Each stream is associated with a file descriptor:
- stdin: file descriptor 0
- stdout: file descriptor 1
- stderr: file descriptor 2

## Redirection Operators

Shell redirections allow you to control where input comes from and where output goes to. Here are the most common redirection operators:

| Operator | Description | Example |
|----------|-------------|---------|
| `>`      | Redirects stdout to a file (overwrites) | `ls > files.txt` |
| `>>`     | Appends stdout to a file | `echo "text" >> log.txt` |
| `<`      | Redirects stdin from a file | `sort < unsorted.txt` |
| `2>`     | Redirects stderr to a file | `find / -name "file" 2> errors.log` |
| `2>&1`   | Redirects stderr to stdout | `command > all.log 2>&1` |
| `&>`     | Redirects both stdout and stderr to a file (Bash 4+) | `command &> all.log` |
| `<>`     | Opens a file for both reading and writing | `exec 3<> file.txt` |
| `<<<`    | Here-string (redirects a string as stdin) | `grep "pattern" <<< "text"` |
| `<<`     | Here-document (multiline input) | `cat << EOF` |

## Command Pipelines with '|'

The pipe operator (`|`) connects the stdout of one command to the stdin of another. This allows you to create powerful command chains:

```bash
command1 | command2 | command3
```

For example:

```bash
cat file.txt | grep "pattern" | sort | uniq > result.txt
```

This pipeline:
1. Outputs the content of file.txt
2. Finds lines containing "pattern"
3. Sorts the matching lines
4. Removes duplicate lines
5. Saves the result to result.txt

## Common Text Processing Commands

| Command | Description | Example |
|---------|-------------|---------|
| `cat`   | Concatenate and display files | `cat file.txt` |
| `head`  | Display the beginning of a file | `head -n 5 file.txt` |
| `tail`  | Display the end of a file | `tail -n 10 file.txt` |
| `grep`  | Search for patterns in text | `grep "pattern" file.txt` |
| `sed`   | Stream editor for text transformation | `sed 's/old/new/g' file.txt` |
| `awk`   | Pattern scanning and text processing | `awk '{print $1}' file.txt` |
| `sort`  | Sort lines of text | `sort -n numbers.txt` |
| `uniq`  | Report or filter out repeated lines | `sort file.txt | uniq` |
| `wc`    | Count lines, words, and characters | `wc -l file.txt` |
| `cut`   | Remove sections from lines | `cut -d':' -f1 /etc/passwd` |
| `tr`    | Translate or delete characters | `echo "text" | tr 'a-z' 'A-Z'` |
| `paste` | Merge lines of files | `paste file1.txt file2.txt` |
| `join`  | Join lines on a common field | `join -t':' file1.txt file2.txt` |
| `tee`   | Read from stdin and write to stdout and files | `ls | tee files.txt` |

## Special Characters in Shell

Special characters have specific meanings in shell commands and scripting:

| Character | Meaning | Example |
|-----------|---------|---------|
| `#`       | Comment | `# This is a comment` |
| `;`       | Command separator | `cmd1 ; cmd2` |
| `*`       | Wildcard (any string) | `ls *.txt` |
| `?`       | Wildcard (any single character) | `ls file?.txt` |
| `[]`      | Character class | `ls [a-c]*.txt` |
| `()`      | Command grouping | `(cd dir && ls)` |
| `{}`      | Brace expansion | `echo {1..5}` |
| `\`       | Escape character | `echo \*` |
| `'`       | Strong quotes (no interpretation) | `echo '$HOME'` |
| `"`       | Weak quotes (some interpretation) | `echo "$HOME"` |
| `$`       | Variable expansion | `echo $PATH` |
| `` ` ``   | Command substitution (old style) | `` echo `date` `` |
| `$()`     | Command substitution | `echo $(date)` |
| `~`       | Home directory | `cd ~/Documents` |
| `&`       | Background process | `command &` |
| `&&`      | Logical AND | `cmd1 && cmd2` |
| `||`      | Logical OR | `cmd1 || cmd2` |
| `!`       | Command history or logical NOT | `!ls` or `if [ ! -f file ]` |

## Escaping Special Characters

To use special characters literally (without their special meaning), you need to escape them using the backslash (`\`) or by enclosing them in single quotes:

```bash
# Using backslash
echo The price is \$5.00

# Using single quotes
echo 'The price is $5.00'
```

## Advanced Redirection Techniques

### Redirecting Both stdout and stderr

```bash
# Redirect both to the same file
command > file.txt 2>&1

# In Bash 4+
command &> file.txt

# Redirect to different files
command > output.txt 2> error.txt
```

### Using Here-Documents

Here-documents allow you to include multiline text directly in your script:

```bash
cat << EOF > file.txt
This is line 1
This is line 2
This is line 3
EOF
```

### Using Named Pipes (FIFOs)

Named pipes allow for interprocess communication:

```bash
mkfifo mypipe
command1 > mypipe &
command2 < mypipe
```

## Resources

* [Linux I/O Redirection](https://tldp.org/LDP/abs/html/io-redirection.html)
* [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/)
* [ShellCheck](https://www.shellcheck.net/)
* [Grep Command Tutorial](https://www.geeksforgeeks.org/grep-command-in-unixlinux/)
* [Linux Text Processing Commands](https://linuxhandbook.com/text-processing-commands/)
* [Linux Command Library](https://linuxcommandlibrary.com/)

---

*Project by ALX System Engineering & DevOps*

