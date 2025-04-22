# Web Stack Debugging #4

<p align="center">
  <img src="https://img.shields.io/badge/Puppet-Infrastructure%20as%20Code-orange.svg" alt="Puppet Infrastructure as Code">
  <img src="https://img.shields.io/badge/Nginx-Performance%20Tuning-green.svg" alt="Nginx Performance Tuning">
  <img src="https://img.shields.io/badge/System-Limits%20Configuration-blue.svg" alt="System Limits Configuration">
  <img src="https://img.shields.io/badge/DevOps-Debugging-red.svg" alt="DevOps Debugging">
</p>

## Project Overview

This project is the fourth installment in the Web Stack Debugging series, focusing on identifying and fixing performance bottlenecks in our web infrastructure. Using Puppet as our infrastructure as code tool, we address issues related to:

* Nginx server request handling capacity
* System-level file descriptor limits
* Performance optimization under high load
* Automated remediation through configuration management

In this module, we practice debugging skills to identify the root cause of performance issues, then implement permanent fixes using Puppet manifests to ensure our web stack can handle high traffic loads efficiently.

## Learning Objectives

By the end of this project, you should be able to:

* Diagnose performance bottlenecks in a web stack
* Use benchmarking tools to identify server limitations
* Modify system and application configuration to improve performance
* Implement automated fixes using Puppet infrastructure as code
* Understand the relationship between resource limits and server performance
* Apply systematic debugging approaches to complex web infrastructures
* Configure OS-level user limits for optimized performance
* Optimize Nginx for high-concurrency scenarios

## Requirements

* Ubuntu 14.04 LTS
* Puppet 3.4
* puppet-lint 2.1.1
* All Puppet manifests must pass puppet-lint without any errors
* All Puppet manifests must run without error
* All Puppet manifests must have documented comments

## Project Tasks

### 0. Sky is the limit, let's bring that limit higher
**[0-the_sky_is_the_limit_not.pp](0-the_sky_is_the_limit_not.pp)**

In this task, we address an issue with our Nginx installation that's causing failed requests under load:

* Problem: When benchmarking our Nginx server using ApacheBench, we observed failed requests
* Root cause: Default Nginx worker connection limits are too restrictive
* Solution: Increase the ULIMIT in Nginx configuration from 15 to 4096
* Verification: After implementing our fix, ApacheBench should report zero failed requests

```puppet
# Increases the ULIMIT of the default file for Nginx to handle more connections
exec { 'change nginx limit':
    command  => 'sudo sed -i "s/15/4096/g" /etc/default/nginx; sudo service nginx restart',
    provider => shell,
}
```

### 1. User limit
**[1-user_limit.pp](1-user_limit.pp)**

In this task, we fix OS-level file descriptor limits that are preventing the holberton user from working properly:

* Problem: The holberton user can't log in properly due to too many open files
* Root cause: OS-level file descriptor limits (nofile) are too restrictive
* Solution: Increase both soft and hard limits in /etc/security/limits.conf
* Verification: The holberton user should be able to log in without "Too many open files" errors

```puppet
# Increases OS file limits for the holberton user
exec { 'change soft limit':
    command  => 'sudo sed -i "s/holberton\ssoft.*/holberton\tsoft\tnofile\t10000/" /etc/security/limits.conf',
    provider => shell,
}

exec { 'change hard limit':
    command  => 'sudo sed -i "s/holberton\shard.*/holberton\thard\tnofile\t100000/" /etc/security/limits.conf',
    provider => shell,
}
```

## Web Stack Debugging Series

This project is part of a larger series on web stack debugging, where we practice the art of finding and fixing issues in web infrastructures. Each debugging project presents unique challenges that require systematic investigation and creative problem-solving.

### Debugging Methodology

1. **Identify the Problem**: Use monitoring and benchmarking tools to pinpoint performance issues
2. **Understand the Expected Behavior**: Define what "working correctly" means in the context
3. **Isolate the Issue**: Determine exactly which component is causing the problem
4. **Research Potential Causes**: Look for known issues, configurations, and limitations
5. **Implement a Fix**: Create a solution that addresses the root cause
6. **Verify the Solution**: Ensure the fix resolves the issue without creating new problems
7. **Automate the Fix**: Implement the solution using infrastructure as code (Puppet)
8. **Document the Process**: Record what was learned for future reference

## Concepts

* **Infrastructure as Code**: Using Puppet to automate configuration changes
* **System Resource Limits**: Understanding and configuring OS-level resource limits
* **Web Server Performance Tuning**: Optimizing Nginx for high concurrent loads
* **Benchmarking**: Using tools like ApacheBench to measure server performance
* **User Limits**: Managing per-user resource constraints in Linux systems

## Resources

* [Web Stack Debugging](https://intranet.alxswe.com/concepts/68)
* [Puppet Lint Documentation](http://puppet-lint.com/)
* [Nginx Documentation](https://nginx.org/en/docs/)
* [Linux User Limits](https://www.kernel.org/doc/Documentation/sysctl/fs.txt)
* [ApacheBench (ab) Documentation](https://httpd.apache.org/docs/2.4/programs/ab.html)
* [Debugging Techniques for DevOps Engineers](https://www.oreilly.com/library/view/effective-devops/9781491926291/)

---

*Project by ALX System Engineering & DevOps*
