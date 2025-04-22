# 0x0F. Load balancer

<p align="center">
  <img src="https://img.shields.io/badge/HAProxy-Load_Balancer-green.svg" alt="HAProxy Load Balancer">
  <img src="https://img.shields.io/badge/Nginx-Web_Server-blue.svg" alt="Nginx Web Server">
  <img src="https://img.shields.io/badge/HTTP-Headers-orange.svg" alt="HTTP Headers">
  <img src="https://img.shields.io/badge/High-Availability-red.svg" alt="High Availability">
</p>

## Project Overview

This repository focuses on implementing load balancing and high availability in web infrastructure. The project covers configuring multiple web servers with custom HTTP headers and setting up a HAProxy load balancer to distribute traffic between them using a round-robin algorithm. These techniques are essential for creating scalable, reliable web applications capable of handling high traffic.

## Background Context

In this project, you'll be implementing a load balancing setup using HAProxy. You'll have two servers, one additional for the load balancer, and need to implement redundancy for your web servers. You will also need to add a custom HTTP header to your Nginx web servers to track which server is responding to requests.

Your infrastructure will look like this:
```
                  +--------+
                  | Client |
                  +--------+
                      |
                      v
                +------------+
                | HAProxy LB |
                +------------+
                 /          \
                /            \
               v              v
        +-----------+    +-----------+
        | Web-01    |    | Web-02    |
        | (Nginx)   |    | (Nginx)   |
        +-----------+    +-----------+
```

## Requirements

* Ubuntu 20.04 LTS
* All Bash scripts must be executable
* Bash scripts must pass Shellcheck without any errors
* The first line of all Bash scripts should be `#!/usr/bin/env bash`
* The second line of all Bash scripts should be a comment explaining what the script does
* All servers are configured according to project requirements
* All files need to have the proper permissions

## Project Tasks

### 0. Double the number of webservers
**[0-custom_http_response_header](0-custom_http_response_header)**

Requirements:
- Configure Nginx on `web-01` and `web-02` to include a custom HTTP header
- The custom HTTP header must be named `X-Served-By`
- The value of the custom HTTP header must be the hostname of the server Nginx is running on
- Write a Bash script that configures a new Ubuntu machine with these requirements

```bash
#!/usr/bin/env bash
# Installs Nginx with the following configurations:
#+    Listens on port 80.
#+    Returns a page containing "Hello World" when queried
#+     at the root with a curl GET request.
#+    Configures /redirect_me as a "301 Moved Permanently".
#+    Includes a custom 404 page containing "Ceci n'est pas une page".
#+    Contains a custom HTTP header named X-Served-By.
#+    The value of the HTTP header is the hostname of the running server.

apt-get update
apt-get install -y nginx

mkdir -p /var/www/html
touch /var/www/html/index.html
echo "Hello World" > /var/www/html/index.html
touch /var/www/html/404.html
echo "Page not found" > /var/www/html/404.html

printf %s "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm;

    location /redirect_me {
        return 301 http://cuberule.com/;
    }

    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}" > /etc/nginx/sites-available/default

service nginx restart
```

### 1. Install your load balancer
**[1-install_load_balancer](1-install_load_balancer)**

Requirements:
- Install and configure HAProxy on your `lb-01` server
- Configure HAProxy to send traffic to `web-01` and `web-02` using a round-robin algorithm
- Ensure that HAProxy can be managed via an init script
- Make sure that your servers are configured with the right hostnames: `[STUDENT_ID]-web-01` and `[STUDENT_ID]-web-02`
- Write a Bash script that configures a new Ubuntu machine with these requirements

```bash
#!/usr/bin/env bash
# Configure Nginx so that its HTTP response contains
# a custom header
#
balancer="\
frontend haproxy_balancer
    bind *:80
    mode http
    default_backend webservers
    
backend webservers
    balance roundrobin
    server 207600-web-01 52.201.190.114:80 check
    server 207600-web-02 52.86.172.121:80 check
"
# Update packages
apt-get -y update
apt-get -y upgrade

# Add HAProxy PPA
apt-get -y install software-properties-common
add-apt-repository -y ppa:vbernat/haproxy-2.5
apt-get -y update

# Install HAProxy
apt-get -y install haproxy
cp -a /etc/haproxy/haproxy.cfg{,.orig}
echo "$balancer" >> /etc/haproxy/haproxy.cfg
service haproxy restart
```

## Load Balancing Concepts

### What is Load Balancing?

Load balancing is the process of distributing network traffic across multiple servers to ensure no single server bears too much demand. This improves the:

- **Reliability**: If one server fails, others can handle the traffic
- **Scalability**: You can add or remove servers as demand changes
- **Performance**: Traffic distribution prevents any one server from becoming a bottleneck
- **Efficiency**: Resources are utilized more effectively

### Load Balancing Algorithms

HAProxy supports several load balancing algorithms:

| Algorithm | Description |
|-----------|-------------|
| Round Robin | Requests are distributed sequentially to each server in turn |
| Least Connections | New requests are sent to the server with the fewest active connections |
| Source IP Hash | Uses the client's IP address to determine which server to send them to (session persistence) |
| URI Hash | Distributes requests based on the URI requested |
| Random | Randomly selects a server for each new request |
| Weight-based | Distributes requests according to assigned server weights |

In this project, we use the Round Robin algorithm, which is simple and effective for most use cases with similar server capabilities.

### High Availability vs. Load Balancing

- **High Availability**: Ensures that a service remains available by eliminating single points of failure
- **Load Balancing**: Distributes traffic evenly across multiple servers

While these concepts are related, they serve different purposes. Load balancing is one technique used to achieve high availability, but a complete high availability solution might also include:

- Redundant load balancers
- Failover mechanisms
- Data replication
- Geographical distribution

### Custom HTTP Headers

HTTP headers allow the client and server to pass additional information with an HTTP request or response. Custom headers are prefixed with "X-" and can be used for:

- **Server Identification**: Tracking which server processed a request
- **Debugging**: Providing additional information for troubleshooting
- **Analytics**: Collecting data about request routing
- **Security**: Adding custom security controls

In this project, we add an "X-Served-By" header to identify which server processed each request, which is helpful for debugging and monitoring load balancer effectiveness.

## HAProxy Configuration

### Basic HAProxy Structure

HAProxy configurations typically consist of these sections:

1. **global**: Process-wide settings
2. **defaults**: Default parameters for all sections
3. **frontend**: Defines how requests are forwarded to backends
4. **backend**: Defines a group of servers to handle forwarded requests
5. **listen**: Combines frontend and backend in one section (optional)

### Frontend Configuration

```
frontend haproxy_balancer
    bind *:80         # Listen on all IPs on port 80
    mode http         # Layer 7 mode
    default_backend webservers  # Default backend if no rules match
```

### Backend Configuration

```
backend webservers
    balance roundrobin                                 # Load balancing algorithm
    server web-01 web-01.example.com:80 check          # First server
    server web-02 web-02.example.com:80 check          # Second server
```

### Health Checks

HAProxy performs health checks on backend servers to determine if they're available. The `check` parameter enables this feature. You can customize health checks with:

- `check interval <time>`: How often to check
- `rise <count>`: Number of successful checks before server is marked up
- `fall <count>`: Number of failed checks before server is marked down
- `timeout check <time>`: Timeout for health checks

### HAProxy Statistics

HAProxy provides a statistics dashboard that can be enabled with:

```
listen stats
    bind :9000
    stats enable
    stats uri /stats
    stats refresh 5s
    stats auth admin:password  # Optional authentication
```

## Nginx HTTP Headers Configuration

### Adding Custom Headers in Nginx

Custom headers can be added in Nginx using the `add_header` directive:

```nginx
add_header X-Served-By $hostname;
```

This directive can be placed in:
- http context (applies to all servers)
- server context (applies to a specific server)
- location context (applies to specific locations)

### Using Server Variables

Nginx provides several variables that can be used in header values:

- `$hostname`: The machine's hostname
- `$server_addr`: The server's IP address
- `$server_name`: The matched server name
- `$server_port`: The server port
- `$remote_addr`: The client's IP address

### Testing HTTP Headers

You can verify that headers are being sent properly using:

```bash
curl -I example.com
```

The `-I` flag shows only the response headers, allowing you to verify your custom header is present.

## Resources

* [Introduction to load-balancing and HAProxy](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts)
* [HTTP header](https://www.techopedia.com/definition/27178/http-header)
* [Debian/Ubuntu HAProxy packages](https://haproxy.debian.net/)
* [HAProxy Configuration Manual](https://cbonte.github.io/haproxy-dconv/2.5/configuration.html)
* [Nginx Custom Headers](https://nginx.org/en/docs/http/ngx_http_headers_module.html)
* [How to Install and Configure HAProxy](https://www.digitalocean.com/community/tutorials/how-to-use-haproxy-to-set-up-http-load-balancing-on-an-ubuntu-vps)
* [Understanding High Availability](https://www.digitalocean.com/community/tutorials/what-is-high-availability)
* [Load Balancing Algorithms: How They Work](https://haproxy.com/blog/load-balancing-algorithms/)

---

*Project by ALX System Engineering & DevOps*
