# Shell Permissions

<p align="center">
  <img src="https://img.shields.io/badge/Shell-Permissions-green.svg" alt="Shell Permissions">
  <img src="https://img.shields.io/badge/Unix-Linux-blue.svg" alt="Unix/Linux">
  <img src="https://img.shields.io/badge/File-Security-orange.svg" alt="File Security">
  <img src="https://img.shields.io/badge/Access-Control-yellow.svg" alt="Access Control">
</p>

## Project Overview

This repository provides an introduction to shell permissions in Unix-like operating systems. It focuses on understanding and managing file permissions, changing ownership, setting special permissions, and implementing proper access control mechanisms through shell commands. These skills are fundamental for system security and proper file management in Linux environments.

## Learning Objectives

By the end of this project, you should be able to explain:

* How file permissions work in Unix/Linux systems
* How to represent and modify permissions with symbolic and numeric notations
* How to change file and directory ownership and group associations
* How to implement special permissions like setuid, setgid, and sticky bit
* How to use commands like `chmod`, `chown`, `chgrp`, `su`, `whoami`, and `groups`
* How to apply security best practices for file access control

## Requirements

* Ubuntu 20.04 LTS
* All scripts must pass Shellcheck verification
* The first line of all Bash scripts should be `#!/bin/bash`
* All files must be executable (`chmod +x filename`)
* No use of backticks, &&, || or ; in scripts
* All scripts must be exactly two lines long (the shebang and one command)

## Project Tasks

### User and Group Identity

#### 0. Change User
**[0-iam_betty](0-iam_betty)**

Write a script that switches the current user to the user `betty`.
```bash
#!/bin/bash
su betty
```

#### 1. Who Am I
**[1-who_am_i](1-who_am_i)**

Write a script that prints the effective username of the current user.

#### 2. Groups
**[2-groups](2-groups)**

Write a script that prints all the groups the current user is part of.

### Ownership Management

#### 3. New Owner
**[3-new_owner](3-new_owner)**

Write a script that changes the owner of the file `hello` to the user `betty`.

#### 13. Change Group
**[13-change_group](13-change_group)**

Write a script that changes the group owner of the file `hello` to `school`.

#### 14. Owner and Group
**[100-change_owner_and_group](100-change_owner_and_group)**

Write a script that changes the owner to `vincent` and the group owner to `staff` for all the files and directories in the working directory.

#### 15. Symbolic Links
**[101-symbolic_link_permissions](101-symbolic_link_permissions)**

Write a script that changes the owner and the group owner of `_hello` to `vincent` and `staff` respectively, where `_hello` is a symbolic link.

#### 16. If Only
**[102-if_only](102-if_only)**

Write a script that changes the owner of the file `hello` to `betty` only if it is owned by the user `guillaume`.

### File Permission Management

#### 4. Empty File
**[4-empty](4-empty)**

Write a script that creates an empty file called `hello`.

#### 5. Execute
**[5-execute](5-execute)**

Write a script that adds execute permission to the owner of the file `hello`.

#### 6. Multiple Permissions
**[6-multiple_permissions](6-multiple_permissions)**

Write a script that adds execute permission to the owner and the group owner, and read permission to other users, to the file `hello`.

#### 7. Everybody
**[7-everybody](7-everybody)**

Write a script that adds execution permission to the owner, the group owner and the other users, to the file `hello`.

#### 8. James Bond
**[8-James_Bond](8-James_Bond)**

Write a script that sets the permission to the file `hello` as follows:
- Owner: no permission at all
- Group: no permission at all
- Other users: all the permissions
(007 permissions)

#### 9. John Doe
**[9-John_Doe](9-John_Doe)**

Write a script that sets the mode of the file `hello` to `-rwxr-x-wx`.

#### 10. Mirror Permissions
**[10-mirror_permissions](10-mirror_permissions)**

Write a script that sets the mode of the file `hello` the same as `olleh`'s mode.

#### 11. Directories
**[11-directories_permissions](11-directories_permissions)**

Create a script that adds execute permission to all subdirectories of the current directory for the owner, the group owner and all other users. Regular files should not be changed.

#### 12. More Directories
**[12-directory_permissions](12-directory_permissions)**

Create a script that creates a directory called `my_dir` with permissions 751 in the working directory.

### Bonus

#### 17. Star Wars
**[103-Star_Wars](103-Star_Wars)**

Write a script that will play the StarWars IV episode in the terminal.

## Permissions Modes

Unix-like systems define three types of permissions for files and directories: read (`r`), write (`w`), and execute (`x`). These permissions are assigned to three different entities: the owner of the file, the group associated with the file, and others (everyone else).

Permission modes are represented by a combination of letters or numeric values:

- **Letters**: The letters `r`, `w`, and `x` represent read, write, and execute permissions, respectively. They can be combined to form a permission mode like `rwx`, `rw-`, `r-x`, etc.

- **Numeric values**: Numeric values can also be used to represent permission modes. Each permission is assigned a value: read (`4`), write (`2`), and execute (`1`). These values can be added together to form the permission mode. For example, `rwx` is `7` (`4 + 2 + 1`), `rw-` is `6` (`4 + 2`), and `r--` is `4`.

## Changing Permissions

You can change permissions using the `chmod` command in the shell. The `chmod` command allows you to modify permissions for the owner, group, and others.

For example, to give read and write permissions to the owner, and read-only permissions to the group and others, you can use:

```
chmod 644 myfile.txt
```

In this example, `6` represents read and write permissions for the owner, while `4` represents read-only permissions for the group and others.

## Viewing Permissions

To view the permissions of a file or directory, you can use the `ls` command with the `-l` option:

```
ls -l myfile.txt
```

The output will display the permissions along with other information such as the owner, group, file size, and modification time.

## Special Permissions

In addition to the basic read, write, and execute permissions, Unix-like systems also have special permissions, such as the setuid (`suid`), setgid (`sgid`), and sticky bit (`t`).

- **setuid (`suid`)**: When set on an executable file, the file is executed with the permissions of the file owner, rather than the permissions of the user executing the file.

- **setgid (`sgid`)**: When set on an executable file or directory, the file or directory is executed or accessed with the permissions of the group associated with the file, rather than the group of the user executing the file or accessing the directory.

- **sticky bit (`t`)**: When set on a directory, only the owner of a file within that directory can delete or rename the file, regardless of the write permissions of other users.

## Common Permission Commands

| Command | Description | Example |
|---------|-------------|---------|
| `chmod`   | Change file permissions | `chmod 755 file.txt` |
| `chown`    | Change file owner | `chown user:group file.txt` |
| `chgrp`    | Change file group | `chgrp newgroup file.txt` |
| `umask`  | Set default permissions | `umask 022` |
| `ls -l`  | List file permissions | `ls -la directory` |

## Symbolic vs. Numeric Permission Notation

### Symbolic Notation

| Symbol | Meaning |
|--------|---------|
| `u`    | User (owner) |
| `g`    | Group |
| `o`    | Others |
| `a`    | All (user, group, others) |
| `+`    | Add permission |
| `-`    | Remove permission |
| `=`    | Set exact permission |

Example: `chmod u+x,g+r,o-w file.txt`

### Numeric Notation

| Number | Permission | Description |
|--------|------------|-------------|
| `0`    | `---`      | No permissions |
| `1`    | `--x`      | Execute only |
| `2`    | `-w-`      | Write only |
| `3`    | `-wx`      | Write and execute |
| `4`    | `r--`      | Read only |
| `5`    | `r-x`      | Read and execute |
| `6`    | `rw-`      | Read and write |
| `7`    | `rwx`      | Read, write, and execute |

Example: `chmod 754 file.txt`

## Resources

* [Linux File Permissions Explained](https://www.linux.com/training-tutorials/understanding-linux-file-permissions/)
* [Chmod Calculator](https://chmod-calculator.com/)
* [ShellCheck](https://www.shellcheck.net/)
* [Linux Documentation Project: Permissions](https://tldp.org/LDP/intro-linux/html/sect_03_04.html)
* [User and Group Management](https://www.linux.com/training-tutorials/linux-101-user-account-management/)

---

*Project by ALX System Engineering & DevOps*
