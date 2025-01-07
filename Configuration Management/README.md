# Ansible Configuration Management

This project demonstrates infrastructure automation using **Ansible** for configuring Linux servers. The playbook automates the setup of web servers, installs and configures **Nginx**, and deploys applications.

## Table of Contents

- [Ansible Configuration Management](#ansible-configuration-management)
  - [Table of Contents](#table-of-contents)
  - [Project Setup](#project-setup)
  - [Prerequisites](#prerequisites)
  - [Initial Setup](#initial-setup)
  - [Roles](#roles)
  - [Running the Playbook](#running-the-playbook)

## Project Setup

### Prerequisites

1. **Ansible**: Install Ansible on your control machine following the [official guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
2. **Target Servers**: Linux servers (AWS EC2, Azure VM, or on-premises)
3. **SSH Access**: Valid SSH credentials for target servers
4. **Sudo Rights**: Elevated permissions on target servers

### Initial Setup

1. **Clone the repository**:

```bash
git clone https://github.com/vsbuidev/roadmap-s-project.git
cd roadmap-s-project/Configuration Management
```

2. **Inventory Setup**:

define the target host in an inventory.ini file.

```ini
[servers]
server1 ansible_host=<IP_ADDRESS> ansible_user=<USERNAME> ansible_ssh_private_key_file=<PATH_TO_PRIVATE_KEY>
```

### Roles

#### 1. Base Role

- System updates
- Essential packages installation
- Security configurations
- Firewall setup

#### 2. Web Role

- Nginx installation and configuration
- SSL/TLS setup
- Virtual hosts configuration

#### 3. App Role

- Application deployment
- Dependencies installation
- Service configuration

#### 4. Monitoring Role

- Monitoring tools setup
- Log management
- Alert configurations

### Running the Playbook

1. Full deployment:

```bash
ansible-playbook -i inventory.ini setup.yml
```

2. Specific role:

```bash
ansible-playbook -i inventory.ini setup.yml --tags <role_name>
```

## Project Detail Link:

https://roadmap.sh/projects/configuration-management
