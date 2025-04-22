# 0x14. MySQL

<p align="center">
  <img src="https://img.shields.io/badge/Database-MySQL-blue.svg" alt="MySQL Database">
  <img src="https://img.shields.io/badge/Replication-Primary/Replica-orange.svg" alt="Replication">
  <img src="https://img.shields.io/badge/Backup-Strategy-green.svg" alt="Backup Strategy">
  <img src="https://img.shields.io/badge/High-Availability-red.svg" alt="High Availability">
</p>

## Project Overview

This repository focuses on MySQL database management with an emphasis on high availability and fault tolerance through primary-replica replication. It also covers critical database operations such as backup strategies and restoration procedures to ensure data integrity and business continuity.

## Background Context

Having a database is essential for dynamic websites and applications. However, a single point of failure in your database infrastructure can lead to service disruption. This project addresses this vulnerability by implementing a primary-replica (master-slave) infrastructure that improves reliability, scalability, and disaster recovery capabilities.

With a primary-replica setup:
- If the primary server fails, the replica can be promoted to become the new primary
- Read queries can be distributed between both servers, improving performance
- Backups can be performed on the replica without affecting the primary's performance

## Learning Objectives

By the end of this project, you should be able to explain:

* The main role of a database in web infrastructure
* What database replication is and its purpose
* Why database backups are essential
* The difference between primary and replica nodes
* How to implement MySQL primary-replica replication
* How to create automated database backups
* How to restore from backups in case of data loss
* How to monitor database health and performance
* Implementation strategies for high availability

## Requirements

* Ubuntu 20.04 LTS
* MySQL 5.7.x
* All Bash scripts must be executable
* The first line of all Bash scripts should be `#!/usr/bin/env bash`
* The second line of all Bash scripts should be a comment explaining what the script does
* All MySQL configuration files must be properly structured
* Scripts should follow best practices for idempotence

## Project Tasks

### 0. Install MySQL
**[Task 0]**

Requirements:
- Install MySQL 5.7.x on both web-01 and web-02 servers
- Ensure the MySQL distribution is 5.7.x
- Create user and set up permissions for the checker

### 1. Create a database and user
**[Task 1]**

Requirements:
- Create a database named `tyrell_corp` on both servers
- Within the database, create a table named `nexus6` with at least one entry
- Create a new user named `holberton_user` with the host name set to `localhost` and password `projectcorrection280hbtn`
- Grant permission to check the primary/replica status to `holberton_user`

### 2. Setup Primary-Replica infrastructure (Master-Slave replication)
**[Task 2 & 3]**

Requirements:
- Configure MySQL for primary-replica replication
- Setup web-01 as the primary, web-02 as the replica
- Create a new user `replica_user` for replication
- Grant appropriate replication permissions to the replica user

### 3. MySQL configuration files
**[4-mysql_configuration_primary](4-mysql_configuration_primary)** and **[4-mysql_configuration_replica](4-mysql_configuration_replica)**

Requirements:
- Create configuration files for both primary and replica MySQL instances
- Configure proper server-id and binary logging on the primary
- Configure replication settings on the replica
- Ensure proper access control and port settings
- Submit the config files as your answer files

### 4. MySQL backup
**[5-mysql_backup](5-mysql_backup)**

Requirements:
- Write a Bash script that generates a MySQL dump of all databases
- The dump must be compressed to a tar.gz archive
- The archive name must follow the format day-month-year.tar.gz
- The script accepts one argument: the MySQL root password

```bash
#!/usr/bin/env bash
# backup and compress my databases

# variables
day=$(date +"%d")
month=$(date +"%m")
year=$(date +"%Y")
file_name="$day-$month-$year.tar.gz"

mysqldump --all-databases -u root --password="$1" > backup.sql
tar -czvf "$file_name" backup.sql
```

## MySQL Primary-Replica Architecture

### Overview

A MySQL primary-replica (formerly master-slave) replication setup is a method of duplicating data from one database server (the primary) to one or more database servers (the replicas). This provides several benefits:

1. **High Availability**: If the primary server fails, a replica can be promoted to take its place
2. **Load Distribution**: Read queries can be directed to replicas, reducing load on the primary
3. **Backup Facilitation**: Backups can be performed on replicas without affecting the primary's performance
4. **Geographical Distribution**: Replicas can be located in different geographic locations, reducing latency for global users

### How MySQL Replication Works

1. **Binary Logging**: The primary server records all data changes in binary log files
2. **Log Transfer**: The replica server connects to the primary and requests binary log events
3. **Replay**: The replica applies these events to its own data, maintaining a copy of the primary's data

### Types of Replication

1. **Asynchronous Replication** (Default): Primary doesn't wait for replica confirmation
2. **Semi-synchronous Replication**: Primary waits for at least one replica to confirm receipt
3. **Synchronous Replication**: Primary waits for all replicas to confirm (not natively supported in MySQL)

## Configuration Details

### Primary Server Configuration

Key settings in the primary configuration:

```ini
[mysqld]
# Unique server ID
server-id = 1

# Enable binary logging
log_bin = /var/log/mysql/mysql-bin.log

# Database to replicate
binlog_do_db = tyrell_corp
```

### Replica Server Configuration

Key settings in the replica configuration:

```ini
[mysqld]
# Unique server ID (different from primary)
server-id = 2

# Enable binary logging (useful for chained replication)
log_bin = /var/log/mysql/mysql-bin.log

# Database to replicate
binlog_do_db = tyrell_corp

# Relay log configuration
relay-log = /var/log/mysql/mysql-relay-bin.log

# Enable replica
read_only = on
```

## Setting Up Replication Step by Step

1. **Configure Primary Server**:
   - Set server-id and enable binary logging
   - Create replication user: `CREATE USER 'replica_user'@'%' IDENTIFIED BY 'password';`
   - Grant privileges: `GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';`
   - Get binary log position: `SHOW MASTER STATUS;`

2. **Configure Replica Server**:
   - Set server-id (different from primary) and other configuration
   - Connect to primary:
     ```sql
     CHANGE MASTER TO
       MASTER_HOST='primary_ip',
       MASTER_USER='replica_user',
       MASTER_PASSWORD='password',
       MASTER_LOG_FILE='mysql-bin.00001',
       MASTER_LOG_POS=123;
     ```
   - Start replication: `START SLAVE;`
   - Verify status: `SHOW SLAVE STATUS\G`

## Database Backup Strategies

### Types of Backups

1. **Logical Backups**:
   - Created with tools like `mysqldump`
   - Human-readable SQL statements
   - More portable, but slower to restore
   - Suitable for smaller databases

2. **Physical Backups**:
   - Direct copies of database files
   - Faster to create and restore
   - Less portable across MySQL versions
   - Suitable for larger databases

3. **Incremental Backups**:
   - Only backup data that has changed since the last backup
   - Requires a full backup first
   - Reduces backup size and time

### Backup Best Practices

1. **Regular Schedule**: Set up automated, scheduled backups
2. **Multiple Locations**: Store backups in multiple, geographically diverse locations
3. **Encryption**: Encrypt sensitive backup data
4. **Verification**: Regularly test restoring from backups
5. **Monitoring**: Monitor the backup process and verify completion
6. **Retention Policy**: Establish how long to keep different backup sets

## Disaster Recovery Procedures

### Promoting a Replica to Primary

If the primary server fails:

1. On the replica server, run: `STOP SLAVE;`
2. Make the replica writable: `SET GLOBAL read_only = OFF;`
3. Get binary log position: `SHOW MASTER STATUS;`
4. Reconfigure other replicas to use the new primary

### Point-in-Time Recovery

To restore a database to a specific point in time:

1. Restore the most recent full backup
2. Apply binary logs up to the desired point in time:
   ```bash
   mysqlbinlog --stop-datetime="2023-01-01 12:00:00" /path/to/binary/log | mysql -u root -p
   ```

## Resources

* [What is a Primary-Replica Setup](https://www.digitalocean.com/community/tutorials/how-to-set-up-master-slave-replication-in-mysql)
* [MySQL Primary-Replica Setup: Step by Step](https://www.digitalocean.com/community/tutorials/how-to-set-up-replication-in-mysql)
* [MySQL Backup Strategy](https://dev.mysql.com/doc/refman/5.7/en/backup-methods.html)
* [MySQL 5.7 Documentation: Replication](https://dev.mysql.com/doc/refman/5.7/en/replication.html)
* [mysqldump Documentation](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html)
* [High Availability Architecture](https://dev.mysql.com/doc/mysql-ha-scalability/en/)
* [How to Troubleshoot MySQL Replication Issues](https://www.percona.com/blog/troubleshooting-mysql-replication-issues/)

---

*Project by ALX System Engineering & DevOps*
