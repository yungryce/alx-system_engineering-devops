# 0x13. Firewall

<p align="center">
  <img src="https://img.shields.io/badge/Security-Firewall-green.svg" alt="Security Firewall">
  <img src="https://img.shields.io-badge/UFW-Configuration-blue.svg" alt="UFW Configuration">
  <img src="https://img.shields.io-badge/Network-Protection-orange.svg" alt="Network Protection">
  <img src="https://img.shields.io-badge/Port-Management-red.svg" alt="Port Management">
</p>

## Project Overview

This repository focuses on implementing network security through firewalls, specifically using UFW (Uncomplicated Firewall) on Linux servers. Firewalls are essential for protecting servers from unauthorized access and network-based attacks by controlling incoming and outgoing traffic based on predefined security rules.

## Background Context

In today's interconnected digital environment, servers are constantly exposed to the internet and vulnerable to various network-based attacks. Firewalls serve as the first line of defense in network security, controlling the traffic that can reach your server based on configurable rules.

This project implements firewall configurations using UFW (Uncomplicated Firewall), a user-friendly interface for managing iptables, the powerful but complex firewall system built into the Linux kernel.

## Requirements

* Ubuntu 20.04 LTS
* All Bash scripts must be executable
* All files should have the correct permissions
* Configuration files should follow best practices for security

## Project Tasks

### 0. Block all incoming traffic but
**[0-block_all_incoming_traffic_but](0-block_all_incoming_traffic_but)**

Requirements:
- Install the `ufw` firewall and setup a few rules on `web-01`
- Configure `ufw` so that it blocks all incoming traffic, except the following TCP ports:
  * 22 (SSH)
  * 443 (HTTPS SSL)
  * 80 (HTTP)
- Share the `ufw` commands you used in your answer file

```bash
sudo apt-get install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw allow 443/tcp
sudo ufw allow 80/tcp
sudo ufw enable -y
sudo ufw status
```

### 1. Port forwarding
**[100-port_forwarding](100-port_forwarding)**

Requirements:
- Configure `web-01` so that its firewall redirects port 8080/TCP to port 80/TCP
- Your answer file should be a copy of the UFW configuration file that you modified to make this happen

## Firewall Fundamentals

### What is a Firewall?

A firewall is a network security system that monitors and controls incoming and outgoing network traffic based on predetermined security rules. Firewalls establish a barrier between a trusted internal network and untrusted external networks, such as the Internet.

### Types of Firewalls

1. **Packet Filtering Firewall**: Examines packets and prohibits those that don't match an established security rule
2. **Stateful Inspection Firewall**: Tracks the state of active connections and determines which network packets are allowed through
3. **Application Gateway Firewall**: Applies security mechanisms to specific applications
4. **Next-Generation Firewall (NGFW)**: Combines traditional firewall technology with additional functionality like intrusion prevention
5. **Software vs. Hardware Firewalls**: Can be implemented as software applications or dedicated hardware devices

### UFW (Uncomplicated Firewall)

UFW is a user-friendly front-end for managing iptables, the default firewall configuration tool for Linux. It simplifies the process of configuring a firewall by providing a more straightforward command syntax.

Key features of UFW:
- Easy-to-use command line interface
- Supports both IPv4 and IPv6
- Configurable through simple commands
- Default deny/allow policies
- Application profiles for common services
- Logging capabilities for monitoring

## Basic UFW Commands

### Installation

```bash
sudo apt-get update
sudo apt-get install ufw
```

### Default Policies

```bash
# Deny all incoming traffic
sudo ufw default deny incoming

# Allow all outgoing traffic
sudo ufw default allow outgoing
```

### Managing Rules

```bash
# Allow SSH connections
sudo ufw allow ssh
# or
sudo ufw allow 22/tcp

# Allow HTTP and HTTPS
sudo ufw allow http
sudo ufw allow https
# or
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Allow specific port range
sudo ufw allow 6000:6007/tcp

# Allow specific IP address
sudo ufw allow from 203.0.113.4

# Allow specific IP to specific port
sudo ufw allow from 203.0.113.4 to any port 22

# Deny traffic
sudo ufw deny http
# or
sudo ufw deny 80/tcp
```

### Enabling/Disabling the Firewall

```bash
# Enable firewall
sudo ufw enable

# Disable firewall
sudo ufw disable

# Check status
sudo ufw status
# or for more details
sudo ufw status verbose
```

### Deleting Rules

```bash
# By rule number
sudo ufw status numbered
sudo ufw delete 2

# By actual rule
sudo ufw delete allow 80/tcp
```

### Resetting UFW

```bash
# Reset to default settings
sudo ufw reset
```

## Advanced Firewall Configurations

### Port Forwarding

Port forwarding allows redirecting traffic from one port to another, which can be useful for various networking scenarios.

To enable port forwarding in UFW:

1. Edit the `/etc/ufw/sysctl.conf` file and uncomment:
   ```
   net/ipv4/ip_forward=1
   ```

2. Create NAT rules before firewall rules are loaded:
   Edit `/etc/ufw/before.rules` and add before the `*filter` line:
   ```
   *nat
   :PREROUTING ACCEPT [0:0]
   -A PREROUTING -p tcp --dport 8080 -j REDIRECT --to-port 80
   COMMIT
   ```

3. Reload UFW:
   ```bash
   sudo ufw disable
   sudo ufw enable
   ```

### Rate Limiting

UFW supports rate limiting to protect against brute force attacks:

```bash
# Limit SSH connections
sudo ufw limit ssh
```

This allows only 6 connections per 30 seconds from a single IP address.

## Firewall Security Best Practices

1. **Start with Default Deny**: Begin with blocking all connections, then allow only necessary services
2. **Principle of Least Privilege**: Allow only what is required for your services to function
3. **Regularly Audit Rules**: Remove rules for services that are no longer in use
4. **Use Specific Rules**: Be as specific as possible in your rules (source IPs, specific ports)
5. **Enable Logging**: Monitor firewall activity to identify potential threats
6. **Keep Updated**: Ensure your firewall software is updated with security patches
7. **Multiple Layers of Security**: Don't rely solely on a firewall; implement other security measures
8. **Document Your Rules**: Maintain documentation of firewall rules and their purposes
9. **Test Your Configuration**: Regularly test that your firewall is working as expected
10. **Have a Backup Plan**: Ensure you have a way to access your server if a firewall misconfiguration locks you out

## UFW vs. iptables

While UFW provides a simplified interface for managing firewall rules, it's important to understand that it is built on top of iptables:

| Feature | UFW | iptables |
|---------|-----|----------|
| User-friendliness | High - Simple syntax | Low - Complex syntax |
| Flexibility | Moderate - Covers most common scenarios | High - Extremely customizable |
| Learning curve | Low - Easy to learn | High - Steep learning curve |
| Power | Moderate - Handles most situations | High - Complete control |
| Integration | Works well with common applications | Works with everything but requires manual configuration |

UFW is recommended for most users and simpler server configurations, while direct iptables usage may be preferred for complex enterprise environments or specialized networking needs.

## Troubleshooting Firewall Issues

### Common Problems

1. **Locked Out of SSH**: 
   - If you've locked yourself out, you'll need to access the server directly or through the provider's console
   - `sudo ufw disable` to turn off the firewall
   - Fix your rules, then `sudo ufw enable`

2. **Service Not Accessible**:
   - Check firewall status: `sudo ufw status`
   - Verify that the proper ports are allowed
   - Test with the firewall temporarily disabled

3. **Rules Not Working as Expected**:
   - Check rule order: `sudo ufw status numbered`
   - Remember rules are processed in order, and processing stops at the first match
   - Use verbose status: `sudo ufw status verbose`

### Logging

To enable logging:
```bash
sudo ufw logging on
# Options: off, low, medium, high, full
sudo ufw logging medium
```

Logs are typically stored in `/var/log/ufw.log`

## Resources

* [UFW Essentials: Common Firewall Rules and Commands](https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands)
* [How To Set Up a Firewall with UFW on Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-20-04)
* [An In-Depth Guide to iptables](https://www.digitalocean.com/community/tutorials/a-deep-dive-into-iptables-and-netfilter-architecture)
* [Port Forwarding with UFW](https://help.ubuntu.com/community/UFW#Port_Forwarding)
* [How to Configure Port Forwarding on iptables](https://linuxconfig.org/how-to-configure-port-forwarding-with-ufw-on-linux)
* [Web Server Security Best Practices](https://www.acunetix.com/blog/articles/web-server-security-best-practices/)

---

*Project by ALX System Engineering & DevOps*
