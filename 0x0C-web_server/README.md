# 0x0C. Web server

<p align="center">
  <img src="https://img.shields.io/badge/Nginx-Web_Server-green.svg" alt="Nginx Web Server">
  <img src="https://img.shields.io/badge/Bash-Scripting-blue.svg" alt="Bash Scripting">
  <img src="https://img.shields.io/badge/Puppet-Configuration-orange.svg" alt="Puppet Configuration">
  <img src="https://img.shields.io/badge/Server-Deployment-red.svg" alt="Server Deployment">
</p>

## Project Overview

This repository focuses on web server configuration and management, specifically using Nginx. It covers essential skills for DevOps and SysAdmin roles, including server setup, file transfer with SCP, domain configuration, URL redirection, custom error pages, and automation with Puppet.

## Learning Objectives

By the end of this project, you should be able to explain:

* The main role of a web server
* What is a child process and why web servers usually have parent and child processes
* The main HTTP requests and their purposes
* What DNS stands for and its main role
* What is a DNS A record and CNAME record
* How to transfer files from a client to a server using SCP
* How to install and configure Nginx web server
* How to set up domain names and DNS records
* How to implement URL redirection
* How to create custom error pages
* How to automate server configuration using Puppet

## Requirements

* Ubuntu 20.04 LTS
* All files should be interpreted on Ubuntu 20.04 LTS
* All Bash scripts must be executable (`chmod +x filename`)
* The first line of all Bash scripts should be `#!/usr/bin/env bash`
* The second line of all Bash scripts should be a comment explaining what the script does
* All Puppet manifests must pass `puppet-lint` version 2.1.1 without any errors
* All Puppet manifests must run without error
* All Puppet files must end with the extension `.pp`
* Your servers will be running Ubuntu 16.04 LTS

## Project Tasks

### 0. Transfer a file to your server
**[0-transfer_file](0-transfer_file)**

Requirements:
- Write a Bash script that transfers a file from our client to a server
- Accepts 4 parameters:
  1. The path to the file to be transferred
  2. The IP of the server to transfer the file to
  3. The username that scp connects with
  4. The path to the SSH private key that scp uses
- Display Usage: `0-transfer_file PATH_TO_FILE IP USERNAME PATH_TO_SSH_KEY` if less than 3 parameters passed
- scp must transfer the file to the user home directory `~/`
- Strict host key checking must be disabled when using scp

```bash
#!/usr/bin/env bash
# This is a bash script that transfers a file from a client to a server using scp

if [ "$#" -lt 3 ]; then
	echo "Usage: 0-transfer_file PATH_TO_FILE IP USERNAME PATH_TO_SSH_KEY"
elif [ "$#" -lt 4 ]; then
	scp -o StrictHostKeyChecking=no "$1" "$3@$2":~/
else
	scp -i "$4" -o StrictHostKeyChecking=no "$1" "$3@$2":~/
fi
```

### 1. Install nginx web server
**[1-install_nginx_web_server](1-install_nginx_web_server)**

Requirements:
- Install nginx on your web-01 server
- Nginx should be listening on port 80
- When querying Nginx at its root `/` with a GET request using `curl`, it must return a page that contains the string "Hello World!"
- You can't use `systemctl` for restarting nginx

```bash
#!/usr/bin/env bash
# installs nginx and configure it to listen on port 80
# print "Hello World"

sudo apt-get -y update
sudo apt-get -y install nginx
echo 'Hello World!' > /var/www/html/index.nginx-debian.html
sudo service nginx start
```

### 2. Setup a domain name
**[2-setup_a_domain_name](2-setup_a_domain_name)**

Requirements:
- Provide the domain name only (example: `example.tech`), no subdomain (e.g., `www`)
- Configure your DNS records with an A entry so that your root domain points to your web-01 IP address
- Go to your [domain registrar platform](https://my.alx-cod.online/) and create a domain name for free

### 3. Redirection
**[3-redirection](3-redirection)**

Requirements:
- Configure your Nginx server so that `/redirect_me` is redirecting to another page
- The redirection must be a "301 Moved Permanently"
- You can't use `systemctl` for restarting nginx

### 4. Not found page 404
**[4-not_found_page_404](4-not_found_page_404)**

Requirements:
- Configure your Nginx server to have a custom 404 page that contains the string "Ceci n'est pas une page"
- You can't use `systemctl` for restarting nginx

```bash
#!/usr/bin/env bash
# Configure your Nginx server to have a custom 404 page

apt-get update
apt-get install -y nginx

mkdir /etc/nginx/html
touch /etc/nginx/html/index.html
echo "Hello World!" > /etc/nginx/html/index.html
touch /etc/nginx/html/404.html
echo "Ceci n'est pas une page" > /etc/nginx/html/404.html

printf %s "server {
    listen 80;
    listen [::]:80 default_server;
    root   /etc/nginx/html;
    index  index.html index.htm;

    location /redirect_me {
        return 301 http://chxgbx.cloud;
    }

    error_page 404 /404.html;
    location /404 {
      root /etc/nginx/html;
      internal;
    }
}" > /etc/nginx/sites-available/default

service nginx restart
```

### 5. Install Nginx web server (w/ Puppet)
**[7-puppet_install_nginx_web_server.pp](7-puppet_install_nginx_web_server.pp)**

Requirements:
- Install and configure Nginx using Puppet
- Nginx should be listening on port 80
- When querying Nginx at its root `/` with a GET request using `curl`, it must return a page that contains the string "Hello World!"
- The redirection must be a "301 Moved Permanently"
- Your answer file should be a Puppet manifest containing commands to automatically configure an Ubuntu machine

```puppet
# Install Nginx web server (w/ Puppet)
package { 'nginx':
  ensure => installed,
}

file_line { 'manageLineInFile':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => 'rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;',
}

file { '/var/www/html/index.html':
  content => 'Hello World!',
}

service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}
```

## Web Server Concepts

### What is a Web Server?

A web server is software and hardware that uses HTTP (Hypertext Transfer Protocol) and other protocols to respond to client requests made over the World Wide Web. The primary function of a web server is to store, process, and deliver web pages to clients using HTTP.

Web servers have two main components:
1. **Hardware Component**: A computer that stores web server software and website component files
2. **Software Component**: Includes an HTTP server that understands URLs (web addresses) and HTTP protocols

### How Web Servers Work

1. A user enters a URL in their browser
2. The browser sends a request to the web server
3. The web server locates the requested resource
4. The web server sends the resource back to the browser
5. The browser renders the content for the user

### Parent and Child Processes in Web Servers

Web servers typically use a parent-child process model for handling multiple connections:

- **Parent Process**: Responsible for:
  - Listening for incoming connections
  - Handling configuration
  - Spawning child processes
  - Managing the overall server lifecycle

- **Child Processes**: Responsible for:
  - Processing individual client requests
  - Executing server-side code
  - Generating responses
  - Isolating client connections for security and stability

This model provides several benefits:
- Improved stability (a crash in one child doesn't affect others)
- Better resource management
- Enhanced security through process isolation
- Ability to handle multiple connections concurrently

### Common HTTP Requests (Methods)

| Method | Purpose |
|--------|---------|
| `GET` | Request data from a specified resource |
| `POST` | Submit data to be processed to a specified resource |
| `PUT` | Update a specified resource with new data |
| `DELETE` | Delete a specified resource |
| `HEAD` | Same as GET but returns only HTTP headers (no document body) |
| `OPTIONS` | Returns the HTTP methods that the server supports |
| `PATCH` | Apply partial modifications to a resource |

### DNS (Domain Name System)

DNS (Domain Name System) is a hierarchical and decentralized naming system for computers, services, or other resources connected to the Internet or a private network. It translates human-readable domain names (like example.com) to machine-readable IP addresses (like 93.184.216.34).

#### Common DNS Record Types

| Record Type | Purpose |
|-------------|---------|
| **A Record** | Maps a domain name to the IPv4 address of the server hosting that domain |
| **AAAA Record** | Maps a domain name to the IPv6 address of the server hosting that domain |
| **CNAME Record** | Maps an alias name to the canonical domain name. For example, www.example.com might be an alias (CNAME) for example.com |
| **MX Record** | Specifies mail servers responsible for accepting email on behalf of a domain |
| **TXT Record** | Allows administrators to insert arbitrary text into DNS records, often used for verification |
| **NS Record** | Delegates a DNS zone to use the given authoritative name servers |
| **SOA Record** | Specifies authoritative information about a DNS zone |
| **PTR Record** | Maps an IP address to a domain name (reverse of A record) |

### Nginx Web Server

Nginx (pronounced "engine-x") is a popular open-source web server, reverse proxy, load balancer, mail proxy, and HTTP cache. It is known for its high performance, stability, rich feature set, simple configuration, and low resource consumption.

#### Key Nginx Features

- **High Performance**: Can handle thousands of concurrent connections with low memory usage
- **Reverse Proxy**: Can distribute client requests across multiple servers
- **Load Balancing**: Can distribute traffic across multiple servers for improved performance
- **Caching**: Can cache content to reduce server load
- **SSL/TLS Termination**: Can handle SSL/TLS encryption and decryption
- **URL Rewriting**: Can modify URLs before processing requests
- **HTTP/2 Support**: Supports the latest HTTP protocol version
- **WebSockets Support**: Can proxy WebSocket connections

#### Basic Nginx Configuration Structure

Nginx configuration is typically located in `/etc/nginx/nginx.conf` with site-specific configurations in `/etc/nginx/sites-available/` and `/etc/nginx/sites-enabled/`.

A basic server block looks like:

```nginx
server {
    listen 80;
    server_name example.com www.example.com;
    
    root /var/www/html;
    index index.html index.htm;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    location /redirect_me {
        return 301 https://www.example.com/new-page;
    }
    
    error_page 404 /404.html;
    location = /404.html {
        internal;
    }
}
```

### Secure Copy Protocol (SCP)

SCP (Secure Copy Protocol) is a network protocol that supports file transfers between hosts on a network. It uses SSH for data transfer and authentication, providing the same security as SSH.

#### Basic SCP Command Structure

```bash
scp [options] source_file user@host:destination_file
```

Common options include:
- `-i identity_file`: Specifies the private key to use
- `-P port`: Specifies the port to connect to on the remote host
- `-r`: Recursively copy entire directories
- `-p`: Preserve file attributes (modification times, access times, and modes)
- `-o option`: Allows specifying SSH options directly

### Automation with Puppet

Puppet is a configuration management tool that allows you to define and automate the configuration of servers and applications. It uses a declarative language to define the desired state of a system, and then ensures that the system matches that state.

#### Core Puppet Concepts

- **Resources**: The basic units of configuration in Puppet (files, packages, services, etc.)
- **Classes**: Collections of resources that are managed together
- **Manifests**: Files containing Puppet code (with `.pp` extension)
- **Modules**: Collections of manifests, files, templates, and other resources
- **Nodes**: The systems that Puppet manages
- **Catalogs**: Compiled manifests that describe the desired state of a node
- **Facts**: Information about the node that Puppet is running on

#### Common Puppet Resource Types

- `package`: Manages software packages
- `file`: Manages files and directories
- `service`: Manages services
- `user`: Manages users
- `group`: Manages groups
- `exec`: Executes commands
- `cron`: Manages cron jobs
- `file_line`: Manages lines in files (from puppetlabs-stdlib)

## Resources

* [How the web works](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/How_the_Web_works)
* [Nginx](https://en.wikipedia.org/wiki/Nginx)
* [How to Configure Nginx](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-20-04)
* [Child process concept](https://www.gnu.org/software/libc/manual/html_node/Processes.html#Processes)
* [Root and subdomain](https://landingi.com/help/domains-vs-subdomains/)
* [HTTP requests](https://www.tutorialspoint.com/http/http_methods.htm)
* [HTTP redirection](https://moz.com/learn/seo/redirection)
* [Not found HTTP response code](https://en.wikipedia.org/wiki/HTTP_404)
* [Logs files on Linux](https://www.cyberciti.biz/faq/ubuntu-linux-gnome-system-log-viewer/)
* [Puppet resource type: file_line](https://puppet.com/docs/puppet/latest/types/file_line.html)
* [RFC 7231 (HTTP/1.1)](https://tools.ietf.org/html/rfc7231)
* [RFC 7540 (HTTP/2)](https://tools.ietf.org/html/rfc7540)

---

*Project by ALX System Engineering & DevOps*
