# Project Manifest: Application Server

## Project Identity
- **Name**: Application Server
- **Type**: Educational
- **Scope**: Web Infrastructure Configuration
- **Status**: Completed

## Technology Signature
- **Core**: Nginx, Gunicorn
- **Environment**: Ubuntu 16.04 LTS
- **Configuration Languages**: Nginx Config, Bash, Systemd Unit
- **Application Runtime**: Python, Flask, WSGI
- **Process Management**: Systemd, Tmux

## Demonstrated Competencies
- Nginx Reverse Proxy Configuration
- Gunicorn WSGI Server Deployment
- Flask Application Hosting
- Systemd Service Management
- Zero-Downtime Application Updates
- URL Path Routing
- Process Monitoring And Control
- Environment Variable Management
- Server Block Organization
- Application Deployment Automation
- Web Infrastructure Architecture
- HTTP Request Proxying

## System Context
This component expands the web infrastructure by adding a dedicated application server layer between the web server and the application codebase, providing improved scalability, resource management, and deployment capabilities for dynamic web applications.

## Development Requirements
- Ubuntu 16.04 LTS Operating System
- Nginx Web Server
- Gunicorn WSGI Server
- Python 3 with Flask
- Systemd for Service Management
- Bash Scripting Capabilities
- Network Configuration Knowledge
- Web Application Architecture Understanding

## Development Workflow
1. Set up development environment with Flask and Gunicorn
2. Configure Gunicorn to serve Flask applications
3. Configure Nginx as a reverse proxy to Gunicorn
4. Create systemd service for Gunicorn process management
5. Implement graceful reload functionality for zero-downtime
6. Test configurations for proper functionality
7. Deploy to production environment

## Maintenance Notes
- Nginx configurations are stored in /etc/nginx/sites-available/
- Systemd service files are located in /etc/systemd/system/
- Gunicorn processes should be managed through systemd
- Zero-downtime deployments use HUP signal for graceful reloads
- Process monitoring is essential for service reliability
- Environment variables should be properly managed in systemd unit files
- Regular testing of proxy configurations is recommended

## Implementation Specifics

### Nginx Configurations
- **Basic Page Serving**: [2-app_server-nginx_config](./2-app_server-nginx_config)
- **Dynamic Route Handling**: [3-app_server-nginx_config](./3-app_server-nginx_config)
- **API Endpoint Configuration**: [4-app_server-nginx_config](./4-app_server-nginx_config)
- **Complete Application Config**: [5-app_server-nginx_config](./5-app_server-nginx_config)

### Process Management
- **Gunicorn Service Definition**: [gunicorn.service](./gunicorn.service)
- **Zero-Downtime Deployment**: [4-reload_gunicorn_no_downtime](./4-reload_gunicorn_no_downtime)