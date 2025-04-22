# Shell Variables and Expansions

<p align="center">
  <img src="https://img.shields.io/badge/Shell-Variables-green.svg" alt="Shell Variables">
  <img src="https://img.shields.io/badge/Shell-Expansions-blue.svg" alt="Shell Expansions">
  <img src="https://img.shields.io/badge/Environment-Customization-orange.svg" alt="Environment Customization">
  <img src="https://img.shields.io/badge/Shell-Aliases-yellow.svg" alt="Shell Aliases">
</p>

## Project Overview

This repository provides an introduction to shell variables, expansions, and initialization files in Unix-like operating systems. It focuses on understanding and applying various techniques for storing and manipulating data within the shell environment, customizing the user experience through initialization files, and automating tasks using aliases and variable expansions.

## Learning Objectives

By the end of this project, you should be able to explain:

* What shell initialization files are and their purpose
* What variables are and how to create, update and delete them
* The difference between local and global variables
* How to create, update and delete shell variables
* What special parameters `$?`, `$$`, `$#`, etc. are
* What shell expansions are and how to use them
* How to perform command substitution
* How to perform arithmetic operations in the shell
* How to create and use aliases
* How to list, set, and unset environment variables

## Requirements

* Ubuntu 20.04 LTS
* All scripts must pass Shellcheck verification
* The first line of all Bash scripts should be `#!/bin/bash`
* All files must be executable (`chmod +x filename`)
* No use of backticks, &&, || or ; in scripts
* All scripts must be exactly two lines long (the shebang and one command)

## Project Tasks

### Aliases and User Interaction

#### 0. Create an Alias
**[0-alias](0-alias)**

Create a script that creates an alias.
* Name: `ls`
* Value: `rm *`

```bash
#!/bin/bash
alias ls="rm *"
```

#### 1. Hello User
**[1-hello_you](1-hello_you)**

Create a script that prints `hello user`, where user is the current Linux user.

### PATH Management

#### 2. Add to PATH
**[2-path](2-path)**

Add `/action` to the `PATH`. Make it the last directory the shell looks into when looking for a program.

#### 3. Count Directories in PATH
**[3-paths](3-paths)**

Create a script that counts the number of directories in the PATH.

### Variable Display and Management

#### 4. Global Variables
**[4-global_variables](4-global_variables)**

Create a script that lists environment variables.

#### 5. Local Variables
**[5-local_variables](5-local_variables)**

Create a script that lists all local variables and environment variables, and functions.

#### 6. Create Local Variable
**[6-create_local_variable](6-create_local_variable)**

Create a script that creates a new local variable.
* Name: `BEST`
* Value: `School`

#### 7. Create Global Variable
**[7-create_global_variable](7-create_global_variable)**

Create a script that creates a new global variable.
* Name: `BEST`
* Value: `School`

### Arithmetic Operations

#### 8. Addition with Value Stored in Environment Variable
**[8-true_knowledge](8-true_knowledge)**

Write a script that prints the result of the addition of 128 with the value stored in the environment variable `TRUEKNOWLEDGE`, followed by a new line.

#### 9. Division
**[9-divide_and_rule](9-divide_and_rule)**

Write a script that prints the result of `POWER` divided by `DIVIDE`, followed by a new line.
* `POWER` and `DIVIDE` are environment variables

#### 10. Exponentiation
**[10-love_exponent_breath](10-love_exponent_breath)**

Write a script that displays the result of `BREATH` to the power `LOVE`.
* `BREATH` and `LOVE` are environment variables

#### 11. Binary to Decimal Conversion
**[11-binary_to_decimal](11-binary_to_decimal)**

Write a script that converts a number from base 2 to base 10.
* The number in base 2 is stored in the environment variable `BINARY`

### Text and Number Manipulation

#### 12. Character Combinations
**[12-combinations](12-combinations)**

Create a script that prints all possible combinations of two letters, except `oo`.
* Letters are lower cases, from a to z
* One combination per line
* Output should be alpha ordered, starting with `aa`
* Do not print `oo`
* Your script file should contain maximum 64 characters

#### 13. Print Float
**[13-print_float](13-print_float)**

Write a script that prints a number with two decimal places, followed by a new line.
* The number will be stored in the environment variable `NUM`

#### 14. Decimal to Hexadecimal Conversion
**[100-decimal_to_hexadecimal](100-decimal_to_hexadecimal)**

Write a script that converts a number from base 10 to base 16.
* The number in base 10 is stored in the environment variable `DECIMAL`

### Advanced Text Processing

#### 15. ROT13 Encryption
**[101-rot13](101-rot13)**

Write a script that encodes and decodes text using the rot13 encryption. Assume ASCII.

#### 16. Print Odd Lines
**[102-odd](102-odd)**

Write a script that prints every other line from the input, starting with the first line.

#### 17. Water and Stir
**[103-water_and_stir](103-water_and_stir)**

Write a shell script that adds the two numbers stored in the environment variables `WATER` and `STIR` and prints the result.
* `WATER` is in base `water`
* `STIR` is in base `stir`
* The result should be in base `bestchol`

## Shell Init Files

Shell initialization files are scripts that the shell executes when it is invoked. These files set up the shell environment with various settings, variables, and functions. Different shells use different initialization files.

### Bash Initialization Files

| File | Description | When It's Read |
|------|-------------|----------------|
| `/etc/profile` | System-wide initialization file | Login shell |
| `/etc/bash.bashrc` | System-wide per-interactive-shell startup file | Interactive shell |
| `~/.bash_profile` | Personal initialization file | Login shell |
| `~/.bashrc` | Personal per-interactive-shell startup file | Interactive shell |
| `~/.bash_logout` | Personal cleanup file | When an interactive login shell exits |

### Order of Initialization

For Bash login shells:
1. `/etc/profile`
2. First found of `~/.bash_profile`, `~/.bash_login`, or `~/.profile`

For Bash interactive non-login shells:
1. `/etc/bash.bashrc`
2. `~/.bashrc`

## Shell Variables

Shell variables are used to store data that can be accessed and manipulated within the shell. Variables can hold different types of data, such as strings, numbers, and arrays.

### Types of Variables

| Type | Scope | Description | Command to List |
|------|-------|-------------|----------------|
| Local Variables | Current shell | Valid only in the current shell | `set` |
| Environment Variables | Current shell and child processes | Available to the current shell and all its child processes | `printenv` or `env` |
| Shell Variables | Current shell | Special variables maintained by the shell itself | `set` |

### Variable Naming Rules

* Variable names can contain letters (a-z, A-Z), numbers (0-9), and underscores (_)
* Variable names cannot start with a number
* No spaces are allowed around the = sign when assigning a value to a variable
* Variable names are case-sensitive

### Creating Variables

```bash
# Local variable
VARNAME="value"

# Environment variable
export VARNAME="value"
```

### Accessing Variables

```bash
echo $VARNAME
echo ${VARNAME}
```

## Shell Expansions

Shell expansions are mechanisms that transform and expand expressions in the shell. These expansions provide powerful ways to manipulate data within shell scripts.

### Types of Expansions

1. **Brace Expansion**: Generates strings by creating combinations of lists.
   ```bash
   echo {a,b,c}d # outputs: ad bd cd
   echo {1..5}   # outputs: 1 2 3 4 5
   ```

2. **Tilde Expansion**: Expands to the home directory.
   ```bash
   echo ~       # outputs: /home/current_user
   echo ~user   # outputs: /home/user
   ```

3. **Parameter Expansion**: Retrieves the value of a variable.
   ```bash
   echo $PATH
   echo ${PATH}
   echo ${#PATH}  # Length of PATH
   ```

4. **Command Substitution**: Executes a command and substitutes its output.
   ```bash
   echo $(date)
   echo `date`   # Old-style syntax, less readable
   ```

5. **Arithmetic Expansion**: Evaluates arithmetic expressions.
   ```bash
   echo $((5 + 3))
   echo $((2**3))
   ```

6. **Process Substitution**: Provides output of a command as a temporary file.
   ```bash
   diff <(ls dir1) <(ls dir2)
   ```

7. **Word Splitting**: Splits the results of expansions into separate words.

8. **Filename Expansion (Globbing)**: Expands patterns into matching filenames.
   ```bash
   echo *.txt
   echo [a-c]*.txt
   ```

## Arithmetic Operations

Bash provides several ways to perform arithmetic operations:

### Using Arithmetic Expansion

```bash
# Addition
echo $((5 + 3))

# Subtraction
echo $((10 - 5))

# Multiplication
echo $((4 * 6))

# Division (integer)
echo $((20 / 3))

# Modulus (remainder)
echo $((20 % 3))

# Exponentiation
echo $((3 ** 4))
```

### Using let Command

```bash
let result=5+3
echo $result
```

### Using expr Command

```bash
result=$(expr 5 + 3)
echo $result
```

## Number Base Conversion

Bash supports conversion between different number bases:

### Binary to Decimal

```bash
echo $((2#101011))  # Outputs: 43
```

### Decimal to Binary

```bash
echo "obase=2;43" | bc
```

### Decimal to Hexadecimal

```bash
echo "obase=16;255" | bc  # Outputs: FF
# or
printf "%x\n" 255        # Outputs: ff
```

### Hexadecimal to Decimal

```bash
echo $((16#FF))  # Outputs: 255
```

## Shell Aliases

Aliases are shortcuts for commands or command sequences. They make it easier to remember and type frequently used commands.

### Creating Aliases

```bash
# Temporary alias (exists only in current session)
alias ll="ls -la"

# Permanent alias (add to ~/.bashrc)
echo 'alias ll="ls -la"' >> ~/.bashrc
```

### Listing Aliases

```bash
alias
```

### Removing Aliases

```bash
unalias ll
```

## Resources

* [Bash Guide - Variables](https://mywiki.wooledge.org/BashGuide/Parameters)
* [Bash Reference Manual - Shell Expansions](https://www.gnu.org/software/bash/manual/html_node/Shell-Expansions.html)
* [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/)
* [ShellCheck](https://www.shellcheck.net/)
* [Bash Hackers Wiki](https://wiki.bash-hackers.org/)

---

*Project by ALX System Engineering & DevOps*

