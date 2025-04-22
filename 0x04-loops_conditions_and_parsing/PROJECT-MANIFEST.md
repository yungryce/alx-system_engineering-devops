# Project Manifest: Loops, Conditions and Parsing

## Project Identity
- **Name**: Loops, Conditions and Parsing
- **Type**: Educational
- **Scope**: Advanced Shell Scripting Techniques
- **Status**: Completed

## Technology Signature
- **Core**: Bash Shell
- **Environment**: Unix/Linux
- **Verification Tools**: ShellCheck
- **Style Guide**: Shell Script Standards
- **Authentication**: SSH Keys

## Demonstrated Competencies
- SSH Key Generation and Management
- Bash Loop Implementation (for, while, until)
- Conditional Statement Execution
- File Testing and Validation
- String Comparison and Manipulation
- Case Statement Application
- File Content Parsing and Processing
- Command Line Argument Handling
- Process Monitoring and Management
- Apache Log Analysis
- AWK Command Usage

## System Context
This component builds upon basic shell scripting knowledge to introduce advanced control structures, enabling the creation of more sophisticated and automated scripts for system administration tasks, file processing, and data extraction from logs and other textual data sources.

## Development Requirements
- Linux/Unix-based Operating System
- Bash Shell
- Text Editor (vi/vim/emacs)
- SSH Key Generation Tools
- ShellCheck for Script Verification
- Apache Log Files for Advanced Parsing Tasks

## Development Workflow
1. Create SSH key pairs for secure authentication
2. Read project specifications and requirements
3. Design script logic using appropriate control structures
4. Implement solutions as Bash scripts
5. Make scripts executable (chmod +x)
6. Test scripts in a Linux environment
7. Validate with ShellCheck
8. Submit for automated and peer review

## Maintenance Notes
- All scripts use the shebang line (#!/usr/bin/env bash)
- Each script includes a comment describing its functionality
- Scripts have proper execution permissions
- Commands follow standard shell syntax and conventions
- Scripts are optimized for readability and maintainability
- All scripts are verified with ShellCheck for best practices

## Implementation Specifics

### SSH Key Management
- **SSH Public Key**: [0-RSA_public_key.pub](./0-RSA_public_key.pub)

### Loop Implementation
- **For Loop with List**: [1-for_best_school](./1-for_best_school)
- **While Loop**: [2-while_best_school](./2-while_best_school)
- **Until Loop**: [3-until_best_school](./3-until_best_school)
- **While with If Statement**: [4-if_9_say_hi](./4-if_9_say_hi)
- **While with If-Else**: [5-4_bad_luck_8_is_your_chance](./5-4_bad_luck_8_is_your_chance)
- **While with Case Statement**: [6-superstitious_numbers](./6-superstitious_numbers)
- **Clock Simulation**: [7-clock](./7-clock)
- **For Loop with File Content**: [8-for_ls](./8-for_ls)

### File Operations and Conditionals
- **File Existence Check**: [9-to_file_or_not_to_file](./9-to_file_or_not_to_file)
- **Numeric Comparison**: [10-fizzbuzz](./10-fizzbuzz)

### Log Parsing and Data Extraction
- **Read and Display File**: [100-read_and_cut](./100-read_and_cut)
- **Parse /etc/passwd with While Loop**: [101-tell_the_story_of_passwd](./101-tell_the_story_of_passwd)
- **Apache Log Parsing with AWK**: [102-lets_parse_apache_logs](./102-lets_parse_apache_logs)
- **Advanced Apache Log Analysis**: [103-dig_the-data](./103-dig_the-data)