# 0x10. HTTPS SSL

<p align="center">
  <img src="https://img.shields.io/badge/HTTPS-Security-green.svg" alt="HTTPS Security">
  <img src="https://img.shields.io/badge/SSL/TLS-Encryption-blue.svg" alt="SSL/TLS Encryption">
  <img src="https://img.shields.io/badge/HAProxy-Configuration-orange.svg" alt="HAProxy Configuration">
  <img src="https://img.shields.io/badge/DNS-Management-red.svg" alt="DNS Management">
</p>

## Project Overview

This repository focuses on implementing secure web infrastructure with HTTPS/SSL. It covers domain and subdomain configuration, SSL termination with HAProxy, HTTP to HTTPS redirection, and analyzing DNS records. These skills are essential for securing web traffic, protecting user data, and establishing trusted connections between clients and servers.

## Background Context

When you access websites today, particularly those that handle sensitive information like credentials, payment details, or private communications, you'll notice their URLs start with `https://` rather than `http://`. The 'S' stands for 'Secure' and indicates that all communications between your browser and the website are encrypted.

In this project, you will implement SSL termination using HAProxy and configure your web infrastructure to handle HTTPS traffic. You'll also learn how to enforce HTTPS by redirecting all HTTP traffic to HTTPS.

## Concepts

For this project, you should understand:
* DNS
* Web stack debugging
* HTTPS SSL
* SSL termination
* Load balancers
* Domain and subdomain configuration

## Requirements

* Ubuntu 20.04 LTS
* All Bash scripts must be executable
* Bash scripts must pass Shellcheck without any errors
* The first line of all Bash scripts should be `#!/usr/bin/env bash`
* The second line of all Bash scripts should be a comment explaining what the script does
* All files should have the correct permissions
* HAProxy configuration must follow best practices for security

## Project Tasks

### 0. World wide web
**[0-world_wide_web](0-world_wide_web)**

Requirements:
- Configure your domain zone with the following subdomains:
  * www: points to your lb-01 server
  * lb-01: points to your load balancer
  * web-01: points to your web-01 server
  * web-02: points to your web-02 server
- Write a Bash script that will display information about subdomains
- When passed a domain and subdomain parameter, the script shows specific information about that subdomain
- When only passed a domain parameter, it shows information about the default subdomains (www, lb-01, web-01, web-02)
- Output format: `The subdomain [SUB_DOMAIN] is a [RECORD_TYPE] record and points to [DESTINATION]`

```bash
#!/usr/bin/env bash
# Bash script that will display information about subdomains.

function domain_check {
	domain_names=("www" "lb-01" "web-01" "web-02")

	for i in "${domain_names[@]}";
	do
		dig "${i}"."$1" | grep -A1 'ANSWER SECTION:' | \
		awk 'FNR == 2 {printf "The subdomain %s is a %s record and points to %s\n", var, $4, $5}' var="$i"
	done
}

function subdomain_check {
	dig "${2}"."$1" | grep -A1 'ANSWER SECTION:' | \
	awk 'FNR == 2 {printf "The subdomain %s is a %s record and points to %s\n", var, $4, $5}' var="$2"
}


if [ $# -lt 1 ]
then
	echo "*** Provide domain name ***"
elif [ $# -eq 1 ]
then
	domain_check "$1";
else
	subdomain_check "$1" "$2";
fi
```

### 1. HAProxy SSL termination
**[1-haproxy_ssl_termination](1-haproxy_ssl_termination)**

Requirements:
- Create a certificate using certbot and configure HAProxy to accept encrypted traffic for your subdomain www
- HAProxy should be listening on port TCP 443
- HAProxy should be accepting SSL traffic
- HAProxy should serve encrypted traffic that will return the / of your web server
- When querying the root of your domain name, the page returned should contain "Hello World!"
- Share your HAProxy config as an answer file (1-haproxy_ssl_termination)

```
global
        log /dev/log    local0
        log /dev/log    local1 notice
        chroot /var/lib/haproxy
        stats socket /run/haproxy/admin.sock mode 660 level admin
        stats timeout 30s
        user haproxy
        group haproxy
        daemon

        # Default SSL material locations
        ca-base /etc/ssl/certs
        crt-base /etc/ssl/private

        # See: https://ssl-config.mozilla.org/#server=haproxy&server-version=2.0.3&config=intermediate
        ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
        ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
        ssl-default-bind-options ssl-min-ver TLSv1.2 no-tls-tickets

defaults
        log     global
        mode    http
        option  httplog
        option  dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
        errorfile 400 /etc/haproxy/errors/400.http
        errorfile 403 /etc/haproxy/errors/403.http
        errorfile 408 /etc/haproxy/errors/408.http
        errorfile 500 /etc/haproxy/errors/500.http
        errorfile 502 /etc/haproxy/errors/502.http
        errorfile 503 /etc/haproxy/errors/503.http
        errorfile 504 /etc/haproxy/errors/504.http

frontend paycheap-tech-frontend
        bind *:80
        bind *:443 ssl crt /etc/haproxy/certs/paycheap.tech.pem
        http-request set-header X-Forwarded-Proto https
        default_backend paycheap-tech-backend

backend paycheap-tech-backend
        balance roundrobin
        server 207600-web-01 52.201.190.114:80 check
        server 207600-web-02 52.86.172.121:80 check
```

### 2. No loophole in your website traffic
**[100-redirect_http_to_https](100-redirect_http_to_https)**

Requirements:
- Configure HAProxy to automatically redirect HTTP traffic to HTTPS
- This should be transparent to the user
- HAProxy should return a 301 for all HTTP traffic

```
# HAProxy configuration with HTTP to HTTPS redirection
```

## SSL/TLS Concepts

### What is HTTPS?

HTTPS (Hypertext Transfer Protocol Secure) is an extension of HTTP that uses encryption for secure communication over a computer network. It provides:

1. **Data Encryption**: All data transferred between the client and server is encrypted, protecting against eavesdropping
2. **Data Integrity**: Ensures data hasn't been modified during transmission
3. **Authentication**: Verifies the identity of the website, preventing man-in-the-middle attacks

### SSL vs TLS

- **SSL (Secure Sockets Layer)**: The original protocol for secure communication, now deprecated (SSL 2.0 and 3.0)
- **TLS (Transport Layer Security)**: The successor to SSL, with TLS 1.2 and 1.3 being the modern secure standards

While people often still say "SSL certificates," most modern implementations actually use TLS protocols.

### Certificate Authorities and Trust

SSL/TLS certificates are issued by Certificate Authorities (CAs) that verify the identity of the certificate holder. Popular CAs include:

- Let's Encrypt (free)
- DigiCert
- Comodo
- GlobalSign
- Symantec

Browsers maintain a list of trusted CAs and will show a warning if a site uses a certificate from an untrusted authority.

### Types of SSL Certificates

| Certificate Type | Description |
|------------------|-------------|
| Domain Validation (DV) | Basic verification of domain ownership |
| Organization Validation (OV) | Verifies organization information |
| Extended Validation (EV) | Highest level of validation (green address bar) |
| Wildcard Certificates | Covers a domain and all its subdomains |
| Multi-Domain (SAN) | Covers multiple domain names |

### SSL Termination

SSL termination is the process of decrypting encrypted traffic before passing it to a web server. It's typically implemented at the load balancer level to:

1. Reduce CPU load on backend servers
2. Centralize certificate management
3. Allow the load balancer to inspect and route traffic based on HTTP headers
4. Simplify certificate renewal processes

## HAProxy SSL Configuration

### Basic SSL Termination

To configure HAProxy for SSL termination, you need:

1. A valid SSL certificate (.crt file)
2. A private key (.key file)
3. A PEM file that combines both (often with the .pem extension)

The basic configuration includes:

```
frontend https_front
    bind *:443 ssl crt /path/to/certificate.pem
    http-request set-header X-Forwarded-Proto https
    default_backend web_servers
```

### HTTP to HTTPS Redirection

To force all traffic to use HTTPS, add a redirection rule:

```
frontend http_front
    bind *:80
    http-request redirect scheme https unless { ssl_fc }
```

The `{ ssl_fc }` condition checks if the connection is already using SSL/TLS.

### Certificate Bundle Creation

To create a PEM file from certificate and key files:

```bash
cat your_domain.crt your_domain.key > your_domain.pem
```

Make sure the file permissions are set correctly:

```bash
chmod 600 your_domain.pem
```

## DNS and Subdomains

### What is a Subdomain?

A subdomain is a domain that is part of a larger domain. For example, in `blog.example.com`:
- `example.com` is the domain
- `blog` is the subdomain

Subdomains are useful for organizing content and services within a domain.

### Common DNS Record Types

| Record Type | Purpose |
|-------------|---------|
| A | Maps a domain to an IPv4 address |
| AAAA | Maps a domain to an IPv6 address |
| CNAME | Maps a domain to another domain (alias) |
| MX | Specifies mail servers for the domain |
| TXT | Stores text information (often for verification) |
| NS | Delegates a DNS zone to use the given name servers |
| SOA | Specifies authoritative information about the domain |

### DNS Propagation

When you make changes to DNS records, it can take time for these changes to propagate across the internet. This delay is due to DNS caching and can range from minutes to 48 hours, depending on the TTL (Time To Live) values set in your DNS records.

## Domain Analysis Tools

### dig Command

The `dig` (Domain Information Groper) command is a flexible tool for interrogating DNS name servers. Basic syntax:

```bash
dig example.com [record-type]
```

Common options:
- `+short`: Display a terse answer
- `+noall +answer`: Show only the answer section
- `@nameserver`: Query a specific nameserver

### Host Command

The `host` command is a simpler DNS lookup utility:

```bash
host example.com
```

### nslookup Command

`nslookup` is an interactive DNS query tool:

```bash
nslookup example.com
```

## Security Best Practices

1. **Use Modern TLS Versions**: Configure servers to use TLS 1.2 or 1.3 only
2. **Implement Strong Cipher Suites**: Use strong, secure cipher suites and disable weak ones
3. **Enable HSTS**: HTTP Strict Transport Security forces browsers to use HTTPS
4. **Secure Cookies**: Set the Secure and HttpOnly flags on cookies
5. **Certificate Monitoring**: Set up monitoring for certificate expiration
6. **Regular Updates**: Keep SSL/TLS libraries updated to patch vulnerabilities
7. **OCSP Stapling**: Improve performance and privacy of certificate validation
8. **CAA Records**: Specify which CAs can issue certificates for your domain

## Resources

* [What is HTTPS?](https://www.cloudflare.com/learning/ssl/what-is-https/)
* [What are SSL/TLS certificates?](https://www.digicert.com/what-is-an-ssl-certificate)
* [HAProxy SSL Termination](https://www.haproxy.com/blog/haproxy-ssl-termination/)
* [SSL Server Test](https://www.ssllabs.com/ssltest/)
* [How to create an SSL certificate on HAProxy](https://serversforhackers.com/c/using-ssl-certificates-with-haproxy)
* [The OCSP protocol](https://en.wikipedia.org/wiki/Online_Certificate_Status_Protocol)
* [HTTP Strict Transport Security (HSTS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security)
* [Let's Encrypt](https://letsencrypt.org/)
* [Dig Command examples](https://www.thegeekstuff.com/2012/02/dig-command-examples/)

---

*Project by ALX System Engineering & DevOps*
