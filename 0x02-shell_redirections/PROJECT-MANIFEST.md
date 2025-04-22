# Project Manifest: Shell Redirections and Filters

## Project Identity
- **Name**: Shell Redirections and Filters
- **Type**: Educational
- **Scope**: Input/Output Redirection and Text Processing
- **Status**: Completed

## Technology Signature
- **Core**: Bash Shell
- **Environment**: Unix/Linux
- **Verification Tools**: ShellCheck
- **Style Guide**: Shell Script Standards

## Demonstrated Competencies
- Standard Input/Output/Error Stream Manipulation
- File Content Display and Manipulation
- Text Pattern Searching and Extraction
- Data Sorting and Uniqueness Filtering
- Line and Character Processing
- Regular Expression Application
- Command Output Redirection
- Command Pipeline Construction
- Complex File Finding and Processing
- Special Character Handling

## System Context
This component builds upon Shell Basics and Shell Permissions to introduce essential text processing and data manipulation techniques through I/O redirection and filter commands, preparing students for more advanced scripting that requires efficient data handling.

## Development Requirements
- Linux/Unix-based Operating System
- Bash Shell
- Text Editor (vi/vim/emacs)
- Text Processing Utilities (grep, tr, cut, etc.)
- File Content Manipulation Commands

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

### Basic Output and File Display
- **Hello World**: [0-hello_world](./0-hello_world)
- **Confused Smiley**: [1-confused_smiley](./1-confused_smiley)
- **Display File Content**: [2-hellofile](./2-hellofile)
- **Display Multiple Files**: [3-twofiles](./3-twofiles)
- **Display Last Lines**: [4-lastlines](./4-lastlines)
- **Display First Lines**: [5-firstlines](./5-firstlines)
- **Display Third Line**: [6-third_line](./6-third_line)

### File Manipulation
- **Create File with Special Characters**: [7-file](./7-file)
- **Save Current Directory State**: [8-cwd_state](./8-cwd_state)
- **Duplicate Last Line**: [9-duplicate_last_line](./9-duplicate_last_line)
- **Delete Files by Extension**: [10-no_more_js](./10-no_more_js)
- **Count Directories**: [11-directories](./11-directories)
- **Display Newest Files**: [12-newest_files](./12-newest_files)

### Text Processing
- **Find Unique Words**: [13-unique](./13-unique)
- **Find Pattern in File**: [14-findthatword](./14-findthatword)
- **Count Pattern Occurrences**: [15-countthatword](./15-countthatword)
- **Display Pattern and Context**: [16-whatsnext](./16-whatsnext)
- **Display Lines Without Pattern**: [17-hidethisword](./17-hidethisword)
- **Display Lines Starting with Letters**: [18-letteronly](./18-letteronly)
- **Character Replacement**: [19-AZ](./19-AZ)
- **Character Deletion**: [20-hiago](./20-hiago)
- **String Reversal**: [21-reverse](./21-reverse)
- **Display Users and Home Directories**: [22-users_and_homes](./22-users_and_homes)

### Advanced Text Processing
- **Find Empty Files and Directories**: [100-empty_casks](./100-empty_casks)
- **List GIF Files**: [101-gifs](./101-gifs)
- **Decode Acrostic**: [102-acrostic](./102-acrostic)
- **Parse Web Server Logs**: [103-the_biggest_fan](./103-the_biggest_fan)