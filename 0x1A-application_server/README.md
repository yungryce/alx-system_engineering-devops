# Application Server

<p align="center">
  <img src="https://img.shields.io/badge/Nginx-Reverse_Proxy-green.svg" alt="Nginx Reverse Proxy">
  <img src="https://img.shields.io/badge/Gunicorn-WSGI_Server-blue.svg" alt="Gunicorn WSGI Server">
  <img src="https://img.shields.io/badge/Flask-API_Development-red.svg" alt="Flask API Development">
  <img src="https://img.shields.io/badge/Systemd-Service_Management-orange.svg" alt="Systemd Service Management">
</p>

## Project Overview

This project focuses on adding an application server to our web infrastructure to serve dynamic content for the AirBnB clone project. We configure Nginx as a reverse proxy to direct requests to Gunicorn, a WSGI HTTP server that runs our Python Flask application. This implementation adds a critical layer to our web stack that sits between the web server and the application codebase, improving scalability, resource management, and deployment capabilities.

## Learning Objectives

By the end of this project, you should be able to explain:

* What an application server is and its role in web architecture
* The difference between web servers and application servers
* How to configure Nginx as a reverse proxy
* How to deploy Flask applications with Gunicorn
* How to manage processes with systemd
* How to implement zero-downtime deployments
* How to configure server blocks and routes in Nginx
* How to manage environment variables for applications
* Best practices for application server deployment
* How to structure and maintain web application infrastructure

## Requirements

* Ubuntu 16.04 LTS
* Nginx must be installed and configured
* All configuration files should be stored in their respective directories
* All Bash scripts must be executable (`chmod +x filename`)
* Bash scripts must pass shellcheck without any errors
* The first line of all Bash scripts should be `#!/usr/bin/env bash`
* A README.md file at the root of the project directory is mandatory

## Project Tasks

### 0. Set up development with Python

Set up development environment for the AirBnB clone on web-01 server with Flask and serve a basic page from the route `/airbnb-onepage/`.

### 1. Set up production with Gunicorn

Install Gunicorn and configurations needed to serve the same page from Flask application.

### 2. Serve a page with Nginx
**[2-app_server-nginx_config](2-app_server-nginx_config)**

Configure Nginx to serve the page from the route `/airbnb-onepage/` by proxying requests to Gunicorn.

Example Nginx configuration:
```nginx
location /airbnb-onepage/ {
    proxy_pass http://127.0.0.1:5000/airbnb-onepage/;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
}
```

### 3. Add a route with query parameters
**[3-app_server-nginx_config](3-app_server-nginx_config)**

Configure Nginx to proxy requests to the route `/airbnb-dynamic/number_odd_or_even/<int:n>` to a Gunicorn instance listening on port 5001.

This configuration adds support for dynamic routes with parameters:
```nginx
location /airbnb-dynamic/ {
    proxy_pass http://127.0.0.1:5001/;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
}
```

### 4. Serve your API
**[4-app_server-nginx_config](4-app_server-nginx_config)**

Configure Nginx to proxy requests to the AirBnB API endpoints to a Gunicorn instance listening on port 5002.

API endpoints are served through a dedicated configuration:
```nginx
location /api/ {
    proxy_pass http://127.0.0.1:5002/api/;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
}
```

### 5. Serve your AirBnB clone
**[5-app_server-nginx_config](5-app_server-nginx_config)**

Configure Nginx to serve the complete AirBnB clone web application from Gunicorn.

The complete application configuration includes static assets and multiple endpoints:
```nginx
location / {
    proxy_pass http://127.0.0.1:5003/;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
}

location /static/ {
    alias /path/to/application/static/;
}
```

### 6. Deploy it!
**[gunicorn.service](gunicorn.service)**

Create a systemd configuration file to manage the Gunicorn application process, ensuring it starts on boot and can be managed with systemd commands.

Example systemd service:
```ini
[Unit]
Description=Gunicorn instance to serve AirBnB clone
After=network.target

[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/path/to/application
Environment="PATH=/path/to/application/venv/bin"
ExecStart=/path/to/application/venv/bin/gunicorn --workers 3 --bind 0.0.0.0:5003 web_dynamic.2-hbnb:app
Restart=always

[Install]
WantedBy=multi-user.target
```

### 7. No service interruption
**[4-reload_gunicorn_no_downtime](4-reload_gunicorn_no_downtime)**

Create a script to reload Gunicorn in a graceful way, without service interruption.

The zero-downtime reload script uses signals to gracefully restart workers:
```bash
#!/usr/bin/env bash
# Gracefully reloads Gunicorn processes without downtime

pkill -HUP gunicorn
```

## Application Server Architecture

### What Is an Application Server?

An application server is a software framework dedicated to the efficient execution of procedures (programs, routines, scripts) for supporting the construction and running of applications. It provides an environment where applications can run, regardless of what the end user is doing.

In web infrastructure, application servers:
- Execute application logic
- Generate dynamic content
- Handle business processes
- Interact with databases and other backend services
- Process user input and authentication
- Serve the output to web servers for delivery to clients

### Nginx + Gunicorn + Flask Architecture

The architecture used in this project follows a common pattern for Python web applications:

1. **Nginx** serves as the front-facing web server, handling:
   - HTTP/HTTPS connections
   - SSL termination
   - Static file serving
   - Request routing
   - Load balancing
   - Security features

2. **Gunicorn** acts as the WSGI application server:
   - Manages Python processes
   - Handles concurrent requests
   - Provides worker management
   - Offers process monitoring
   - Implements graceful reloads

3. **Flask** provides the application framework:
   - Defines application routes
   - Implements application logic
   - Renders templates
   - Manages sessions
   - Handles application state

### Benefits of This Architecture

This separation of concerns provides several advantages:

- **Scalability**: Components can be scaled independently
- **Security**: Nginx handles security concerns before requests reach application
- **Performance**: Static assets are served efficiently by Nginx
- **Reliability**: Crashes in application code won't bring down the web server
- **Flexibility**: Components can be updated or replaced independently
- **Developer Experience**: Simplified development and deployment workflow

## Systemd Service Management

### Creating a Systemd Service

Systemd is a system and service manager for Linux operating systems. Creating a systemd service for Gunicorn provides several benefits:

1. **Automatic startup**: Service starts automatically on system boot
2. **Dependency management**: Service starts after required services
3. **Restart policies**: Automatic recovery from crashes
4. **Resource control**: CPU and memory limits can be applied
5. **Logging integration**: Output is sent to the system journal

### Managing Services with Systemd

Common systemd commands for service management:

```bash
# Start the service
sudo systemctl start gunicorn.service

# Check status
sudo systemctl status gunicorn.service

# Enable on boot
sudo systemctl enable gunicorn.service

# Restart the service
sudo systemctl restart gunicorn.service

# Stop the service
sudo systemctl stop gunicorn.service

# View logs
sudo journalctl -u gunicorn.service
```

## Zero-Downtime Deployment

Zero-downtime deployment allows updating applications without interrupting user sessions or dropping requests. The key techniques used in this project are:

1. **Graceful worker replacement**: Workers finish processing current requests before shutting down
2. **Signal handling**: Using the HUP signal to trigger graceful reloads
3. **Process management**: Proper master and worker process configuration
4. **Health checks**: Ensuring new workers are ready before retiring old ones

The implementation uses the `pkill -HUP gunicorn` command to send the SIGHUP signal to Gunicorn's master process, which then:

1. Loads the new application code
2. Starts new worker processes with the updated code
3. Allows existing workers to finish processing current requests
4. Gradually shuts down old workers
5. Completes the transition with no dropped requests

## Nginx Configuration Best Practices

When configuring Nginx as a reverse proxy for application servers, follow these best practices:

1. **Separate Config Files**: Use separate configuration files for each server block in `/etc/nginx/sites-available/`
2. **Enable Configs**: Create symbolic links in `/etc/nginx/sites-enabled/` to enable configurations
3. **Test Before Reloading**: Use `nginx -t` to test configuration before applying changes
4. **Buffer Settings**: Optimize buffer sizes for your application's needs
   ```nginx
   proxy_buffer_size 128k;
   proxy_buffers 4 256k;
   proxy_busy_buffers_size 256k;
   ```
5. **Timeouts**: Configure appropriate timeouts for your application
   ```nginx
   proxy_connect_timeout 75s;
   proxy_read_timeout 300s;
   ```
6. **Headers**: Pass necessary headers to the application server
   ```nginx
   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
   proxy_set_header X-Forwarded-Proto $scheme;
   ```
7. **HTTPS**: Configure SSL/TLS for secure connections
8. **Compression**: Enable Gzip compression for text-based responses
9. **Caching**: Implement appropriate caching headers and proxy caching

## Deploying Flask Applications with Gunicorn

### Gunicorn Configuration Options

Gunicorn provides many configuration options for optimizing application performance:

- **Workers**: `--workers` determines the number of worker processes
- **Worker Type**: `--worker-class` selects the type of workers (sync, gevent, etc.)
- **Threads**: `--threads` sets the number of threads per worker
- **Binding**: `--bind` sets the address and port to bind
- **Timeout**: `--timeout` sets worker timeout in seconds
- **Max Requests**: `--max-requests` limits requests before worker restart
- **Access Log**: `--access-logfile` configures access log location
- **Error Log**: `--error-logfile` configures error log location

### Environment Variables

Environment variables are used to configure the application without changing code. For Flask applications, common variables include:

- `FLASK_APP`: The Flask application entry point
- `FLASK_ENV`: The environment (development, production)
- `DATABASE_URL`: Database connection string
- `SECRET_KEY`: Secret key for sessions and security
- `FLASK_CONFIG`: Configuration profile to use

In this project, the AirBnB clone application uses specific environment variables:

```bash
HBNB_ENV=production
HBNB_MYSQL_USER=hbnb_dev
HBNB_MYSQL_PWD=hbnb_dev_pwd
HBNB_MYSQL_HOST=localhost
HBNB_MYSQL_DB=hbnb_dev_db
HBNB_TYPE_STORAGE=db
```

## Starting a Gunicorn Instance

You can start a Gunicorn instance in a tmux session using the following command:

```bash
tmux new-session -d -s my_gunicorn_session 'HBNB_ENV=test \
HBNB_MYSQL_USER=hbnb_dev \
HBNB_MYSQL_PWD=hbnb_dev_pwd \
HBNB_MYSQL_HOST=localhost \
HBNB_MYSQL_DB=hbnb_dev_db \
HBNB_TYPE_STORAGE=db \
gunicorn --bind 0.0.0.0:5002 api.v1.app:app'
```

## Resources

* [Application Server vs Web Server](https://www.nginx.com/resources/glossary/application-server-vs-web-server/)
* [How to use Nginx as a reverse proxy](https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-server-blocks-virtual-hosts-on-ubuntu-16-04)
* [Gunicorn documentation](https://docs.gunicorn.org/en/stable/)
* [Systemd service configuration](https://www.freedesktop.org/software/systemd/man/systemd.service.html)
* [Flask deployment options](https://flask.palletsprojects.com/en/2.0.x/deploying/)
* [Nginx location blocks explained](https://www.digitalocean.com/community/tutorials/understanding-nginx-server-and-location-block-selection-algorithms)
* [Zero-downtime deployments with Gunicorn](https://docs.gunicorn.org/en/stable/signals.html)
* [Configuring logging with Gunicorn](https://docs.gunicorn.org/en/stable/settings.html#logging)
* [The Twelve-Factor App](https://12factor.net/)

---

*Project by ALX System Engineering & DevOps*

