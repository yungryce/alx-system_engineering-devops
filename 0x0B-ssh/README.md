# 0x0B. SSH

<p align="center">
  <img src="https://img.shields.io/badge/SSH-Security-green.svg" alt="SSH Security">
  <img src="https://img.shields.io/badge/Bash-Scripting-blue.svg" alt="Bash Scripting">
  <img src="https://img.shields.io/badge/Puppet-Configuration-orange.svg" alt="Puppet Configuration">
  <img src="https://img.shields.io/badge/Remote-Access-red.svg" alt="Remote Access">
</p>

## Project Overview

This repository focuses on SSH (Secure Shell), a cryptographic network protocol used for secure system administration, file transfers, and network services over an unsecured network. The project explores SSH key generation, secure connections using SSH keys, SSH client configuration, and automating SSH configuration management with Puppet.

## Learning Objectives

By the end of this project, you should be able to explain:

* What is a server and where servers usually live
* What is SSH and why it is preferred over insecure protocols
* How to create an SSH RSA key pair
* How to connect to a remote host using an SSH RSA key pair
* The advantage of using `#!/usr/bin/env bash` instead of `/bin/bash`
* How to configure SSH client settings
* How to use Puppet for infrastructure as code
* Best practices for SSH security

## Requirements

* Ubuntu 20.04 LTS
* All Bash scripts must be executable (`chmod +x filename`)
* All Bash scripts will be interpreted on Ubuntu 20.04 LTS
* The first line of all Bash scripts should be `#!/usr/bin/env bash`
* The second line of all Bash scripts should be a comment explaining what the script does
* Puppet manifests must pass `puppet-lint` version 2.1.1 without any errors
* Puppet manifests must run without error
* Puppet manifests must have the correct file extension

## Project Tasks

### 0. Use a private key
**[0-use_a_private_key](0-use_a_private_key)**

Requirements:
- Write a Bash script that uses `ssh` to connect to your server using the private key `~/.ssh/school` with the user `ubuntu`
- Only use `ssh` single-character flags
- You do not need to handle the case of a private key protected by a passphrase

```bash
#!/usr/bin/env bash
# SSH connection command

ssh -i ~/.ssh/school ubuntu@52.201.190.114
```

### 1. Create an SSH key pair
**[1-create_ssh_key_pair](1-create_ssh_key_pair)**

Requirements:
- Write a Bash script that creates an RSA key pair
- Name of the created private key must be `school`
- Number of bits in the created key to be created 4096
- The created key must be protected by the passphrase `betty`

```bash
#!/usr/bin/env bash
# Creates a 4096 bit RSA key pair with passphrase betty
ssh-keygen -f school -b 4096 -N betty
```

### 2. Client configuration file
**[2-ssh_config](2-ssh_config)**

Requirements:
- Configure your SSH client to use the private key `~/.ssh/school`
- Configure your SSH client to refuse to authenticate using a password

```
Host 52.201.190.114
	Hostname 52.201.190.114
	User ubuntu
	PasswordAuthentication no
	IdentityFile ~/.ssh/school
```

### 3. Let me in!
For this task, you'll need to add the server's SSH public key to your authorized_keys file on the server to allow connections.

### 4. Client configuration file (w/ Puppet)
**[100-puppet_ssh_config.pp](100-puppet_ssh_config.pp)**

Requirements:
- Use Puppet to make changes to the SSH client configuration file
- Configure SSH client to use the private key `~/.ssh/school`
- Configure SSH client to refuse to authenticate using a password

```puppet
# make changes to config file using Puppet

include stdlib

file_line { 'Refuse to authenticate using a password':
  ensure => present,
  path   => '/etc/ssh/ssh_config',
  line   => 'PasswordAuthentication no',
}

file_line { 'Use private key':
  ensure => present,
  path   => '/etc/ssh/ssh_config',
  line   => 'IdentityFile ~/.ssh/school'
}
```

## SSH Basics

### What is SSH?

SSH (Secure Shell) is a cryptographic network protocol for operating network services securely over an unsecured network. It is widely used for secure remote login, command execution, and file transfers between computers.

SSH provides:
- Encrypted communications between client and server
- Strong authentication methods
- Integrity checking of transmitted data
- Port forwarding for secure application protocols
- Secure file transfer capabilities (SCP and SFTP)

### SSH Key Authentication

SSH key authentication is a way of logging into a server using a cryptographic key pair instead of a password. The key pair consists of:

- **Private Key**: Kept secret on the client machine
- **Public Key**: Can be shared with servers you want to access

The authentication process works as follows:
1. The client sends its public key to the server
2. The server checks if this public key is in the user's authorized_keys file
3. If found, the server encrypts a challenge with the public key
4. Only the holder of the matching private key can decrypt this challenge
5. The client decrypts and responds to the challenge
6. The server grants access if the response is correct

### SSH vs Insecure Protocols

SSH offers several advantages over older, insecure protocols like Telnet, rsh, and FTP:

| Feature | SSH | Insecure Protocols |
|---------|-----|-------------------|
| Authentication | Strong, key-based | Usually password-only |
| Communication | Encrypted | Plain text |
| Data Integrity | Verified | No verification |
| Port Forwarding | Supported | Not available |
| Security | High | Very low |

### SSH Client Configuration

The SSH client can be configured using the `~/.ssh/config` file or system-wide using `/etc/ssh/ssh_config`. Common configuration options include:

| Option | Description |
|--------|-------------|
| `Host` | Defines for which host(s) the configuration applies |
| `Hostname` | Specifies the real hostname to connect to |
| `User` | Specifies the username for the connection |
| `IdentityFile` | Specifies the file from which the identity (private key) is read |
| `Port` | Specifies the port number to connect on the remote host |
| `PasswordAuthentication` | Specifies whether to use password authentication |
| `PubkeyAuthentication` | Specifies whether to try public key authentication |

### SSH Key Generation and Management

#### Creating SSH Keys

The basic command to generate SSH keys is:
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

Options:
- `-t`: Specifies the type of key to create (RSA, DSA, ECDSA, ED25519)
- `-b`: Specifies the number of bits in the key (higher is more secure)
- `-f`: Specifies the filename of the key file
- `-N`: Provides a new passphrase for the key
- `-C`: Adds a comment to the key (usually email address or username@hostname)

#### SSH Key Security Best Practices:

- Never share your private key
- Use a strong passphrase to protect your private key
- Use different keys for different services/servers
- Regularly rotate your keys
- Store your private key securely with appropriate permissions (chmod 600)

## Automation with Puppet

Puppet is a configuration management tool that allows you to define infrastructure as code. For SSH configuration, Puppet can be used to:

1. Ensure consistent SSH configuration across multiple servers
2. Automate the deployment of SSH keys
3. Enforce security policies for SSH
4. Manage SSH service configuration

### File_line Resource in Puppet

The `file_line` resource from the stdlib module is particularly useful for SSH configuration:

```puppet
file_line { 'SSH Config Setting':
  ensure => present,
  path   => '/etc/ssh/sshd_config',
  line   => 'PasswordAuthentication no',
  match  => '^#?PasswordAuthentication',
}
```

This ensures that a specific configuration line exists in the specified file, creating it if it doesn't exist or modifying it if it does.

## Resources

* [What is a (physical) server - text](https://en.wikipedia.org/wiki/Server_(computing)#Hardware_requirement)
* [What is a (physical) server - video](https://www.youtube.com/watch?v=B1ANfsDyjeA)
* [SSH essentials](https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys)
* [SSH Config File](https://www.ssh.com/academy/ssh/config)
* [Public Key Authentication for SSH](https://www.ssh.com/academy/ssh/public-key-authentication)
* [How Secure Shell Works](https://www.youtube.com/watch?v=ORcvSkgdA58)
* [SSH Crash Course](https://www.youtube.com/watch?v=hQWRp-FdTpc)
* [Puppet resource type: file_line](https://puppet.com/docs/puppet/latest/types/file_line.html)

---

*Project by ALX System Engineering & DevOps*
