# Terraform AWS Application Deployment

This project provisions and deploys a **three-tier application
(Frontend + Backend + Database)** on AWS using **Terraform**.

------------------------------------------------------------------------

## Components Provisioned

-   VPC & Networking
-   Bastion Host
-   Frontend & Backend EC2
-   Application Load Balancers
-   Auto Scaling Groups
-   Launch Templates
-   Amazon RDS (MySQL)

------------------------------------------------------------------------

## Architecture Overview

### Frontend

-   EC2 instances behind Frontend ALB
-   Auto Scaling Group
-   Communicates with Backend ALB

### Backend

-   EC2 instances behind Backend ALB
-   Auto Scaling Group
-   Connects to RDS via environment variables

### Database

-   Amazon RDS in private subnets

------------------------------------------------------------------------

## Prerequisites

-   Terraform \>= 1.x
-   AWS CLI configured
-   AWS SSH Key Pair
-   Application build artifacts

------------------------------------------------------------------------

## Deployment Flow

### Step 1: Create S3 Bucket for Terraform State

Create the S3 bucket before running `terraform init`.

1. Sign in to the AWS Management Console.
2. Open **Amazon S3**.
3. Click **Create bucket**.
4. Enter the bucket name:

   ```text
   how-to-train-ur-dragon

5. Select the AWS Region:

   ```text
   us-east-1

6. Keep **Block all public access** enabled.
7. Click **Create bucket**.
8. Enable **Versioning**
9. Open the newly created S3 bucket: **how-to-train-ur-dragon**.
10. Go to the **Properties** tab.
11. Scroll to **Bucket Versioning**.
12. Click **Edit**.
13. Select **Enable**.
14. Click **Save** changes.

### Step 2: Initialize Terraform

``` bash
terraform init
```

### Step 3: Apply Networking

``` bash
terraform plan  -target=module.networking
terraform apply -target=module.networking
```

### Step 4: Deploy Bastion Host

``` bash
terraform apply -target=module.bastion
```

### Step 5: Deploy EC2 Instances

``` bash
terraform plan -target=module.frontend_ec2
terraform apply -target=module.frontend_ec2
terraform plan -target=module.backend_ec2
terraform apply -target=module.backend_ec2
```

### Step 6: Deploy Load Balancers

``` bash
terraform plan -target=module.backend_alb
terraform apply -target=module.backend_alb
terraform plan -target=module.frontend_alb
terraform apply -target=module.frontend_alb
```

### Step 7: Deploy Database

``` bash
terraform plan -target=module.database
terraform apply -target=module.database
```

### Step 8: Apply Remaining Modules

``` bash
terraform plan -target=module.frontend_launch_template
terraform apply -target=module.frontend_launch_template
terraform plan -target=module.backend_launch_template
terraform apply -target=module.backend_launch_template
terraform plan -target=module.backend_asg
terraform apply -target=module.backend_asg
terraform plan -target=module.frontend_asg
terraform apply -target=module.frontend_asg
```

------------------------------------------------------------------------

## Application Deployment

### Backend

-   Connect via Bastion or create in public subnet
-   Deploy backend app
-   Configure RDS details in `.env`

### Frontend

-   Connect via Bastion or create in public subnet
-   Update Backend ALB URL
-   Deploy frontend app

------------------------------------------------------------------------

