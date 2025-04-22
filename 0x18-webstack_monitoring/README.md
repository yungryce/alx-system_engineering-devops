# Webstack Monitoring

<p align="center">
  <img src="https://img.shields.io/badge/Server-Monitoring-green.svg" alt="Server Monitoring">
  <img src="https://img.shields.io/badge/Datadog-Integration-blue.svg" alt="Datadog Integration">
  <img src="https://img.shields.io/badge/Performance-Metrics-orange.svg" alt="Performance Metrics">
  <img src="https://img.shields.io/badge/Application-Observability-red.svg" alt="Application Observability">
</p>

## Project Overview

This project focuses on implementing comprehensive monitoring solutions for web infrastructure using Datadog, a cloud-based monitoring and analytics platform. Web stack monitoring is essential for ensuring service reliability, performance optimization, and rapid troubleshooting when issues arise. Through this project, we learn to implement monitoring strategies that track both server metrics and application performance.

## Learning Objectives

By the end of this project, you should be able to explain:

* The difference between application and server monitoring
* How monitoring tools work and their importance in web infrastructure
* Key metrics to monitor for web servers and applications
* How to set up monitoring agents on servers
* How to create meaningful dashboards for performance visualization
* How to configure alerts for critical system events
* How to analyze system performance through monitoring data
* Best practices for infrastructure observability
* How to implement SaaS-based monitoring solutions
* The role of metrics in capacity planning and optimization

## Requirements

* All files will be interpreted on Ubuntu 16.04 LTS
* All Bash script files must be executable
* All Bash scripts must pass Shellcheck without any error
* The first line of all Bash scripts should be exactly `#!/usr/bin/env bash`
* The second line of all Bash scripts should be a comment explaining what the script is doing

## Project Tasks

### 0. Sign up for Datadog and install datadog-agent

Sign up for a free Datadog account and install the Datadog agent on your web-01 server. Use the US1 region when signing up.

The installation process involves:

1. Creating a Datadog account
2. Getting your API key from the Datadog interface
3. Installing the Datadog agent on your server
4. Configuring the agent with your API key
5. Verifying that the agent is sending data to Datadog

Installation commands:
```bash
# Update package list
sudo apt-get update

# Install SSL libraries for secure communication
sudo apt-get install -y apt-transport-https curl

# Add Datadog repository
sudo sh -c "echo 'deb https://apt.datadoghq.com/ stable 7' > /etc/apt/sources.list.d/datadog.list"
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 A2923DFF56EDA6E76E55E492D3A80E30382E94DE

# Update package list with Datadog repo
sudo apt-get update

# Install Datadog agent
sudo apt-get install -y datadog-agent

# Configure Datadog API key
sudo sh -c "echo api_key: YOUR_API_KEY > /etc/datadog-agent/datadog.yaml"

# Start Datadog agent
sudo systemctl restart datadog-agent
```

### 1. Monitor some metrics

Set up monitoring for your web server by:
* Setting up a monitor that checks the number of read requests issued to the device per second
* Setting up a monitor that checks the number of write requests issued to the device per second

In Datadog, this involves:
1. Creating a new monitor
2. Selecting metric type (system.io.r_s or system.io.w_s)
3. Defining alert conditions
4. Configuring notification options
5. Saving and enabling the monitor

### 2. Create a dashboard

**[2-setup_datadog](2-setup_datadog)**

Create a dashboard with different metrics displayed in widgets, containing at least:
* System metrics from your web-01 server
* Application metrics to track HTTP requests
* Custom widgets to visualize key performance indicators

After creating your dashboard, copy the dashboard ID and add it to the `2-setup_datadog` file.

## Understanding Monitoring Types

### Application Monitoring

Application monitoring focuses on the performance and functionality of the software running on your servers. This includes:

* **Request Rates**: Number of requests processed per second
* **Error Rates**: Percentage of requests that result in errors
* **Response Times**: How long it takes to process requests
* **Throughput**: Volume of data processed in a time period
* **Availability**: Percentage of time the application is accessible
* **Apdex Score**: User satisfaction measurement based on response times
* **Transaction Tracing**: Following requests through application components

Application monitoring helps identify:
- Performance bottlenecks
- Error-prone code paths
- Slow database queries
- Memory leaks
- Resource-intensive operations

### Server Monitoring

Server monitoring tracks the health and resource utilization of physical or virtual infrastructure, including:

* **CPU Usage**: Overall and per-core utilization
* **Memory Usage**: Used, available, and swapped memory
* **Disk I/O**: Read/write operations and latency
* **Network Traffic**: Inbound and outbound data transfer
* **System Load**: Average number of processes waiting for CPU time
* **Uptime**: Duration since last restart
* **Process Count**: Number of running processes
* **File System**: Storage space usage

Server monitoring helps identify:
- Resource constraints
- Hardware failures
- Capacity planning needs
- Performance degradation
- System overload conditions

## Key Metrics to Monitor

### System Metrics

1. **CPU Metrics**
   * `system.cpu.user`: Time spent running user space processes
   * `system.cpu.system`: Time spent running kernel processes
   * `system.cpu.idle`: Time CPU remained idle
   * `system.cpu.wait`: Time spent waiting for I/O operations

2. **Memory Metrics**
   * `system.mem.total`: Total memory available
   * `system.mem.used`: Memory currently in use
   * `system.mem.free`: Available memory
   * `system.swap.used`: Amount of swap space used

3. **Disk Metrics**
   * `system.disk.free`: Available disk space
   * `system.disk.used`: Used disk space
   * `system.io.r_s`: Read operations per second
   * `system.io.w_s`: Write operations per second
   * `system.io.await`: Average time for I/O requests

4. **Network Metrics**
   * `system.net.bytes_rcvd`: Network bytes received
   * `system.net.bytes_sent`: Network bytes sent
   * `system.net.packets_in.count`: Network packets received
   * `system.net.packets_out.count`: Network packets sent

### Web Server Metrics

1. **Request Metrics**
   * `nginx.net.request_per_s`: Request rate for Nginx
   * `apache.performance.busy_workers`: Number of busy Apache workers
   * `apache.performance.idle_workers`: Number of idle Apache workers

2. **Response Metrics**
   * `nginx.net.connections`: Active connections
   * `http.response_time`: Time to respond to HTTP requests
   * `http.status_code`: Distribution of HTTP response codes

3. **SSL Metrics**
   * `nginx.ssl.handshakes`: SSL handshakes per second
   * `nginx.ssl.handshakes_failed`: Failed SSL handshakes per second

## Datadog Dashboard Creation

Creating effective dashboards requires:

1. **Organizing by Function**: Group related metrics together
   ```
   CPU + Memory + Load (System Overview)
   Disk + I/O (Storage Performance)
   Network In/Out (Network Performance)
   ```

2. **Using the Right Visualizations**:
   * Line graphs for time-series data
   * Gauges for current values against thresholds
   * Heatmaps for distribution data
   * Tables for detailed lists

3. **Timeframe Selection**:
   * Include different time ranges (1hr, 1d, 1wk)
   * Allow for comparison with previous periods

4. **Setting Context with Markers**:
   * Add event markers for deployments
   * Include annotations for incidents
   * Mark maintenance periods

5. **Creating Hierarchy**:
   * Overview dashboards for high-level status
   * Detail dashboards for troubleshooting
   * Service-specific dashboards for deep dives

## Datadog Agent Configuration

The Datadog Agent collects metrics, logs, and traces from your hosts and sends them to Datadog. Key configuration options include:

1. **Main Configuration File**: `/etc/datadog-agent/datadog.yaml`
   ```yaml
   api_key: <YOUR_API_KEY>
   site: datadoghq.com
   logs_enabled: true
   apm_config:
     enabled: true
   process_config:
     enabled: true
   ```

2. **Integration Configurations**: `/etc/datadog-agent/conf.d/`
   ```yaml
   # /etc/datadog-agent/conf.d/apache.d/conf.yaml
   init_config:
   instances:
     - apache_status_url: http://localhost/server-status?auto
       apache_user: datadog
       apache_password: password
   ```

3. **Agent Commands**:
   ```bash
   # Check agent status
   sudo datadog-agent status
   
   # Restart agent
   sudo systemctl restart datadog-agent
   
   # View agent logs
   sudo tail -f /var/log/datadog/agent.log
   ```

## Alert Configuration Best Practices

When setting up alerts in Datadog:

1. **Define Clear Thresholds**:
   * Warning vs. Critical levels
   * Different thresholds for different environments

2. **Avoid Alert Fatigue**:
   * Use recovery periods to prevent flapping
   * Aggregate related alerts
   * Implement alert priorities

3. **Include Context in Notifications**:
   * Link to relevant dashboards
   * Include troubleshooting steps
   * Provide context about the affected service

4. **Use Composite Alerts**:
   * Combine multiple conditions
   * Use AND/OR operators for complex scenarios

5. **Implement Proper Routing**:
   * Direct alerts to appropriate teams
   * Use different channels for different severities
   * Schedule on-call rotations

## Monitoring Strategy Implementation

A comprehensive monitoring strategy includes:

1. **Collection Layer**: What metrics to gather
2. **Storage Layer**: How long to retain data
3. **Analysis Layer**: How to process and correlate metrics
4. **Visualization Layer**: How to present data meaningfully
5. **Alerting Layer**: When and how to notify about issues
6. **Response Layer**: How to act on monitoring information

Effective implementation requires:
- Defining service level indicators (SLIs)
- Setting service level objectives (SLOs)
- Establishing service level agreements (SLAs)
- Creating runbooks for common alert scenarios
- Regular review and refinement of monitoring configurations

## Resources

* [Monitoring Web Server QoS with Datadog](https://www.datadoghq.com/blog/monitoring-101-collecting-data/)
* [System Check Core Metrics](https://docs.datadoghq.com/integrations/system/)
* [Datadog API Documentation](https://docs.datadoghq.com/api/latest/)
* [Metrics to Monitor in Your Web Server](https://www.datadoghq.com/blog/web-server-monitoring/)
* [Introduction to Monitoring and Alerting](https://www.digitalocean.com/community/tutorials/an-introduction-to-metrics-monitoring-and-alerting)
* [What is Application Performance Monitoring?](https://www.sumologic.com/glossary/application-performance-monitoring/)
* [Datadog Dashboard API](https://docs.datadoghq.com/api/latest/dashboards/)
* [The Four Golden Signals of Monitoring](https://sre.google/sre-book/monitoring-distributed-systems/)

---

*Project by ALX System Engineering & DevOps*
