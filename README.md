# HuaweiCloud Terraform Infrastructure

This project contains Terraform code to provision cloud infrastructure on HuaweiCloud, including:

- Elastic Load Balancer (ELB)
- Auto Scaling Group (ASG) with ECS instances
- RDS MySQL Database
- OBS Object Storage Bucket

## Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) installed
- HuaweiCloud account and API credentials
- Properly configured `provider.tf` with your access keys and region

## Project Structure
- `provider.tf` – Provider configuration
- `network.tf` – VPC, subnet, and security group definitions
- `autoscale_lb.tf` – Load balancer, auto scaling group, and ECS configuration
- `storage.tf` – RDS and OBS resources
- `main.tf` – (if present) Entry point for resource composition

## Usage
1. Clone this repository:
   ```sh
   git clone https://github.com/SabaShahdin/Terraform.git
   cd Terraform
   ```
2. Initialize Terraform:
   ```sh
   terraform init
   ```
3. Review and customize variables and resource parameters as needed.
4. Apply the configuration:
   ```sh
   terraform apply
   ```
5. Confirm the plan and wait for resources to be provisioned.

## Outputs
- RDS endpoint
- OBS bucket URL

## Notes
- **Security:** Never commit your HuaweiCloud credentials to version control.
- **Passwords:** Change default passwords before production use.
- **Cleanup:** To destroy all resources, run:
  ```sh
  terraform destroy
  ```

## License
MIT
