# Environment Isolation with Terraform Workspaces: A Modular EC2 + S3 Deployment on AWS

This project demonstrates how to use **Terraform Workspaces** to isolate multiple AWS environments (`dev`, `staging`, and `production`) from a single, reusable, and modular codebase. It provisions an EC2 instance and an S3 bucket per environment, using remote state management via S3 and DynamoDB for safety and scalability.

> 🔁 **DRY Principle in Action**  
> No duplicated code. No `dev.tf`, `staging.tf`, or `prod.tf`. Just one clean, modular configuration reused across all environments.

---

## 🚀 Project Goals

- Demonstrate environment isolation using **Terraform Workspaces**
- Provision **modular EC2 instances** and **S3 buckets** per environment
- Use a **shared remote backend** (S3 + DynamoDB) to store and lock Terraform state
- Bootstrap EC2 instances with environment-specific metadata via `user_data` (experimental)
- Showcase best practices for **multi-environment infrastructure-as-code**

---

## 🧱 Architecture Overview

```bash

            +---------------------------+
            |  Remote Backend (S3 +     |
            |  DynamoDB for locking)    |
            +-------------+-------------+
                        |
        +----------+----------+----------+
        |          |                     |
+-------v------+ +-------v-------+ +--------v--------+
|  dev workspace | | staging ws  | |  prod workspace |
+-------+--------+ +------+------| +--------+--------+
        |                 |                 |
+-------v------+   +------v------+   +------v--------+
|  EC2 Instance |   | EC2 Instance|   |  EC2 Instance |
+-------+------+   +------+-------+   +--------+-------+
        |                 |                   |
+-------v------+   +------v------+   +--------v--------+
|  S3 Bucket    |   | S3 Bucket   |   |  S3 Bucket      |
+--------------+   +-------------+   +-----------------+

```

```bash
terraform-workspace-demo/
├── env/ # Environment-level configuration and backend
│ ├── main.tf
│ ├── variables.tf
│ ├── backend.tf
│ └── provider.tf
├── modules/
│ ├── ec2/ # Reusable EC2 instance module
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ └── outputs.tf
│ └── s3/ # Reusable S3 bucket module
│ ├── main.tf
│ └── outputs.tf
├── scripts/ # Bootstrap script (used internally by EC2)
│ └── user_data.tpl.sh
├── .gitignore
└── README.md

```

---

## ⚙️ Usage

### 1. Create Remote Backend Resources

Before running `terraform init`, manually create:

- An S3 bucket (e.g. `terraform-workspace-demo-backend`)
- A DynamoDB table (e.g. `terraform-workspace-lock`) with `LockID` as the partition key

### 2. Initialize and Create Workspaces

```bash
cd env/

terraform init

terraform workspace new dev
terraform workspace new staging
terraform workspace new production

```

## 3. Apply Infrastructure Per Workspace

```bash
terraform workspace select dev
terraform apply -auto-approve

terraform workspace select staging
terraform apply -auto-approve

terraform workspace select production
terraform apply -auto-approve

```

---

✅ What You Get
For each workspace (dev, staging, prod):

An EC2 instance tagged with the workspace name

A unique S3 bucket with a randomized suffix

A bootstrap script that attempts to render metadata files like workspace-info.txt

---

📌 Key Takeaways
✅ One codebase, multiple isolated environments

✅ Remote state management with locking

✅ Fully modular infrastructure

✅ Workspace context-driven deployment logic