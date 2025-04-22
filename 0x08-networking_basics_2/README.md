# Networking Basics 2

<p align="center">
  <img src="https://img.shields.io/badge/Localhost-Configuration-green.svg" alt="Localhost Configuration">
  <img src="https://img.shields.io/badge/IP-Management-blue.svg" alt="IP Management">
  <img src="https://img.shields.io/badge/Network-Services-orange.svg" alt="Network Services">
  <img src="https://img.shields.io/badge/Host-Files-yellow.svg" alt="Host Files">
</p>

## Project Overview

This repository builds upon fundamental networking concepts by focusing on localhost configuration, IP address management, host file customization, and basic network service implementation. These advanced networking skills are crucial for system administrators, network engineers, and developers working on networked applications and services.

## Learning Objectives

By the end of this project, you should be able to explain:

* What localhost/127.0.0.1 is and its role in networking
* What 0.0.0.0 represents and how it's used in networking
* What `/etc/hosts` is and how to modify it
* How to display active network interfaces on a Linux system
* How to configure IP addresses on network interfaces
* How to set up and use port listening on localhost
* The difference between local and public IP addresses
* How to implement basic network services using netcat
* How to troubleshoot IP configuration issues
* How DNS resolution works at the local level

## Requirements

* Ubuntu 20.04 LTS
* All Bash scripts must pass Shellcheck verification
* The first line of all Bash scripts should be `#!/usr/bin/env bash`
* The second line should be a comment explaining what the script does
* All files must be executable (`chmod +x filename`)
* All scripts must run correctly on Ubuntu 20.04 LTS

## Project Tasks

### Localhost and IP Management

#### 0. Change your home IP
**[0-change_your_home_IP](0-change_your_home_IP)**

Write a Bash script that configures an Ubuntu server with the following requirements:
- localhost resolves to 127.0.0.2
- facebook.com resolves to 8.8.8.8

This task modifies the host file (`/etc/hosts`) to change how the system resolves certain hostnames. This is useful for testing and development scenarios where you might need to redirect traffic.

#### 1. Show attached IPs
**[1-show_attached_IPs](1-show_attached_IPs)**

Write a Bash script that displays all active IPv4 IPs on the machine it's executed on.

This script helps you quickly identify all IPv4 addresses assigned to your system's network interfaces, which is useful for network configuration and troubleshooting.

### Network Services

#### 2. Port listening on localhost
**[100-port_listening_on_localhost](100-port_listening_on_localhost)**

Write a Bash script that listens on port 98 on localhost.

This script creates a simple network service using netcat (`nc`) to listen for incoming connections on port 98 of localhost, demonstrating basic network service implementation.

```bash
#!/usr/bin/env bash
# Listens on port 98

nc -l localhost 98
```

## Localhost/127.0.0.1

### What is Localhost?

Localhost is a hostname that refers to the current device used to access it. It is used to access the network services that are running on the host via the loopback network interface. Using the loopback interface bypasses any local network interface hardware.

### The Loopback Address

The IP address 127.0.0.1 is the standard IPv4 loopback address. When a process on your computer connects to 127.0.0.1, it's connecting to a network service on the same device.

The entire 127.0.0.0/8 block (127.0.0.0 through 127.255.255.255) is reserved for loopback purposes, though 127.0.0.1 is the most commonly used address.

### Uses for Localhost

- Testing web servers and applications without exposing them to the Internet
- Running services that should only be available on the local machine
- Inter-process communication
- Database connections for local development
- Reducing latency for local services

## The 0.0.0.0 Address

### What is 0.0.0.0?

In the context of servers, 0.0.0.0 means "all IPv4 addresses on the local machine". When a server is configured to listen on 0.0.0.0, it's listening on all available network interfaces.

### Uses for 0.0.0.0

- Binding a server to all available network interfaces
- Making a service accessible from both localhost and external networks
- Default route (in routing tables)
- Representing an unknown or unspecified address

### Difference Between 0.0.0.0 and 127.0.0.1

| 0.0.0.0 | 127.0.0.1 |
|---------|-----------|
| Binds to all interfaces | Binds only to the loopback interface |
| Accessible from external networks (if firewall allows) | Accessible only from the local machine |
| Used for services that should be publicly available | Used for services that should be private to the machine |

## The /etc/hosts File

### Purpose of the Hosts File

The `/etc/hosts` file is a plain text file used by operating systems to map hostnames to IP addresses. It serves as a local DNS system, allowing the system to resolve hostnames without querying external DNS servers.

### Format of the Hosts File

```
IP_address hostname [alias...]
```

Example:
```
127.0.0.1 localhost
192.168.1.10 myserver.local myserver
```

### Precedence in Name Resolution

On most Unix-like systems, the order of hostname resolution is controlled by the `/etc/nsswitch.conf` file. Typically, the hosts file is checked before DNS servers, making it a powerful tool for overriding DNS entries.

### Common Uses for /etc/hosts Modification

- Blocking websites by redirecting them to 127.0.0.1
- Setting up local development environments
- Testing websites before DNS propagation
- Overriding DNS for specific hostnames
- Local testing of load-balanced services

## IP Interface Management

### Displaying Network Interfaces

The `ifconfig` command (or its modern replacement `ip addr`) displays information about all network interfaces:

```bash
# Using ifconfig
ifconfig -a

# Using ip command
ip addr show
```

### Important Interface Types

| Interface | Description |
|-----------|-------------|
| lo | Loopback interface (localhost) |
| eth0/ens3 | Primary Ethernet interface |
| wlan0 | Wireless interface |
| docker0 | Docker bridge network |
| tun0/vpn0 | VPN interfaces |

### Finding Only IPv4 Addresses

To extract only the IPv4 addresses from the interface information, you can use a combination of commands:

```bash
# Using ifconfig and grep
ifconfig | grep -Eo 'inet ([0-9]{1,3}\.){3}[0-9]{1,3}' | cut -d' ' -f2

# Using ip command
ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}'
```

## Netcat (nc) for Network Services

### What is Netcat?

Netcat (commonly `nc`) is a utility that reads and writes data across network connections using TCP or UDP. It's often referred to as the "Swiss Army knife" of networking tools.

### Basic Usage

| Command | Description |
|---------|-------------|
| `nc -l localhost 98` | Listen on port 98 on localhost |
| `nc localhost 98` | Connect to a service on localhost port 98 |
| `nc -v host port` | Verbose connection to host:port |
| `nc -u host port` | Use UDP instead of TCP |
| `nc -w 5 host port` | Set timeout to 5 seconds |

### Practical Examples

**Creating a simple chat server:**
```bash
# Terminal 1 (Server)
nc -l localhost 8888

# Terminal 2 (Client)
nc localhost 8888
```

**File transfer:**
```bash
# Terminal 1 (Receiver)
nc -l localhost 8888 > received_file

# Terminal 2 (Sender)
nc localhost 8888 < file_to_send
```

**Port scanning:**
```bash
nc -zv localhost 1-1000
```

## Network Troubleshooting Commands

### Essential Commands

| Command | Description | Example |
|---------|-------------|---------|
| `ping` | Test connectivity to a host | `ping google.com` |
| `traceroute` | Show the route packets take | `traceroute github.com` |
| `netstat` | Display network connections | `netstat -tuln` |
| `ss` | Socket statistics (modern netstat) | `ss -tuln` |
| `nslookup` | Query DNS records | `nslookup example.com` |
| `dig` | DNS lookup utility | `dig example.com` |
| `host` | DNS lookup | `host example.com` |
| `ip` | Show/manipulate routing, devices, policy | `ip addr show` |
| `curl` | Transfer data from/to a server | `curl https://example.com` |
| `wget` | Download files from the web | `wget https://example.com/file` |

### Common Network Configuration Files

| File | Description |
|------|-------------|
| `/etc/hosts` | Static table lookup for hostnames |
| `/etc/resolv.conf` | DNS resolver configuration |
| `/etc/network/interfaces` | Network interface configuration (Debian/Ubuntu) |
| `/etc/netplan/` | Network configuration directory (newer Ubuntu) |
| `/etc/sysconfig/network-scripts/` | Network configuration (RHEL/CentOS) |
| `/proc/net/` | Virtual filesystem with network information |

## Resources

* [What is localhost](https://en.wikipedia.org/wiki/Localhost)
* [Understanding /etc/hosts](https://tldp.org/LDP/solrhe/Securing-Optimizing-Linux-RH-Edition-v1.3/chap9sec95.html)
* [Netcat Command in Linux](https://www.geeksforgeeks.org/netcat-command-in-linux-with-examples/)
* [IP Address Configuration in Linux](https://linuxconfig.org/how-to-configure-static-ip-address-on-ubuntu-20-04-focal-fossa-linux)
* [Ifconfig Command in Linux](https://www.tecmint.com/ifconfig-command-examples/)
* [Linux Network Configuration](https://www.redhat.com/sysadmin/linux-network-configuration)
* [Linux Networking Commands](https://www.digitalocean.com/community/tutorials/linux-networking-commands-scripts)

---

*Project by ALX System Engineering & DevOps*
