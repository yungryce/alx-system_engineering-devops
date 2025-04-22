# Configuration Management

<p align="center">
  <img src="https://img.shields.io/badge/Puppet-Manifests-orange.svg" alt="Puppet Manifests">
  <img src="https://img.shields.io/badge/Infrastructure-as_Code-blue.svg" alt="Infrastructure as Code">
  <img src="https://img.shields.io/badge/Server-Automation-green.svg" alt="Server Automation">
  <img src="https://img.shields.io/badge/DevOps-Practices-red.svg" alt="DevOps Practices">
</p>

## Project Overview

This project introduces the fundamentals of configuration management using Puppet, a powerful tool for automating infrastructure. Configuration management enables consistent server provisioning, facilitates infrastructure scaling, and ensures environments are maintained in a specified state. Through a series of Puppet manifests, we apply infrastructure as code principles to manage packages, configure files, and control system processes.

## Learning Objectives

By the end of this project, you should be able to explain:

* What configuration management is and its importance in modern infrastructure
* How to use Puppet as a configuration management tool
* The concept of infrastructure as code and its benefits
* How to write idempotent code for consistent server states
* The structure and syntax of Puppet manifests
* How to manage packages, files, and services with Puppet
* How to debug configuration management code
* The role of configuration management in DevOps practices
* How to create reusable configuration components

## Requirements

* Ubuntu 20.04 LTS
* Puppet 5.5.x
* puppet-lint 2.5.0
* All Puppet manifests must pass puppet-lint validation
* All manifests must run without error
* First line of Puppet manifests: `#!/usr/bin/env puppet`
* Files must end with a newline
* Each manifest should accomplish its task in the most straightforward way

## Setup

### Installing Puppet and puppet-lint

```bash
# Install Puppet
$ apt-get install -y ruby=1:2.7+1 --allow-downgrades
$ apt-get install -y ruby-augeas
$ apt-get install -y ruby-shadow
$ apt-get install -y puppet

# Install puppet-lint
$ gem install puppet-lint -v 2.5.0
```

## Project Tasks

### 0. Create a File
**[0-create_a_file.pp](0-create_a_file.pp)**

Using Puppet, create a file in `/tmp` with specific requirements:

* File path is `/tmp/school`
* File permission is `0744`
* File owner is `www-data`
* File group is `www-data`
* File contains `I love Puppet`

### 1. Install a Package
**[1-install_a_package.pp](1-install_a_package.pp)**

Using Puppet, install Flask from pip3 with specific requirements:

* Install Flask
* Version must be 2.1.0

### 2. Execute a Command
**[2-execute_a_command.pp](2-execute_a_command.pp)**

Using Puppet, create a manifest that kills a process named `killmenow`:

* Must use the `exec` Puppet resource
* Must use `pkill` command

## Puppet Fundamentals

### Puppet Architecture

Puppet follows a client-server architecture:

* **Puppet Master**: Central server that stores configurations
* **Puppet Agent**: Runs on managed nodes and applies configurations
* **Catalog**: Compiled configuration that defines system state
* **Facts**: System information gathered by Puppet agents
* **Manifests**: Files containing configuration code (`.pp` extension)
* **Modules**: Collections of manifests and data for specific purposes

### Puppet Resource Types

| Resource Type | Description | Example |
|---------------|-------------|---------|
| `package` | Manages software packages | `package { 'nginx': ensure => installed }` |
| `file` | Manages files and directories | `file { '/etc/hosts': ensure => present, content => '127.0.0.1 localhost' }` |
| `service` | Manages services | `service { 'nginx': ensure => running, enable => true }` |
| `user` | Manages user accounts | `user { 'deploy': ensure => present, shell => '/bin/bash' }` |
| `group` | Manages groups | `group { 'developers': ensure => present }` |
| `exec` | Executes commands | `exec { 'apt-update': command => '/usr/bin/apt-get update' }` |
| `cron` | Manages cron jobs | `cron { 'backup': command => '/usr/bin/backup.sh', hour => 2 }` |

### Common Puppet Parameters

| Parameter | Description |
|-----------|-------------|
| `ensure` | Specifies if resource should exist, and in what state |
| `name` | Unique identifier for the resource |
| `provider` | Back-end mechanism used to manage the resource |
| `require` | Creates dependency on another resource |
| `before` | Creates dependent relationship with another resource |
| `notify` | Sends notification to another resource when changes occur |
| `subscribe` | Resource will respond to notifications from another resource |

### Basic Manifest Structure

```puppet
# File: example.pp

# Comment describing manifest purpose
# Resource type {'title':
#   parameter => value,
#   parameter => value,
# }

file { '/tmp/example':
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => 'Example content',
}

package { 'nginx':
  ensure => installed,
}

service { 'nginx':
  ensure => running,
  enable => true,
  require => Package['nginx'],
}
```

### Puppet Best Practices

1. **Idempotency**: Manifests should be idempotent (can run multiple times without changing the result)
2. **Resource Ordering**: Use relationships to ensure resources are applied in correct order
3. **Readability**: Use proper indentation and naming conventions
4. **Validation**: Always run `puppet-lint` before applying manifests
5. **Documentation**: Include comments to explain purpose and logic
6. **Resource Specificity**: Be explicit about resource attributes
7. **Dependency Management**: Use proper dependency declarations
8. **Modularization**: Group related resources into modules
9. **Version Control**: Keep manifests in a version control system
10. **Testing**: Test manifests in development before applying to production

## Benefits of Configuration Management

* **Consistency**: Ensures all systems are configured identically
* **Scalability**: Easily deploy configuration to new servers
* **Automation**: Reduces manual intervention and human error
* **Version Control**: Configuration changes can be tracked and rolled back
* **Documentation**: Infrastructure details are codified and documented
* **Compliance**: Helps maintain security and compliance standards
* **Efficiency**: Reduces time to deploy and configure new systems
* **Collaboration**: Enables teams to work together on infrastructure code

## Resources

* [Puppet Documentation](https://puppet.com/docs/puppet/latest/puppet_index.html)
* [Introduction to Configuration Management](https://www.digitalocean.com/community/tutorials/an-introduction-to-configuration-management)
* [Infrastructure as Code Principles](https://infrastructure-as-code.com/book/2020/03/06/what-is-infrastructure-as-code.html)
* [Puppet Resource Type Reference](https://puppet.com/docs/puppet/latest/type.html)
* [Puppet Style Guide](https://puppet.com/docs/puppet/latest/style_guide.html)

---

*Project by ALX System Engineering & DevOps*
