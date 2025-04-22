# Project Manifest: Shell Basics

## Project Identity
- **Name**: Shell Basics
- **Type**: Educational
- **Scope**: Shell Navigation and File Management
- **Status**: Completed

## Technology Signature
- **Core**: Bash Shell
- **Environment**: Unix/Linux
- **Verification Tools**: ShellCheck
- **Style Guide**: Shell Script Standards

## Demonstrated Competencies
- File System Navigation
- Directory and File Manipulation
- File Permission Management
- Basic Shell Scripting
- Command Line Interface Operations
- Symbolic Link Creation
- File Type Identification
- Directory Tree Management
- Magic File Creation

## System Context
This component serves as the foundation for all subsequent shell scripting and system administration modules, introducing essential commands and operations that will be used throughout the curriculum.

## Development Requirements
- Linux/Unix-based Operating System
- Bash Shell
- Text Editor (vi/vim/emacs)
- File Management Utilities

## Development Workflow
1. Read project specifications and requirements
2. Write solutions as shell scripts
3. Make scripts executable (chmod +x)
4. Test scripts in a Linux environment
5. Validate with ShellCheck
6. Submit for automated and peer review

## Maintenance Notes
- All scripts have proper shebang line (#!/bin/bash)
- Scripts have proper execution permissions
- Commands follow standard shell syntax and conventions
- Scripts are optimized for readability and learning purposes
- All scripts are verified with ShellCheck for best practices

## Implementation Specifics

### File System Navigation
- **Current Directory**: [0-current_working_directory](./0-current_working_directory)
- **Directory Listing**: [1-listit](./1-listit)
- **Home Directory**: [2-bring_me_home](./2-bring_me_home)
- **Previous Directory**: [10-back](./10-back)

### Directory Contents Display
- **Long Format**: [3-listfiles](./3-listfiles)
- **Hidden Files**: [4-listmorefiles](./4-listmorefiles)
- **User/Group IDs**: [5-listfilesdigitonly](./5-listfilesdigitonly)
- **Multiple Directories**: [11-lists](./11-lists)
- **Comma Separated**: [103-commas](./103-commas)

### File and Directory Management
- **Directory Creation**: [6-firstdirectory](./6-firstdirectory)
- **File Moving**: [7-movethatfile](./7-movethatfile)
- **File Deletion**: [8-firstdelete](./8-firstdelete)
- **Directory Deletion**: [9-firstdirdeletion](./9-firstdirdeletion)
- **File Type Check**: [12-file_type](./12-file_type)
- **Symbolic Link**: [13-symbolic_link](./13-symbolic_link)
- **HTML File Copying**: [14-copy_html](./14-copy_html)

### Advanced Operations
- **Uppercase Files**: [100-lets_move](./100-lets_move)
- **Emacs Backup Cleaning**: [101-clean_emacs](./101-clean_emacs)
- **Directory Tree Creation**: [102-tree](./102-tree)
- **Magic File**: [school.mgc](./school.mgc)