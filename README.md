# Overview

Every other day a new start-up is in market with a software service,  Most of these offer Software as a Service. Industry has changed much after cloud and Enterprise started relying on these SAAS providers more. With this git repository we are going to implement a multi-tenant SAAS infrastructure in AWS cloud. We will be implementing it as infrastructure as code, using Terraform.

* Terraform vesrion : 0.11.13

# GOAL

Goal is to implement a SAAS infrastructure in AWS using Terraform. Design follows the guidelines presented by Tod Golding ins AWS reinvent 2018 (ARC418-R1 references are provided at the end of this document.)

* Stand alone design for customers to deploy in their own independent environment.
* Share an environment (multi-tenancy), logically separate multiple tenants.
* Must support the ability for multiple independent deployments
* Application and infrastructure can be independently upgraded for a customer or a set of customers.

# SAAS

A method of software delivery and licensing in which software is accessed online via a subscription, rather than bought and installed on individual computers.

Designing SAAS infrastructure means, we are going to create a multi-tenant architecture. Each tenant will have different privilege, access and data isolation.

Key steps and consideration in designing are:

* Tenant on-boarding
* Tenant Isolation
* Metering, Metrics and Analysis
* Management & monitoring
* Billing
* Deployment & agility

### Tenant onboarding
Tenant onboarding is key part in the Multi tenant SAAS application. Static S3 hosting online onboarding and cloudfront for distribution. SAAS will be provided as API's and Cognito will be used for user authentication. Find the reference design from AWS below.

![Onboarding Approach](./images/Auth.png?raw=true "Title")

Our solution modules:
* 01_Route53
* 02_S3hosting
* 03_Cldfrontdistro









# Project Reference

Link 1 : https://oouve.com/</br>
Link 2 : https://www.terraform.io/docs/providers/aws/index.html</br>
Link 3 : https://www.terraform.io/docs/providers/aws/r/s3_bucket.html</br>
Link 4 : https://gist.github.com/nagelflorian/67060ffaf0e8c6016fa1050b6a4e767a</br>
Link 5 : https://d0.awsstatic.com/whitepapers/saas-solutions-on-aws-final.pdf</br>
Link 6 : https://aws-quickstart.s3.amazonaws.com/saas-identity-cognito/doc/saas-identity-and-isolation-with-cognito-on-the-aws-cloud.pdf</br>
Link 7 : https://www.youtube.com/watch?v=mwQ5lipGTBI&t=781s (Title: AWS re:Invent 2018: [REPEAT 1] Deconstructing SaaS: Deep Dive into Building Multi-Tenant Solutions on AWS (ARC418-R1)</br>
