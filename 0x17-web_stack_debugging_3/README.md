# Web Stack Debugging #3

<p align="center">
  <img src="https://img.shields.io/badge/Debugging-WordPress-blue.svg" alt="Debugging WordPress">
  <img src="https://img.shields.io/badge/Puppet-Automation-orange.svg" alt="Puppet Automation">
  <img src="https://img.shields.io/badge/Strace-Diagnostics-green.svg" alt="Strace Diagnostics">
  <img src="https://img.shields.io/badge/Apache-Webserver-red.svg" alt="Apache Webserver">
</p>

## Project Overview

This project focuses on debugging a WordPress website running on a LAMP stack (Linux, Apache, MySQL, and PHP). By using `strace`, a diagnostic and debugging tool for Linux, we identify and fix an issue causing the Apache web server to return 500 errors. The solution is then automated using Puppet configuration management to ensure repeatable and consistent fixes across environments.

## Learning Objectives

By the end of this project, you should be able to explain:

* How to use strace to track system calls made by processes
* How to diagnose and troubleshoot web server 500 errors
* How to identify configuration issues in WordPress installations
* How to create Puppet manifests to automate fixes
* How to debug PHP applications in a LAMP environment
* How to use system call analysis for troubleshooting
* Best practices for web application debugging
* How to implement configuration management automation

## Requirements

* All files will be interpreted on Ubuntu 14.04 LTS
* All Puppet files must end with the extension .pp
* Puppet manifests must pass puppet-lint version 2.1.1 without any errors
* Puppet manifests must run without error
* Puppet manifests first line must be a comment explaining what the Puppet manifest is about
* Puppet manifests files must end with a new line
* Files will be checked with Puppet v3.4

## Project Tasks

### 0. Strace is your friend
**[0-strace_is_your_friend.pp](0-strace_is_your_friend.pp)**

Using strace, find out why Apache is returning a 500 error, then create a Puppet manifest that fixes the issue automatically.

For this task, we'll:
1. Use strace to attach to Apache processes and monitor their system calls
2. Identify failure patterns in file operations
3. Find the misconfigured file causing the 500 error
4. Create a Puppet manifest to fix the issue by replacing incorrect text

Example solution:
```puppet
# Puppet manifest to fix 'phpp' typo in WordPress settings
exec { 'fix-wordpress':
  command => 'sed -i s/phpp/php/g /var/www/html/wp-settings.php',
  path    => '/usr/local/bin/:/bin/'
}
```

## Using Strace for Debugging

### What is Strace?

Strace is a diagnostic, debugging and instructional userspace utility for Linux. It is used to monitor and tamper with interactions between processes and the Linux kernel, which include system calls, signal deliveries, and changes of process state.

### Common Strace Commands

```bash
# Trace system calls for a specific process
strace -p <pid>

# Trace a command from the start
strace <command>

# Trace specific system calls
strace -e open,read,write <command>

# Follow child processes
strace -f <command>

# Trace with timestamps
strace -t <command>

# Output to a file
strace -o output.txt <command>

# Show string length in full
strace -s 1024 <command>
```

### Strace Output Analysis

When analyzing strace output, look for:

1. **Failed System Calls**: Look for calls that return errors (indicated by -1)
2. **Missing Files**: Watch for attempts to access non-existent files
3. **Permission Problems**: Check for EACCES (Permission denied) errors
4. **Configuration Issues**: Look for config files being read and any errors
5. **Resource Limitations**: Watch for resource exhaustion errors

Example strace output showing a failed file operation:
```
open("/var/www/html/wp-includes/class-wp-locale.phpp", O_RDONLY) = -1 ENOENT (No such file or directory)
```

This shows the application is trying to open a file with a typo in the extension (.phpp instead of .php).

## WordPress Debugging

WordPress has built-in debugging features that can help identify issues:

1. **Enable WP_DEBUG**: Set `WP_DEBUG` to true in wp-config.php
2. **Check Error Logs**: Review the Apache error logs
3. **WordPress Debug Log**: Enable `WP_DEBUG_LOG` to log errors to a file
4. **Check Permissions**: Ensure correct file permissions
5. **Plugin Conflicts**: Temporarily disable plugins to isolate issues

Common WordPress 500 errors are caused by:
- PHP syntax errors
- Exhausted PHP memory limit
- Corrupted .htaccess file
- Plugin or theme incompatibilities
- File permission issues
- PHP version incompatibilities

## Puppet for Configuration Management

Puppet is a configuration management tool that allows you to automate the deployment and management of configurations. For web server debugging, Puppet can:

1. **Ensure Consistency**: Deploy the same fix across multiple servers
2. **Prevent Regressions**: Catch and fix configuration drift
3. **Document Changes**: Keep a record of configuration changes
4. **Automate Repairs**: Fix known issues automatically

### Key Puppet Concepts

1. **Resources**: Basic units of configuration (files, packages, services)
2. **Manifests**: Files containing Puppet code (.pp extension)
3. **Classes**: Groups of related resources
4. **Modules**: Collections of manifests, templates, and files
5. **Facts**: System information Puppet can use to make decisions

### Common Puppet Resource Types

```puppet
# File resource
file { '/path/to/file':
  ensure  => present,
  content => 'file content',
  mode    => '0644',
}

# Package resource
package { 'apache2':
  ensure => installed,
}

# Service resource
service { 'apache2':
  ensure => running,
  enable => true,
}

# Exec resource (for running commands)
exec { 'fix-config':
  command => '/bin/command arg1 arg2',
  path    => '/usr/bin:/bin',
  onlyif  => '/bin/test -condition',
}
```

## Systematic Debugging Approach

When debugging web server issues, follow this systematic approach:

1. **Identify the Problem**: Determine what's failing (e.g., 500 error)
2. **Check Logs First**: Apache/Nginx error logs often contain valuable information
3. **Reproduce the Issue**: Make sure you can consistently recreate the problem
4. **Use Diagnostic Tools**: Apply strace, lsof, netstat, etc.
5. **Isolate Components**: Check each component of the stack separately
6. **Make One Change at a Time**: Change only one thing before testing again
7. **Document Everything**: Keep track of what you've checked and changed
8. **Automate the Fix**: Use configuration management to implement the solution

## Resources

* [Web stack debugging guide](https://intranet.alxswe.com/concepts/68)
* [Strace documentation](https://man7.org/linux/man-pages/man1/strace.1.html)
* [Puppet documentation](https://puppet.com/docs/puppet/5.5/puppet_index.html)
* [LAMP stack overview](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-14-04)
* [WordPress debugging](https://wordpress.org/support/article/debugging-in-wordpress/)
* [Apache error troubleshooting](https://httpd.apache.org/docs/2.4/troubleshooting.html)
* [System Call Tracing Techniques](https://www.brendangregg.com/blog/2014-05-11/strace-wow-much-syscall.html)
* [Puppet Best Practices](https://puppet.com/docs/puppet/latest/style_guide.html)

---

*Project by ALX System Engineering & DevOps*
