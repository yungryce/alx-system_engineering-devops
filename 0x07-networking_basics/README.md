# Networking Basics

<p align="center">
  <img src="https://img.shields.io/badge/OSI-Model-green.svg" alt="OSI Model">
  <img src="https://img.shields.io/badge/TCP/IP-Protocols-blue.svg" alt="TCP/IP Protocols">
  <img src="https://img.shields.io/badge/Network-Diagnostics-orange.svg" alt="Network Diagnostics">
  <img src="https://img.shields.io/badge/IP-Addressing-yellow.svg" alt="IP Addressing">
</p>

## Project Overview

This repository provides an introduction to fundamental networking concepts, focusing on the OSI model, types of networks, IP addressing, TCP/UDP protocols, and basic network diagnostics. Understanding these networking fundamentals is essential for system administration, cybersecurity, and web development, as they form the foundation for all network communications in computing environments.

## Learning Objectives

By the end of this project, you should be able to explain:

* The OSI Model, its layers, and the function of each layer
* Different types of networks (LAN, WAN, Internet) and their characteristics
* What a MAC address is and its role in network communications
* What an IP address is and the difference between public and private IPs
* The difference between TCP and UDP protocols and their use cases
* The concept of ports and the well-known port numbers for common services
* How to check for listening ports and active network connections
* How to perform basic network diagnostics using tools like ping
* How to verify host connectivity and troubleshoot network issues

## Requirements

* Ubuntu 20.04 LTS
* All Bash scripts must pass Shellcheck verification
* The first line of all Bash scripts should be `#!/usr/bin/env bash`
* The second line should be a comment explaining what the script does
* All files must be executable (`chmod +x filename`)
* All scripts must be exactly two lines long (except for 4-TCP_and_UDP_ports and 5-is_the_host_on_the_network)

## Project Tasks

### Networking Concepts

#### 0. OSI Model
**[0-OSI_model](0-OSI_model)**

What is the OSI model?
1. Set of specifications that network hardware manufacturers must respect
2. The OSI model is a conceptual model that characterizes the communication functions of a telecommunication system without regard to their underlying internal structure and technology
3. The OSI model is a model that characterizes the communication functions of a telecommunication system with a strong regard for their underlying internal structure and technology

How is the OSI model organized?
1. Alphabetically
2. From the lowest to the highest level
3. Randomly

#### 1. Types of Network
**[1-types_of_network](1-types_of_network)**

What type of network a computer in local is connected to?
1. Internet
2. WAN
3. LAN

What type of network could connect an office in one building to another office in a building a few streets away?
1. Internet
2. WAN
3. LAN

What network do you use when you browse www.google.com from your smartphone (not connected to the Wifi)?
1. Internet
2. WAN
3. LAN

#### 2. MAC and IP Address
**[2-MAC_and_IP_address](2-MAC_and_IP_address)**

What is a MAC address?
1. The name of a network interface
2. The unique identifier of a network interface
3. A network interface

What is an IP address?
1. Is to devices connected to a network what postal address is to houses
2. The unique identifier of a network interface
3. Is a number that network devices use to connect to networks

#### 3. UDP and TCP
**[3-UDP_and_TCP](3-UDP_and_TCP)**

Which statement is correct for the TCP box?
1. It is a protocol that is transferring data in a slow way but surely
2. It is a protocol that is transferring data in a fast way and might lose data along in the process

Which statement is correct for the UDP box?
1. It is a protocol that is transferring data in a slow way but surely
2. It is a protocol that is transferring data in a fast way and might lose data along in the process

Which statement is correct for the TCP worker?
1. Have you received boxes x, y, z?
2. May I increase the rate at which I am sending you boxes?

### Network Diagnostics

#### 4. TCP and UDP Ports
**[4-TCP_and_UDP_ports](4-TCP_and_UDP_ports)**

A Bash script that displays listening ports:
- Shows only listening sockets
- Shows the PID and name of the program to which each socket belongs

```bash
#!/usr/bin/env bash
# a Bash script that displays listening ports:
#+ That only shows listening sockets
#+ That shows the PID and name of the program to which each socket belongs

sudo netstat -lp
```

#### 5. Is the Host on the Network
**[5-is_the_host_on_the_network](5-is_the_host_on_the_network)**

A Bash script that pings an IP address passed as an argument:
- Accepts a string as an argument
- Displays "Usage: 5-is_the_host_on_the_network {IP_ADDRESS}" if no argument passed
- Pings the IP 5 times

```bash
#!/usr/bin/env bash
# Accepts a string as an argument
#+ Usage: 5-is_the_host_on_the_network {IP_ADDRESS} if no argument
#+ Ping the IP 5 times

if [ $# -ne 1 ]; then
	echo "Usage: 5-is_the_host_on_the_network {IP_ADDRESS}"
	exit 1
fi
ping -c 5 "$1"
```

## OSI Model

The Open Systems Interconnection (OSI) model is a conceptual framework used to understand and standardize the functions of a telecommunication or computing system without regard to its underlying internal structure and technology.

### The 7 Layers of the OSI Model

| Layer | Name | Function | Examples |
|-------|------|----------|----------|
| 7 | Application | Interface for applications to access network services | HTTP, SMTP, FTP, DNS |
| 6 | Presentation | Data formatting, encryption, compression | SSL/TLS, JPEG, MIME |
| 5 | Session | Manage sessions between applications | NetBIOS, RPC, SOCKS |
| 4 | Transport | End-to-end connections, reliability, flow control | TCP, UDP |
| 3 | Network | Logical addressing, routing, path determination | IP, ICMP, OSPF, BGP |
| 2 | Data Link | Physical addressing, access to media, error detection | Ethernet, PPP, MAC |
| 1 | Physical | Transmission of raw bit streams over physical medium | Cables, switches, NICs |

### Mnemonic for Remembering OSI Layers

**A**ll **P**eople **S**eem **T**o **N**eed **D**ata **P**rocessing

(Application, Presentation, Session, Transport, Network, Data Link, Physical)

## Types of Networks

### LAN (Local Area Network)

A network that connects devices within a limited area such as a home, office building, or campus.

**Characteristics:**
- Limited geographical area (typically single location)
- High data transfer rates
- Low latency
- Privately owned and managed
- Typical technologies: Ethernet, Wi-Fi

### WAN (Wide Area Network)

A network that spans a large geographical area, often connecting multiple LANs together.

**Characteristics:**
- Covers a large geographical area
- Typically slower than LAN
- Often uses leased telecommunication lines
- Examples: Corporate networks connecting multiple office locations
- Technologies: MPLS, T1/E1 lines, Frame Relay

### Internet

A global system of interconnected computer networks that use the Internet protocol suite (TCP/IP).

**Characteristics:**
- Global network of networks
- Public access
- Diverse technologies and speeds
- Decentralized administration
- Based on TCP/IP protocols

## IP Addressing

### IPv4 Structure

An IPv4 address is a 32-bit number written in dot-decimal notation, divided into four octets.

Example: `192.168.1.1`

### IPv4 Address Classes

| Class | Range | Default Subnet Mask | Use |
|-------|-------|---------------------|-----|
| A | 1.0.0.0 - 126.255.255.255 | 255.0.0.0 | Large networks |
| B | 128.0.0.0 - 191.255.255.255 | 255.255.0.0 | Medium-sized networks |
| C | 192.0.0.0 - 223.255.255.255 | 255.255.255.0 | Small networks |
| D | 224.0.0.0 - 239.255.255.255 | N/A | Multicast |
| E | 240.0.0.0 - 255.255.255.255 | N/A | Reserved for research |

### Private IP Address Ranges

| Range | Class | Purpose |
|-------|-------|---------|
| 10.0.0.0 - 10.255.255.255 | A | Private networks |
| 172.16.0.0 - 172.31.255.255 | B | Private networks |
| 192.168.0.0 - 192.168.255.255 | C | Private networks |

### Special IP Addresses

| Address | Purpose |
|---------|---------|
| 127.0.0.1 | Localhost (loopback) |
| 0.0.0.0 | Default network |
| 255.255.255.255 | Broadcast |

## MAC Addressing

A Media Access Control (MAC) address is a unique identifier assigned to a network interface controller (NIC) for use as a network address in communications within a network segment.

### MAC Address Format

A MAC address is a 48-bit number, typically represented as six groups of two hexadecimal digits, separated by hyphens or colons.

Example: `00:1A:2B:3C:4D:5E`

### MAC Address Components

- First 24 bits (3 bytes): Organizationally Unique Identifier (OUI), assigned to manufacturers
- Last 24 bits (3 bytes): Device identifier, assigned by the manufacturer

## TCP vs UDP

### TCP (Transmission Control Protocol)

A connection-oriented protocol that establishes a connection before data is exchanged and ensures reliable data delivery.

**Characteristics:**
- Connection-oriented
- Reliable delivery
- Data retransmission for lost packets
- In-order delivery
- Flow control and congestion control
- Higher overhead
- Examples: Web browsing (HTTP/HTTPS), email (SMTP), file transfer (FTP)

### UDP (User Datagram Protocol)

A connectionless protocol that sends data without establishing a connection first and does not guarantee delivery.

**Characteristics:**
- Connectionless
- No guarantee of delivery
- No retransmission for lost packets
- No in-order delivery
- No flow control or congestion control
- Lower overhead
- Examples: Streaming media, online gaming, DNS, VoIP

## Port Numbers

A port number is a 16-bit unsigned integer that identifies a specific process to which an Internet or other network message is to be forwarded when it arrives at a server.

### Well-Known Ports (0-1023)

| Port | Protocol | Service |
|------|----------|---------|
| 20/21 | TCP | FTP (File Transfer Protocol) |
| 22 | TCP | SSH (Secure Shell) |
| 23 | TCP | Telnet |
| 25 | TCP | SMTP (Simple Mail Transfer Protocol) |
| 53 | TCP/UDP | DNS (Domain Name System) |
| 67/68 | UDP | DHCP (Dynamic Host Configuration Protocol) |
| 80 | TCP | HTTP (Hypertext Transfer Protocol) |
| 110 | TCP | POP3 (Post Office Protocol v3) |
| 143 | TCP | IMAP (Internet Message Access Protocol) |
| 443 | TCP | HTTPS (HTTP Secure) |

### Registered Ports (1024-49151)

Ports that can be registered for services with IANA, but can also be used by ordinary applications.

### Dynamic/Private Ports (49152-65535)

Ports that cannot be registered with IANA and can be used by any application.

## Network Diagnostic Tools

### ping

A utility used to test the reachability of a host on an Internet Protocol network and to measure the round-trip time for messages sent to a target host.

```bash
# Basic usage
ping google.com

# Specific number of packets
ping -c 5 192.168.1.1

# Set interval between packets
ping -i 2 google.com
```

### netstat

A command-line tool that displays network connections, routing tables, interface statistics, masquerade connections, and multicast memberships.

```bash
# List all open ports and connections
netstat -a

# List only TCP connections
netstat -t

# List only UDP connections
netstat -u

# List listening sockets
netstat -l

# Display PID and program name
netstat -p

# Combination for listening ports with program info
netstat -lp
```

### traceroute

A network diagnostic tool used to track the pathway taken by a packet on an IP network from source to destination.

```bash
traceroute google.com
```

### nslookup/dig

Tools for querying DNS servers for information about domains and IP addresses.

```bash
# nslookup
nslookup google.com

# dig
dig google.com
```

### ifconfig/ip

Tools for displaying and configuring network interfaces.

```bash
# ifconfig
ifconfig

# ip address show
ip a
```

## Resources

* [OSI Model](https://en.wikipedia.org/wiki/OSI_model)
* [Introduction to IP Addressing](https://www.cisco.com/c/en/us/support/docs/ip/routing-information-protocol-rip/13788-3.html)
* [TCP/IP Model](https://www.geeksforgeeks.org/tcp-ip-model/)
* [Network Ports and Protocols](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers)
* [Network Diagnostic Tools](https://www.networkworld.com/article/3242170/linux-networking-diagnostic-commands.html)
* [MAC Addressing](https://en.wikipedia.org/wiki/MAC_address)
* [TCP vs UDP](https://www.cloudflare.com/learning/ddos/glossary/user-datagram-protocol-udp/)

---

*Project by ALX System Engineering & DevOps*
