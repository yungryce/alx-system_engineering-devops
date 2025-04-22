# Project Manifest: Web Server

## Project Identity
- **Name**: Web Server
- **Type**: Educational
- **Scope**: Web Server Configuration and Management
- **Status**: Completed

## Technology Signature
- **Core**: Bash Shell Scripting
- **Environment**: Ubuntu 20.04 LTS
- **Web Server**: Nginx
- **Configuration Management**: Puppet
- **File Transfer**: SCP (Secure Copy Protocol)
- **Networking**: HTTP/HTTPS, DNS

## Demonstrated Competencies
- Web Server Installation and Configuration
- File Transfer to Remote Servers
- Domain Name Configuration
- URL Redirection Implementation
- Custom Error Page Creation
- Infrastructure as Code with Puppet
- Nginx Server Configuration
- Shell Script Automation
- HTTP Protocol Understanding
- Server Deployment Automation
- Remote Server Management

## System Context
This component builds on SSH and configuration management knowledge to introduce web server concepts and practices. Web servers are fundamental to modern infrastructure, serving as the foundation for hosting websites, web applications, and APIs. This module covers essential skills for deploying and managing web servers in production environments.

## Development Requirements
- Linux/Unix-based Operating System
- SSH Client
- Text Editor (vi/vim/emacs)
- Nginx Web Server
- Puppet for Configuration Management
- Access to a Remote Server for Testing
- Domain Name (for DNS configuration)

## Development Workflow
1. Read project specifications and requirements
2. Set up secure file transfer mechanisms
3. Install and configure Nginx web server
4. Configure domain name with DNS
5. Implement URL redirection rules
6. Create custom error pages
7. Automate configuration with Puppet
8. Test web server functionality
9. Submit for automated and peer review

## Maintenance Notes
- All scripts use appropriate shebang lines
- Each script includes a comment describing its functionality
- Scripts have proper execution permissions
- Web server configuration follows security best practices
- Puppet manifests adhere to best practices for configuration management
- Error handling is implemented in all scripts
- Configurations are idempotent (can be applied multiple times safely)

## Implementation Specifics

### File Transfer
- **Transfer File to Server**: [0-transfer_file](./0-transfer_file)

### Nginx Installation and Configuration
- **Nginx Installation**: [1-install_nginx_web_server](./1-install_nginx_web_server)

### Domain Management
- **Domain Name Setup**: [2-setup_a_domain_name](./2-setup_a_domain_name)

### URL Redirection
- **301 Redirection Configuration**: [3-redirection](./3-redirection)

### Error Pages
- **Custom 404 Page Configuration**: [4-not_found_page_404](./4-not_found_page_404)

### Automation
- **Puppet Nginx Installation**: [7-puppet_install_nginx_web_server.pp](./7-puppet_install_nginx_web_server.pp)