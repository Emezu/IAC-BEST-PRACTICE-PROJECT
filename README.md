# PROJECT 
 This Terraform project deploys a scalable, load-balanced web application on AWS. The infrastructure includes an Auto Scaling Group (ASG) of EC2 instances behind an Application Load Balancer (ALB), using Docker to serve a simple web application. The project integrates IAM, security groups, and VPC configurations for security and accessibility.


## PREREQUSITES FOR THIS PROJECT

1. AWS CLI installed and configured with appropriate permissions.

2. Terraform installed (version 1.5.0 or later recommended).

3. SSH public key for EC2 instances.

4. Basic knowledge of AWS and Terraform.

# STEP BY STEP PROCESS

1. Clone the Repository

```python

git clone <repository-url>
cd <repository-folder>

```

2. Initialize Terraform

```python

terraform init

```

3. Review and Edit Variables (Optional)

Check and update any variables in the .tf files if needed, such as the region or instance type.

4. Plan the Deployment

``` python

terraform plan

# This command displays the resources that will be created.
```


5. Deploy the Infrastructure

```python

terraform apply

```

Type yes to confirm.

6. Access the Load Balancer

Once deployment is complete, the DNS name of the Application Load Balancer will be output. Access it using a web browser.

```python

echo "Load Balancer URL: $(terraform output elb_dns_name)"

```

. Clean Up Resources

To destroy the infrastructure and avoid incurring costs:

```python

terraform destroy

```
Type yes to confirm.



## THIS PROJECT INCLUDES CONFIGURATION FILES 

$main.tf: Configures the provider.

$vpc.tf: Defines the VPC and subnets.

$subnets.tf: Configures public and private subnets.

$security_group.tf: Defines security groups.

$igw.tf: Configures the internet gateway.

$route_table.tf: Sets up the route tables.

$iam.tf: Creates IAM roles and instance profiles.

$ec2.tf: Defines EC2 instances, launch template, and auto-scaling group.

$elb.tf: Sets up the Application Load Balancer.

$outputs.tf: Outputs the ALB DNS name.

$user_data.sh: Script to install Docker and deploy the application on EC2.


## Troubleshooting

### Permission Errors:

Ensure your AWS CLI credentials have the required permissions.

### Terraform Errors:

Run terraform validate to check for configuration errors.

### Application Not Accessible:

Check ALB DNS in the output.

Verify Security Group rules.

Check EC2 instance status.

I had fun working on this project. I got tired a lot of times too, but I am excited to have completed this! The process taught me a lot about Terraform and AWS, and I look forward to applying this knowledge to future projects.

THANK YOU.