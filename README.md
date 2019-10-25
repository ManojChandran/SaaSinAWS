# Overview

Every other day a new start-up is in market with a software service,  Most of these offer Software as a Service. Industry has changed much after cloud and Enterprise started relying on these SAAS providers more. This git repository is provide a base design to implement a multi-tenant SAAS infrastructure in AWS cloud. We will be implementing it as infrastructure as code, using Terraform.

* Terraform vesrion : 0.11.13

> This is a rough outline of solution, we are going to follow AWS proposed Mutli-tenant solutions.I will be adding more resources and it will be a continuous improvements towards a good solution.

# GOAL

Goal is to implement a SAAS infrastructure in AWS using Terraform. Design follows the guidelines presented by Tod Golding ins AWS reinvent 2018 (ARC418-R1 references are provided at the end of this document.)

* Stand alone design for customers to deploy in their own independent environment.
* Share an environment (multi-tenancy), logically separate multiple tenants.
* Must support the ability for multiple independent deployments
* Application and infrastructure can be independently upgraded for a customer or a set of customers.

# SAAS

A method of software delivery and licensing in which software is accessed online via a subscription, rather than bought and installed on individual computers.

### Functional Requirement for the Infra created

![SAAS Requirements](./images/Architecting_requirement.png?raw=true "Title")

Designing SAAS infrastructure means, we are going to create a multi-tenant architecture. Each tenant will have different privilege, access and data isolation.

Key steps in designing SAAS are:

* Tenant on-boarding
* Tenant Isolation
* Metering, Metrics and Analysis
* Management & monitoring
* Billing
* Deployment & agility

### Tenant onboarding
Tenant onboarding is key part in the Multi tenant SAAS application. Static S3 hosting online onboarding and cloudfront for distribution. SAAS will be provided as API's and Cognito will be used for user authentication. Find the reference design from AWS below.

![Onboarding Approach](./images/Auth.png?raw=true "Title")

Our solution Terraform modules:
* 01_Route53
* 02_S3hosting
* 03_Cldfrontdistro
* 04_ApiGateway
* 05_Cognito
* 06_IAM

### Tenant Isolation

Second step in the process is Tenant isolation, there are several levels of isolation methods. AWS has guidelines on attaining Tenant isolation and they have formulated it in below categories.

* Model #1 – Tenant Isolation at the AWS Account Layer
* Model #2 – Tenant Isolation at the Amazon VPC Layer
* Model #3 – Tenant Isolation at Amazon VPC Subnet Layer
* Model #4 – Tenant Isolation at the Container Layer
* Model #5 – Tenant Isolation at the Application Layer

Our approach is to divide the tenants in to multiple tier and use a Hybrid Isolation.

![Design](./images/TenantIsolation.png?raw=true "Title")</br>

### Tenant Tier

We assume current tenant fall in three categories as mentioned below.

* Tenant1 - Open Source (Single Region, Multi AZ, No data isolation)
* Tenant2 - Standrad Tier (Single region, Single AZ, Isolated database )
* Tenant3 - Professional Tier (Single region, Multi AZ, Isolated Multi AZ database)
* Tenant4 - Premium Tier (Multi region)

All the components have been created individual Terraform Modules. Assuming Tenant category and applying mapping, we can control the resources creation and allocation.

```hcl
#----root/variables.tf----- Sample approach
variable "tenantTier" {
  description = "tenantTier: Tenant1 or Tenant2 or Tenant3 or Tenant4"
}

....

variable "vpc_public_subnet_count" {
  type        = "map"
  description = "Subnet count"
  default     = {
    Tenant1  = "2"
    Tenant2  = "4"
    Tenant3  = "6"
    Tenant4  = "8"
  }
}

```

### Metering, Metrics and Analysis
need to work on, any suggestion /guideline /learning shared will be helpful

### Management & monitoring
Management and monitoring is key, we start with implementing VPC flow logs.

Our solution Terraform modules:
* 20_Flowlogs

### Billing
Billing is a challenge in the Hybrid model, our work around is to make sure use particular tag for the infra created. We should force it with IAM rule "RequestTag" (AWS re:Invent 2018: [REPEAT 1] Become an IAM Policy Master in 60 Minutes or Less (SEC316-R1))

### Deployment & agility
Whole project is made by breaking the AWS services into modules. Each service have their own corresponding Terraform module, which can be run independently or run at a shot. We can use "terraform.tfvars" for setting up the module to run the required service.

Modules help in:
* Setting up the infra one by one
* Help is debugging particular service
* Will give us full control and tweak

# Deliverables

### Network Diagram/ Design

![Design](./images/Network_diagram.png?raw=true "Title")</br>

### Configuration management

Github Link for solution (https://github.com/ManojChandran/ECSCluster.git)

# Project Reference

Link 1 : https://oouve.com/</br>
Link 2 : https://www.terraform.io/docs/providers/aws/index.html</br>
Link 3 : https://www.terraform.io/docs/providers/aws/r/s3_bucket.html</br>
Link 4 : https://gist.github.com/nagelflorian/67060ffaf0e8c6016fa1050b6a4e767a</br>
Link 5 : https://d0.awsstatic.com/whitepapers/saas-solutions-on-aws-final.pdf</br>
Link 6 : https://aws-quickstart.s3.amazonaws.com/saas-identity-cognito/doc/saas-identity-and-isolation-with-cognito-on-the-aws-cloud.pdf</br>
Link 7 : https://www.youtube.com/watch?v=mwQ5lipGTBI&t=781s (Title: AWS re:Invent 2018: [REPEAT 1] Deconstructing SaaS: Deep Dive into Building Multi-Tenant Solutions on AWS (ARC418-R1)</br>
Link 8 : https://github.com/terraform-community-modules/tf_aws_ecs/blob/master/main.tf</br>
Link 9 : https://learn.hashicorp.com/terraform/aws/lambda-api-gateway</br>
Link 10 : http://blog.shippable.com/setup-a-container-cluster-on-aws-with-terraform-part-2-provision-a-cluster</br>
Link 11 : https://www.gruntwork.io/devops-checklist/</br>
Link 12 : https://www.youtube.com/watch?v=YQsK4MtsELU&t=1536s</br>
