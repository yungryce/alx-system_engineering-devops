# 0x0E. Web stack debugging #1

<p align="center">
  <img src="https://img.shields.io/badge/Nginx-Web_Server-green.svg" alt="Nginx Web Server">
  <img src="https://img.shields.io/badge/Port-Configuration-blue.svg" alt="Port Configuration">
  <img src="https://img.shields.io/badge/Debugging-Techniques-orange.svg" alt="Debugging Techniques">
  <img src="https://img.shields.io/badge/DevOps-Skills-red.svg" alt="DevOps Skills">
</p>

## Project Overview

This repository focuses on debugging and fixing Nginx web server port configuration issues. It's part of a series of web stack debugging projects, each addressing specific problems commonly encountered in web infrastructure. In this project, we tackle problems with Nginx not listening on port 80 and develop both standard and optimized solutions.

## Background Context

The Webstack debugging series trains you in the art of debugging. When debugging web stacks, you'll often encounter issues with network configurations, service settings, and process management.

For this project, you will need to fix an Ubuntu container's Nginx installation so that it's listening on port 80. The web stack debugging series requires you to develop Bash scripts that bring malfunctioning web stacks back to a working state. Before writing these scripts, you should troubleshoot manually to understand the issue.

## Requirements

* Ubuntu 20.04 LTS
* All Bash scripts must be executable (`chmod +x filename`)
* Bash scripts must pass Shellcheck without any errors
* All Bash scripts must run without error
* The first line of all Bash scripts should be `#!/usr/bin/env bash`
* The second line of all Bash scripts should be a comment explaining what the script does
* You cannot use `wget`
* Fixes should be focused on the minimum changes needed to make the service operational

## Project Tasks

### 0. Nginx likes port 80
**[0-nginx_likes_port_80](0-nginx_likes_port_80)**

Requirements:
- Using your debugging skills, find out what's keeping your Ubuntu container's Nginx installation from listening on port 80
- Write a Bash script that configures the server to make Nginx listen on port 80
- The script must be 5 lines long or less
- You cannot use `;`, `&&`, `||`
- You cannot use `wget` or `curl`
- You must use the `service` command to restart Nginx

```bash
#!/usr/bin/env bash
# Configures an Nginx server to listen on port 80.

rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
service nginx restart
```

### 1. Make it sweet and short
**[1-debugging_made_short](1-debugging_made_short)**

Requirements:
- Your Bash script must be 5 lines long or less
- There must be a new line at the end of the file
- You must respect Bash script requirements
- You cannot use `;`, `&&`, `||`
- You cannot use `wget` or `curl`
- You must use the `service` command to restart Nginx

```bash
#!/usr/bin/env bash
# Configures an Nginx server to listen on port 80.
ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
service nginx start
kill "$(pgrep 'nginx' | head -1)"
```

## Nginx Configuration Structure

### Sites-Available vs. Sites-Enabled

Nginx uses a modular configuration structure that separates available configurations from enabled ones:

- **/etc/nginx/sites-available/**: Contains all virtual host configurations that are available
- **/etc/nginx/sites-enabled/**: Contains symbolic links to configurations in sites-available that are currently active

This structure allows administrators to:
1. Maintain multiple site configurations
2. Enable/disable sites without deleting configurations
3. Quickly switch between different configurations

The main nginx.conf typically includes a directive to load all configurations from sites-enabled:

```nginx
include /etc/nginx/sites-enabled/*;
```

### Common Nginx Port Configuration Issues

1. **Incorrect symbolic links**: Missing or broken links between sites-available and sites-enabled
2. **Port conflicts**: Another service already using port 80
3. **Permission issues**: Nginx doesn't have permission to bind to port 80
4. **Configuration syntax errors**: Mistakes in the Nginx configuration files
5. **Listen directive problems**: Missing or incorrect listen directives

## Debugging Process for Port Issues

### 1. Checking if Nginx is Running

```bash
service nginx status
# or
systemctl status nginx
```

### 2. Examining Port Usage

```bash
# Check which process is using port 80
netstat -tuln | grep :80
# or
ss -tuln | grep :80

# Check if Nginx is listening on any ports
netstat -tuln | grep nginx
```

### 3. Inspecting Nginx Configuration

```bash
# Test configuration syntax
nginx -t

# Check the main configuration
cat /etc/nginx/nginx.conf

# Examine virtual host configurations
ls -la /etc/nginx/sites-available/
ls -la /etc/nginx/sites-enabled/

# Compare configurations
diff /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
```

### 4. Examining Nginx Logs

```bash
cat /var/log/nginx/error.log
```

### 5. Fixing Common Issues

#### Incorrect Symbolic Link

If the symbolic link is incorrect or missing:

```bash
# Remove faulty link
rm /etc/nginx/sites-enabled/default

# Create proper link
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
```

#### Restart Nginx After Configuration Changes

```bash
service nginx restart
# or
systemctl restart nginx
```

## Advanced Solution Explanation

The optimized solution (`1-debugging_made_short`) uses some clever techniques:

1. **Force Symbolic Link Creation**: The `-f` flag with `ln -s` removes the destination file if it exists before creating the link
2. **Starting Instead of Restarting**: Using `service nginx start` when Nginx is already running will show an error message but won't stop the script
3. **Process Management**: Killing the main Nginx process causes it to reread the configuration and restart without requiring a full service restart

These techniques allow us to fix the issue with fewer commands while maintaining idempotency (the script can be run multiple times without causing problems).

## Verifying the Fix

After applying either solution, you can verify that Nginx is properly listening on port 80:

```bash
curl -Is localhost | head -1
# Should return "HTTP/1.1 200 OK" or similar

netstat -tuln | grep :80
# Should show Nginx listening on port 80
```

## Common Network Port Numbers

Understanding standard port assignments is helpful when debugging web stacks:

| Port | Service |
|------|---------|
| 80 | HTTP |
| 443 | HTTPS |
| 22 | SSH |
| 21 | FTP |
| 25 | SMTP |
| 53 | DNS |
| 3306 | MySQL |
| 5432 | PostgreSQL |
| 27017 | MongoDB |
| 6379 | Redis |
| 8080 | Alternative HTTP port |

## Resources

* [Nginx documentation](https://nginx.org/en/docs/)
* [How to debug Nginx port binding issues](https://www.digitalocean.com/community/tutorials/how-to-troubleshoot-common-nginx-errors)
* [Understanding Nginx configuration structure](https://www.nginx.com/resources/wiki/start/topics/examples/full/)
* [Linux service management commands](https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units)
* [Network debugging tools and techniques](https://www.tecmint.com/linux-network-configuration-and-troubleshooting-commands/)
* [Guide to Nginx Configuration Files](https://www.linode.com/docs/guides/how-to-configure-nginx/)
* [Shellcheck - A shell script static analysis tool](https://www.shellcheck.net/)

---

*Project by ALX System Engineering & DevOps*
