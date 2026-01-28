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

### Step 1: Initialize Terraform

``` bash
terraform init
```

### Step 2: Apply Networking

``` bash
terraform plan  -target=module.networking
terraform apply -target=module.networking
```

### Step 3: Deploy Bastion Host

``` bash
terraform apply -target=module.bastion
```

### Step 4: Deploy EC2 Instances

``` bash
terraform plan -target=module.frontend_ec2
terraform apply -target=module.frontend_ec2
terraform plan -target=module.backend_ec2
terraform apply -target=module.backend_ec2
```

### Step 5: Deploy Load Balancers

``` bash
terraform plan -target=module.backend_alb
terraform apply -target=module.backend_alb
terraform plan -target=module.frontend_alb
terraform apply -target=module.frontend_alb
```

### Step 6: Deploy Database

``` bash
terraform plan -target=module.database
terraform apply -target=module.database
```

### Step 7: Apply Remaining Modules

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