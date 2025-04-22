# 0x0D. Web stack debugging #0

<p align="center">
  <img src="https://img.shields.io/badge/Apache-Web_Server-green.svg" alt="Apache Web Server">
  <img src="https://img.shields.io/badge/Docker-Container-blue.svg" alt="Docker Container">
  <img src="https://img.shields.io/badge/Debugging-Techniques-orange.svg" alt="Debugging Techniques">
  <img src="https://img.shields.io/badge/DevOps-Skills-red.svg" alt="DevOps Skills">
</p>

## Project Overview

This repository focuses on web stack debugging, specifically troubleshooting a Docker container running an Apache web server. The goal is to apply debugging skills to identify why a web server isn't responding to HTTP requests and implement a solution. This is the first in a series of web stack debugging projects that build increasingly complex debugging skills.

## Background Context

The Webstack debugging series will train you in the art of debugging. Computers and software rarely work the way we want (that's the "fun" part of the job!).

Being able to debug a webstack is essential for a Full-Stack Software Engineer, and it takes practice to be a master of it.

In this debugging series, broken/bugged webstacks will be given to you, the final goal is to come up with a Bash script that once executed, will bring the webstack to a working state. But before writing this Bash script, you should figure out what is going on and fix it manually.

Let's start with a very simple example. My server must:
- Have a copy of the `/etc/passwd` file in `/tmp`
- Have a file named `/tmp/isworking` containing the string `OK`

Let's pretend that without these 2 elements, my web application cannot work.

```
vagrant@vagrant:~$ docker run -d -ti ubuntu:14.04
Unable to find image 'ubuntu:14.04' locally
14.04: Pulling from library/ubuntu
34667c7e4631: Already exists
d18d76a881a4: Already exists
119c7358fbfc: Already exists
2aaf13f3eff0: Already exists
Digest: sha256:58d0da8bc2f434983c6ca4713b08be00ff5586eb5cdff47bcde4b2e88fd40f88
Status: Downloaded newer image for ubuntu:14.04
76f44c0da25e1fdf6bcd4fbc49f4d7b658aba89684080ea5d6e8a0d832be9ff9
vagrant@vagrant:~$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
76f44c0da25e        ubuntu:14.04        "/bin/bash"         13 seconds ago      Up 12 seconds                           infallible_bhabha
vagrant@vagrant:~$ docker exec -ti 76f44c0da25e /bin/bash
root@76f44c0da25e:/# ls /tmp/
root@76f44c0da25e:/# cp /etc/passwd /tmp/
root@76f44c0da25e:/# echo OK > /tmp/isworking
root@76f44c0da25e:/# ls /tmp/
isworking  passwd
root@76f44c0da25e:/#
```

Then my answer file would contain:
```bash
#!/usr/bin/env bash
# Fix my server with these magic 2 lines
cp /etc/passwd /tmp/
echo OK > /tmp/isworking
```

Note that as you cannot use interactive software such as `emacs` or `vi` in your Bash script, everything needs to be done from the command line (including file edition).

## Installing Docker

For this project you will be given a container which you can use to solve the task. If you would like to have Docker so that you can experiment with it and/or solve this problem locally, you can install it on your machine, your Ubuntu 14.04 VM, or your Ubuntu 16.04 VM if you upgraded.

- [Mac OS](https://docs.docker.com/desktop/install/mac-install/)
- [Windows](https://docs.docker.com/desktop/install/windows-install/)
- [Ubuntu 14.04](https://www.liquidweb.com/kb/how-to-install-docker-on-ubuntu-14-04-lts/) (Note that Docker for Ubuntu 14 is deprecated and you have to make some adjustments to the instructions when installing)
- [Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04)

## Problem Description for #0

In this first debugging project, you are given a Docker container running an Apache web server that doesn't return a page when querying the root of the server with curl.

After starting the Docker container, you need to:
1. Identify why Apache isn't serving pages
2. Fix the issue using a Bash script
3. Verify the fix by testing with curl to ensure a page is returned

## Project Tasks

### 0. Give me a page!
**[0-give_me_a_page](0-give_me_a_page)**

Requirements:
- Get Apache to run on the container
- Apache should return a page containing "Hello Holberton" when querying the root of it
- The solution should be a Bash script that configures the container

```bash
#!/usr/bin/env bash
# run apache on designated container

echo "ServerName localhost" >> /etc/apache2.conf
service apache2 start
```

## Debugging Process

### 1. Understanding the Problem

When working with a web server container that's not serving pages, consider these common issues:
- Web server process is not running
- Configuration issues preventing proper operation
- Networking or port issues
- Missing content in the webroot directory

### 2. Diagnostic Steps

#### Check if Apache is Running

```bash
service apache2 status
# or
ps aux | grep apache
```

#### Check Apache Configuration

```bash
apache2ctl configtest
# or
apachectl -t
```

#### Review Error Logs

```bash
cat /var/log/apache2/error.log
```

#### Test Network Connectivity

```bash
netstat -tuln | grep 80
# or
curl -v localhost:80
```

### 3. Common Apache Issues and Fixes

#### Configuration Problems
- **ServerName not specified**: Apache may produce warnings about not being able to determine the server's fully qualified domain name
  - Fix: Add `ServerName localhost` to `/etc/apache2.conf`

#### Process Management Issues
- **Apache not starting**: The service might fail to start due to configuration errors
  - Fix: Correct configuration errors and restart with `service apache2 start`

#### Default Content Issues
- **Missing default content**: The default index page might not exist
  - Fix: Create a minimal index.html in `/var/www/html/`

## Apache Web Server Fundamentals

### Key Components

1. **Main Configuration Files**:
   - `/etc/apache2/apache2.conf`: Main configuration file
   - `/etc/apache2/sites-available/`: Virtual host configurations
   - `/etc/apache2/sites-enabled/`: Enabled virtual hosts (symlinks)
   - `/etc/apache2/mods-available/` and `/etc/apache2/mods-enabled/`: Apache modules

2. **Log Files**:
   - `/var/log/apache2/access.log`: Records all requests to the server
   - `/var/log/apache2/error.log`: Records all server errors

3. **Content Directory**:
   - `/var/www/html/`: Default document root

### Apache Control Commands

```bash
# Start Apache
service apache2 start
# or
/etc/init.d/apache2 start

# Stop Apache
service apache2 stop

# Restart Apache
service apache2 restart

# Reload configuration without restarting
service apache2 reload

# Check configuration syntax
apache2ctl configtest
```

## Docker Debugging Commands

When debugging issues in Docker containers, these commands are particularly useful:

```bash
# List running containers
docker ps

# Get a shell in a container
docker exec -it [container_id] /bin/bash

# View container logs
docker logs [container_id]

# Inspect container details
docker inspect [container_id]

# Monitor container resource usage
docker stats [container_id]
```

## Systematic Debugging Approach

The most effective way to debug web server issues follows this pattern:

1. **Identify Symptoms**: Determine exactly what's not working (e.g., using curl)
2. **Check Process State**: Verify if the web server process is running
3. **Check Configuration**: Look for syntax errors or misconfigurations
4. **Check Logs**: Review error logs for clues
5. **Test Minimally**: Make a minimal test case to verify functionality
6. **Fix Incrementally**: Make one change at a time and test
7. **Validate Solution**: Verify the fix resolves the issue
8. **Document Solution**: Record what was fixed and how

## Resources

* [Docker concept page](https://intranet.alxswe.com/concepts/65)
* [Apache HTTP Server Documentation](https://httpd.apache.org/docs/)
* [How to debug Apache server issues](https://www.digitalocean.com/community/tutorials/how-to-troubleshoot-common-apache-errors)
* [Docker Documentation](https://docs.docker.com/)
* [Debugging the Apache Web Server](https://www.petefreitag.com/item/465.cfm)
* [Apache Configuration Tutorial](https://httpd.apache.org/docs/2.4/configuring.html)
* [Docker Debugging Techniques](https://docs.docker.com/config/daemon/troubleshoot/)

---

*Project by ALX System Engineering & DevOps*
