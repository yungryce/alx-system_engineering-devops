# 0x12. Web stack debugging #2

<p align="center">
  <img src="https://img.shields.io/badge/Security-Practices-green.svg" alt="Security Practices">
  <img src="https://img.shields.io/badge/Nginx-Configuration-blue.svg" alt="Nginx Configuration">
  <img src="https://img.shields.io/badge/Privilege-De--escalation-orange.svg" alt="Privilege De-escalation">
  <img src="https://img.shields.io/badge/Server-Hardening-red.svg" alt="Server Hardening">
</p>

## Project Overview

This repository focuses on server security through the principle of least privilege, specifically configuring Nginx to run as a non-root user. Running web servers and other services as non-root users is a critical security best practice that limits potential damage from security breaches and exploits.

## Background Context

The concept of running processes with the least amount of privileges necessary is a fundamental security principle. When web servers run as root, they present a significant security risk - if compromised, an attacker gains root access to the entire system.

In this project, you'll configure Nginx to run as a less privileged user (`nginx`) instead of root. This demonstrates how to improve security while maintaining functionality.

## Requirements

* Ubuntu 20.04 LTS
* All Bash scripts must be executable
* Bash scripts must pass Shellcheck without any errors
* The first line of all Bash scripts should be `#!/usr/bin/env bash`
* The second line of all Bash scripts should be a comment explaining what the script does
* All files should have the correct permissions
* The optimized solution must be 7 lines or less

## Project Tasks

### 0. Run software as another user
**[1-run_nginx_as_nginx](1-run_nginx_as_nginx)**

Requirements:
- Configure Nginx to run as the `nginx` user instead of root
- Nginx must be listening on all active IPs on port 8080
- You cannot use `apt-get remove`
- Write a Bash script that configures the container to meet these requirements

```bash
#!/usr/bin/env bash
# Fixes the issue with the server
chmod 644 /etc/nginx/nginx.conf
sed -Ei 's/\s*#?\s*user .*/user nginx;/' /etc/nginx/nginx.conf
sed -Ei 's/(listen (\[::\]:)?80) /\180 /' /etc/nginx/sites-enabled/default
pkill apache2
su nginx -s /bin/bash -c 'service nginx restart'
```

### 1. 7 lines or less
**[100-fix_in_7_lines_or_less](100-fix_in_7_lines_or_less)**

Requirements:
- Using the solution from task #0, make your fix short and sweet
- Your Bash script must be 7 lines long or less
- There must be a new line at the end of the file
- You must respect Shellcheck
- You must use the same requirements as task #0

```bash
#!/usr/bin/env bash
# Fixes the issue with the server
chmod 644 /etc/nginx/nginx.conf
sed -Ei 's/\s*#?\s*user .*/user nginx;/' /etc/nginx/nginx.conf
sed -Ei 's/(listen (\[::\]:)?80) /\180 /' /etc/nginx/sites-enabled/default
pkill apache2
su nginx -s /bin/bash -c 'service nginx restart'
```

## Security Principles

### The Principle of Least Privilege

The Principle of Least Privilege (PoLP) is a computer security concept that limits users' access rights to only what is strictly required to do their jobs. Applied to processes and services, it means running them with the minimum permissions needed to function properly.

Benefits of applying PoLP to web servers:
- Reduces the attack surface
- Limits the potential damage from a compromised service
- Prevents unauthorized access to system resources
- Minimizes the risk of malware spreading

### Why Not Run as Root?

Running services as root creates several security risks:

1. **Full System Access**: A compromised service has unlimited access to the entire system
2. **No Permission Boundaries**: Root can bypass all permission checks
3. **Privilege Escalation**: Attackers can leverage root access to install backdoors and other malware
4. **Configuration Mistakes**: Even minor misconfigurations can have catastrophic consequences
5. **Accidental Damage**: Administrative errors can impact the entire system

## Understanding the Solution

### Step-by-Step Explanation

1. **Set Proper File Permissions**:
   ```bash
   chmod 644 /etc/nginx/nginx.conf
   ```
   This ensures the configuration file is readable by all users but only writable by the owner.

2. **Modify Nginx User Configuration**:
   ```bash
   sed -Ei 's/\s*#?\s*user .*/user nginx;/' /etc/nginx/nginx.conf
   ```
   This uses `sed` to replace the user directive in the configuration file, ensuring Nginx runs as the `nginx` user instead of root.

3. **Change the Port Configuration**:
   ```bash
   sed -Ei 's/(listen (\[::\]:)?80) /\180 /' /etc/nginx/sites-enabled/default
   ```
   This modifies the port from 80 to 8080 in the Nginx site configuration.

4. **Stop Conflicting Services**:
   ```bash
   pkill apache2
   ```
   This terminates Apache, which might be using the required ports.

5. **Restart Nginx as the Non-Root User**:
   ```bash
   su nginx -s /bin/bash -c 'service nginx restart'
   ```
   This starts Nginx as the `nginx` user, applying all the configuration changes.

### Challenges When Running as Non-Root

When configuring servers to run as non-root users, you may encounter these challenges:

1. **Port Binding Restrictions**: Non-root users can't bind to ports below 1024 without special permissions
2. **File Permission Issues**: The service user needs appropriate permissions to access configuration and content files
3. **Log File Access**: The service needs write permissions to its log files
4. **Service Start/Stop Privileges**: Init scripts typically require root privileges
5. **Process Ownership Transfer**: Changing from root to a non-root user requires careful handling

## Nginx User Configuration

### Default Configuration

By default, Nginx starts its master process as root, which then spawns worker processes as a less-privileged user (often `www-data` or `nginx`). The master process needs root privileges to:
- Bind to low-numbered ports (80, 443)
- Read SSL private keys
- Open log files

### Secure Configuration Best Practices

1. **Use the Dedicated User**:
   ```nginx
   user nginx;
   ```

2. **Set Appropriate Worker Processes**:
   ```nginx
   worker_processes auto;
   ```

3. **Restrict Access to Configuration**:
   ```bash
   chmod 644 /etc/nginx/nginx.conf
   chown root:root /etc/nginx/nginx.conf
   ```

4. **Handle Log Files Properly**:
   ```bash
   chown nginx:nginx /var/log/nginx
   chmod 750 /var/log/nginx
   ```

5. **Set Proper Permissions for Web Content**:
   ```bash
   chown -R nginx:nginx /var/www/html
   chmod -R 750 /var/www/html
   ```

## Linux User Management Essentials

### Understanding User Permissions

In Linux, each file and process has an owner and a group. Permissions are defined for:
- Owner (user)
- Group
- Others (everyone else)

Each category can have these permissions:
- Read (r)
- Write (w)
- Execute (x)

### Common Permission Management Commands

```bash
# View file permissions
ls -la

# Change file owner
chown user:group file

# Change file permissions
chmod [mode] file

# Common permission modes
chmod 644 file  # rw-r--r-- (readable by all, writable by owner)
chmod 755 file  # rwxr-xr-x (executable file or directory)
chmod 600 file  # rw------- (private file, like a key)
chmod 770 dir   # rwxrwx--- (collaborative directory)
```

### Process Management Commands

```bash
# List all processes
ps aux

# Find specific processes
ps aux | grep nginx

# Show process tree
pstree

# Kill a process
kill [pid]
pkill [name]

# Change user context
su - username
```

## Resources

* [How to run Nginx as a non-root user](https://www.nginx.com/resources/wiki/start/topics/tutorials/debugging/)
* [Principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege)
* [Linux permissions explained](https://www.linux.com/training-tutorials/understanding-linux-file-permissions/)
* [How to manage and understand Linux processes](https://www.digitalocean.com/community/tutorials/how-to-use-ps-kill-and-nice-to-manage-processes-in-linux)
* [The sed command in Linux](https://www.gnu.org/software/sed/manual/sed.html)
* [Security best practices for Nginx](https://www.nginx.com/blog/security-hardening-nginx/)
* [Managing services in Linux](https://www.digitalocean.com/community/tutorials/how-to-configure-a-linux-service-to-start-automatically-after-a-crash-or-reboot-part-1-practical-examples)

---

*Project by ALX System Engineering & DevOps*
