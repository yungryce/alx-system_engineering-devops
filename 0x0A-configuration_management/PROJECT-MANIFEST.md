# Project Manifest: Configuration Management

## Project Identity
- **Name**: Configuration Management
- **Type**: Educational/DevOps
- **Scope**: Server Automation and Infrastructure as Code
- **Status**: Completed

## Technology Signature
- **Core**: Puppet
- **Environment**: Ubuntu 20.04 LTS
- **Verification Tools**: puppet-lint 2.5.0
- **Style Guide**: Puppet Style Guide

## Demonstrated Competencies
- Infrastructure as Code Implementation
- Puppet Manifest Creation
- Package Management Automation
- File System Configuration
- Process Management via Configuration
- Idempotent System Administration
- DevOps Automation Principles
- Server Provisioning

## System Context
This component introduces automation of infrastructure through configuration management, laying groundwork for scalable, repeatable system administration. It serves as a bridge between manual system administration and fully automated DevOps practices.

## Development Requirements
- Ubuntu 20.04 LTS
- Puppet 5.5.x
- puppet-lint 2.5.0
- Ruby environment for Puppet
- Text editor (vi/vim/emacs)
- Git for version control

## Development Workflow
1. Define desired system state
2. Create Puppet manifests to implement state
3. Validate manifests with puppet-lint
4. Apply manifests to test systems
5. Verify system reaches desired state
6. Submit for automated and peer review

## Maintenance Notes
- All Puppet manifests include proper headers
- Code follows Puppet style guidelines
- Manifests are idempotent (can be run repeatedly)
- Resources have proper dependencies
- Manifests handle edge cases appropriately
- All code passes puppet-lint validation

## Implementation Specifics

### File Management
- **Create a File**: [0-create_a_file.pp](./0-create_a_file.pp)
  - Creates `/tmp/school` file with specific permissions
  - Sets ownership to www-data
  - Contains required content

### Package Management
- **Install a Package**: [1-install_a_package.pp](./1-install_a_package.pp)
  - Installs Flask 2.1.0 using pip3
  - Demonstrates package resource management

### Process Management
- **Execute a Command**: [2-execute_a_command.pp](./2-execute_a_command.pp)
  - Uses exec resource to kill a specific process
  - Demonstrates command execution in Puppet

## Infrastructure as Code Principles Applied
- **Declarative Definition**: System state is defined, not steps to achieve it
- **Version Control**: Configuration stored in code repository
- **Reusability**: Patterns can be reused across systems
- **Testing**: Code can be validated before application
- **Documentation**: Code serves as documentation of system state
- **Consistency**: Ensures consistent environment configuration