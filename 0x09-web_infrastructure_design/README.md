# Web Infrastructure Design

<p align="center">
  <img src="https://img.shields.io/badge/Web-Architecture-green.svg" alt="Web Architecture">
  <img src="https://img.shields.io/badge/System-Design-blue.svg" alt="System Design">
  <img src="https://img.shields.io/badge/High-Availability-orange.svg" alt="High Availability">
  <img src="https://img.shields.io/badge/Scalability-Solutions-yellow.svg" alt="Scalability Solutions">
</p>

## Project Overview

This project focuses on designing robust, secure, and scalable web infrastructures. Through a series of progressive design exercises, we explore the architecture of web systems from simple one-server setups to complex distributed systems with load balancing, security features, and monitoring. Understanding these infrastructure designs is crucial for system administrators, DevOps engineers, and architects responsible for building and maintaining modern web applications.

## Learning Objectives

By the end of this project, you should be able to explain:

* The components of web infrastructure (web server, application server, database)
* The role of DNS and how domain names are resolved
* The concept of load balancing and its implementation methods
* Database replication and the differences between primary and replica nodes
* The importance of firewalls in web infrastructure security
* Monitoring systems and their role in maintaining infrastructure health
* HTTPS/SSL for encrypted communications
* What a single point of failure is and how to mitigate it
* High availability infrastructure design principles
* Scaling strategies for growing web applications
* How to document and diagram system architecture

## Requirements

* For each task, create a diagram illustrating the web infrastructure
* Each diagram should include detailed explanations of each component
* Identify issues and problems with each infrastructure design
* All files should contain a link to the diagram image
* Diagrams can be created using any tools of your choice
* Public GitHub repository: `alx-system_engineering-devops`
* Directory: `0x09-web_infrastructure_design`

## Project Tasks

### 0. Simple Web Stack
**[0-simple_web_stack](0-simple_web_stack)**

Design a one-server web infrastructure that hosts the website reachable via `www.foobar.com`.

Requirements:
- 1 server
- 1 web server (Nginx)
- 1 application server
- 1 application files (code base)
- 1 database (MySQL)
- Domain name configured with a www record pointing to server IP

### 1. Distributed Web Infrastructure
**[1-distributed_web_infrastructure](1-distributed_web_infrastructure)**

Design a three-server web infrastructure that hosts the website `www.foobar.com`.

Requirements:
- 2 servers
- 1 web server (Nginx)
- 1 application server
- 1 load balancer (HAproxy)
- 1 application files (code base)
- 1 database (MySQL)

### 2. Secured and Monitored Web Infrastructure
**[2-secured_and_monitored_web_infrastructure](2-secured_and_monitored_web_infrastructure)**

Design a three-server web infrastructure that hosts the website `www.foobar.com` with security, encrypted traffic, and monitoring.

Requirements:
- 3 firewalls
- 1 SSL certificate to serve `www.foobar.com` over HTTPS
- 3 monitoring clients (data collectors for Sumologic or other monitoring services)

### 3. Scale Up
**[3-scale_up](3-scale_up)**

Design a scaled up web infrastructure for `www.foobar.com`.

Requirements:
- 1 server
- 1 load balancer (HAproxy) configured as a cluster with another load balancer
- Split components (web server, application server, database) with their own server

## Key Concepts in Web Infrastructure

### Server Components

#### Web Server

A web server is software and hardware that uses HTTP (Hypertext Transfer Protocol) to serve files that form web pages to users in response to their requests, which are forwarded by their computers' HTTP clients.

**Popular web servers:**
- Nginx
- Apache
- Microsoft IIS
- LiteSpeed

**Key responsibilities:**
- Serving static content
- Handling HTTP requests
- Forwarding dynamic requests to application servers
- Managing connections
- Handling security configurations

#### Application Server

An application server is the component that hosts the business logic and application code, processing dynamic content.

**Key responsibilities:**
- Execute application code
- Process business logic
- Connect to databases and other services
- Serve dynamic content
- Handle application state

**Examples:**
- Unicorn/Puma (Ruby)
- Gunicorn/uWSGI (Python)
- Passenger
- Tomcat (Java)
- Node.js (JavaScript)

#### Database Server

A database server stores and manages the application data.

**Key responsibilities:**
- Data storage and retrieval
- Data integrity maintenance
- Query processing
- Transaction management
- Data backup and recovery

**Popular databases:**
- MySQL/MariaDB
- PostgreSQL
- MongoDB
- Oracle
- SQL Server

### Domain Name System (DNS)

The Domain Name System (DNS) is a hierarchical and decentralized naming system for computers, services, or other resources connected to the Internet.

#### DNS Records

| Record Type | Purpose |
|-------------|---------|
| A | Maps a domain name to an IPv4 address |
| AAAA | Maps a domain name to an IPv6 address |
| CNAME | Alias of one domain to another |
| MX | Mail exchange record |
| TXT | Text information for outside sources |
| NS | Name server records |
| SOA | Start of Authority |
| PTR | Maps an IP address to a domain name (reverse lookup) |

#### DNS Resolution Process

1. User enters a URL in the browser
2. If the requested record is in local cache, it's used
3. If not cached, request goes to recursive DNS resolver
4. Resolver queries the root nameserver
5. Root server responds with the TLD (Top-Level Domain) nameserver address
6. Resolver queries the TLD nameserver
7. TLD nameserver provides the authoritative nameserver address
8. Resolver queries the authoritative nameserver
9. Authoritative nameserver provides the IP address for the domain
10. Resolver returns the IP to the browser
11. Browser establishes a connection with the server

### Load Balancing

Load balancing is the process of distributing network traffic across multiple servers to ensure no single server bears too much demand.

#### Load Balancing Algorithms

| Algorithm | Description |
|-----------|-------------|
| Round Robin | Requests are distributed sequentially to each server |
| Least Connections | New requests go to the server with the fewest current connections |
| IP Hash | Client's IP address determines which server receives the request (session persistence) |
| Weighted Round Robin | Servers with higher capacities receive more requests |
| Weighted Least Connections | Combines least connections with server capacity considerations |
| Resource-Based | Distributes load based on current server resource usage |

#### Load Balancer Types

**Hardware Load Balancers:**
- Purpose-built appliances
- High performance
- Expensive
- Examples: F5 BIG-IP, Citrix ADC

**Software Load Balancers:**
- Software applications
- More flexible
- Cost-effective
- Examples: HAProxy, Nginx, Apache mod_proxy

**Cloud Load Balancers:**
- Managed services by cloud providers
- Highly scalable
- Pay-as-you-go pricing
- Examples: AWS ELB, GCP Load Balancing, Azure Load Balancer

### Database Replication

Database replication is the process of copying data from one database server (primary) to one or more other database servers (replicas).

#### Primary-Replica (Master-Slave) Setup

| Primary Node | Replica Node |
|--------------|--------------|
| Handles write operations | Primarily handles read operations |
| Replicates changes to replicas | Receives updates from primary |
| Single source of truth | Can be promoted to primary if needed |
| Failure impacts write availability | Failure impacts read scalability |

#### Benefits of Database Replication

- **High Availability**: If the primary database fails, a replica can be promoted
- **Load Distribution**: Read queries can be distributed across replicas
- **Data Backup**: Replicas provide additional data backup
- **Geographical Distribution**: Replicas can be placed closer to users for faster access

### Security Components

#### Firewall

A firewall is a network security device that monitors and filters incoming and outgoing network traffic based on predetermined security rules.

**Types of Firewalls:**
- **Network Firewalls**: Filter traffic between networks
- **Host-Based Firewalls**: Run on individual hosts/servers
- **Next-Generation Firewalls (NGFW)**: Combine traditional firewalls with additional functionality
- **Web Application Firewalls (WAF)**: Specifically protect web applications

#### SSL/TLS Certificate

Secure Sockets Layer (SSL) and Transport Layer Security (TLS) are protocols for establishing authenticated and encrypted links between networked computers.

**Benefits of SSL/TLS:**
- Encrypts data in transit
- Provides authentication
- Ensures data integrity
- Builds user trust
- Required for PCI compliance

#### HTTPS

HTTPS (Hypertext Transfer Protocol Secure) is an extension of HTTP that uses SSL/TLS for secure communication over a computer network.

**Implementation Steps:**
1. Obtain an SSL/TLS certificate from a Certificate Authority (CA)
2. Install the certificate on your web server
3. Configure the web server to use HTTPS
4. Set up redirects from HTTP to HTTPS
5. Implement HSTS (HTTP Strict Transport Security) for added security

### Monitoring

Monitoring is the process of observing and tracking the performance and state of servers, applications, and infrastructure components.

#### Monitoring Types

| Type | Description | Examples |
|------|-------------|----------|
| **Infrastructure Monitoring** | Tracks hardware, network, and system metrics | CPU usage, memory usage, disk space, network traffic |
| **Application Performance Monitoring (APM)** | Tracks application performance and behavior | Response time, error rates, throughput, resource usage |
| **Log Monitoring** | Analyzes log files for patterns and issues | Error logs, access logs, system logs |
| **Uptime Monitoring** | Checks if services and websites are available | Ping tests, HTTP requests, TCP port checks |
| **Security Monitoring** | Detects security threats and vulnerabilities | Intrusion detection, anomaly detection |

#### Popular Monitoring Tools

- **Prometheus**: Open-source monitoring and alerting toolkit
- **Grafana**: Visualization and dashboard platform
- **Nagios**: Network monitoring system
- **Zabbix**: Enterprise-class monitoring solution
- **Datadog**: Cloud monitoring as a service
- **New Relic**: Application performance monitoring
- **ELK Stack (Elasticsearch, Logstash, Kibana)**: Log monitoring and analysis
- **SumoLogic**: Cloud-native monitoring and log management

## Infrastructure Design Best Practices

### High Availability Design

High Availability (HA) is a characteristic of a system that aims to ensure an agreed level of operational performance, usually uptime, for a higher than normal period.

**Key Components:**
1. **Redundancy**: Multiple instances of critical components
2. **Failover**: Automatic switching to redundant components
3. **Load Balancing**: Distribution of traffic across multiple servers
4. **Data Replication**: Multiple copies of data across different systems
5. **Geographic Distribution**: Components distributed across multiple locations

**Common HA Configurations:**
- **Active-Active**: All servers actively handle traffic
- **Active-Passive**: Standby servers take over when active servers fail

### Scalability Approaches

Scalability is the capability of a system to handle a growing amount of work by adding resources to the system.

#### Vertical Scaling (Scale Up)

Increasing the resources (CPU, RAM, storage) of existing servers.

**Advantages:**
- Simpler to implement
- No application changes required
- Reduced software licensing costs

**Disadvantages:**
- Hardware limits
- Single point of failure remains
- Downtime during upgrades
- Cost increases exponentially

#### Horizontal Scaling (Scale Out)

Adding more servers to distribute the load.

**Advantages:**
- Near-linear cost scaling
- No theoretical limit to scaling
- Better fault tolerance
- Can scale dynamically

**Disadvantages:**
- More complex architecture
- May require application modifications
- More network complexity
- More hardware/instances to manage

### Single Points of Failure (SPOF)

A single point of failure is a component of a system that, if it fails, will cause the entire system to fail.

**Common SPOFs in Web Infrastructure:**
- Single web server
- Single database server
- Single load balancer
- Single network connection
- Single power supply
- Single domain name server

**Mitigation Strategies:**
- Implement redundancy for critical components
- Use load balancers with failover capabilities
- Set up database replication
- Deploy across multiple availability zones/regions
- Implement backup systems and procedures
- Create disaster recovery plans

## Resources

* [Web Architecture 101](https://engineering.videoblocks.com/web-architecture-101-a3224e126947)
* [System Design Primer](https://github.com/donnemartin/system-design-primer)
* [High Availability Concepts](https://www.digitalocean.com/community/tutorials/what-is-high-availability)
* [Load Balancing Algorithms](https://www.nginx.com/resources/glossary/load-balancing/)
* [Database Replication Explained](https://dev.mysql.com/doc/refman/8.0/en/replication.html)
* [DNS Configuration Guide](https://www.cloudflare.com/learning/dns/what-is-dns/)
* [Web Server vs. Application Server](https://www.nginx.com/resources/glossary/application-server-vs-web-server/)
* [Introduction to Firewall Security](https://www.cisco.com/c/en/us/products/security/firewalls/what-is-a-firewall.html)
* [SSL/TLS and HTTPS Overview](https://www.ssl.com/faqs/what-is-ssl/)
* [Monitoring Best Practices](https://sematext.com/blog/monitoring-best-practices/)

---

*Project by ALX System Engineering & DevOps*
