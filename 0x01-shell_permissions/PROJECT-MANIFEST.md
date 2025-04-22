# Project Manifest: Shell Permissions

## Project Identity
- **Name**: Shell Permissions
- **Type**: Educational
- **Scope**: File Permission and Ownership Management
- **Status**: Completed

## Technology Signature
- **Core**: Bash Shell
- **Environment**: Unix/Linux
- **Verification Tools**: ShellCheck
- **Style Guide**: Shell Script Standards

## Demonstrated Competencies
- File Permission Management
- User and Group Ownership Control
- Symbolic and Numeric Permission Modes
- Special Permission Implementation (setuid, setgid, sticky bit)
- Directory Permission Management
- User Identity and Group Identification
- Recursive Permission and Ownership Changes
- Conditional Ownership Modification

## System Context
This component builds upon Shell Basics to introduce essential file security concepts through permission management, preparing students for more complex system administration tasks that require proper access control implementation.

## Development Requirements
- Linux/Unix-based Operating System
- Bash Shell
- Text Editor (vi/vim/emacs)
- User and Group Management Utilities
- Permission Management Tools (chmod, chown)

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

### User and Group Identity
- **Switch User**: [0-iam_betty](./0-iam_betty)
- **Current User**: [1-who_am_i](./1-who_am_i)
- **Group Membership**: [2-groups](./2-groups)

### Ownership Management
- **Change Owner**: [3-new_owner](./3-new_owner)
- **Change Group**: [13-change_group](./13-change_group)
- **Change Owner and Group**: [100-change_owner_and_group](./100-change_owner_and_group)
- **Symbolic Link Ownership**: [101-symbolic_link_permissions](./101-symbolic_link_permissions)
- **Conditional Owner Change**: [102-if_only](./102-if_only)

### File Permission Management
- **Create Empty File**: [4-empty](./4-empty)
- **Add Execute Permission**: [5-execute](./5-execute)
- **Multiple Permissions**: [6-multiple_permissions](./6-multiple_permissions)
- **All User Execute**: [7-everybody](./7-everybody)
- **Other-Only Permissions**: [8-James_Bond](./8-James_Bond)
- **Custom Mode (753)**: [9-John_Doe](./9-John_Doe)
- **Mirror Permissions**: [10-mirror_permissions](./10-mirror_permissions)
- **Directory Permissions**: [11-directories_permissions](./11-directories_permissions)
- **Create with Permissions**: [12-directory_permissions](./12-directory_permissions)

### Bonus Content
- **Star Wars ASCII Animation**: [103-Star_Wars](./103-Star_Wars)