# AWS Infrastructure as Code with Terraform

This project is about configuring a basic AWS EC2 instance using Terraform, complete with SSH access and security group configurations.

## Prerequisites

- AWS Account
- Terraform installed (version >= 1.2.0)
- AWS CLI configured
- SSH key pair

## Infrastructure Components

The project creates the following AWS resources:
- EC2 Instance
- Security Group for SSH access
- SSH Key Pair

## Quick Start

1. Clone the repository:
```bash
git clone https://github.com/vsbuidev/roadmap-s-project.git
```

2. Navigate to the project directory:
```bash
cd roadmap-s-project/IAC\ on\ AWS
```

3. Initialize Terraform:
```bash
terraform init
```
4. Review the planned changes:
```bash
terraform plan
```

5. Apply the configuration:
```bash
terraform apply
```

### Configuration Details
- Region: us-east-1 (configurable)
- Instance Type: t2.micro
- AMI: Amazon Linux 2
- Security Group:
    - Inbound: SSH (port 22)
    - Outbound: All traffic

### Important Notes
- The security group allows SSH access from any IP (0.0.0.0/0). Consider restricting this for production use.
- Make sure to have your SSH public key at ~/.ssh/new_id_rsa.pub
- The EC2 instance will be assigned a public IP address

### Outputs
The public IP address of the EC2 instance will be displayed after successful deployment.

### Cleanup
To destroy the created resources:

```bash
terraform destroy
```

This project is based on the following roadmap: https://roadmap.sh/projects/iac-digitalocean