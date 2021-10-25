# Assignment: Developer Tools (Session 4)

This repository was created as part of assignments from the Developer Tools Module of the PowerX Programme.


## About

In this project, Terraform is used to implement Infrastructure as Code (IoC) for deploying a private AWS EC2 instance that is only accessible by SSH from a given IP address.

### Assignment Requirements:
- [X] Terraform code should create EC2 instance
- [X] EC2 instance should have port 22 (SSH) accessible only from own public IP address using specific TLS private key
- [X] All resources needed must be provisioned by Terraform
- [X] It should be possible to SSH into EC2 instance after created (from own IP address)
- [X] It should not be possible to SSH into EC2 instance from other IP address


## Setup

### Setup Requirements:

- Amazon account with relevant permissions for the follwing services:
  - EC2: For creating instances, security groups, and generating key-pairs
  - S3: For storing backend state

### Steps

1. Configure aws credentials on CLI: `aws configure`
2. Adapt instructions from this [GIST](https://gist.github.com/uLan08/00231ab7288663842348aae5598f89c9) to set up AWS S3 Bucket for state backend
    - (The rest of the setup can continue with the repository code as-is)
3. Initialize S3 Backend from `s3-backend` folder: 
    - `terraform init`
    - `terraform plan`
      - --> Check changes
    - `terraform apply`
4. Create key-pair via CLI (Instructions from [AWS](https://docs.aws.amazon.com/cli/latest/userguide/cli-services-ec2-keypairs.html))
    - `aws ec2 create-key-pair --key-name <key name> --query 'KeyMaterial' --output text > <file name>.pem`
      - --> Replace `<key name>` and `<file name>` as necessary
    - `chmod 400 <path to private key>`
      - (To update permissions for private key file)
5. Initialize private EC2 Instance from `app-server` folder:
    - Ensure `key_name` for instance is the same as in Step #4
      - (Currently set to "*ec2_ssh_keys*")
    - `terraform init`
    - `terrform plan`
      - --> Enter ip address from which SSH will be allowed
      - --> Check changes
    - `terrform apply`
      - --> Enter ip address from which SSH will be allowed
6. SSH into private EC2 Instance
    - `ssh -i <path to private key> <user>@<instance public IP / DNS>`
      - --> Check this list of [valid users](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesConnecting.html#TroubleshootingInstancesConnectingPuTTY)
