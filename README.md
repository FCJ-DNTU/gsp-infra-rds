# Configuration of Infrastructure with VPC, RDS, EC2

# Requirements

- Terraform CLI
- AWS CLI

> Note: you should use WSL.

# Note

- If you want to change something, you should look into `deploy-infrastructure/terraform.tf`. All of variables are setup in there. Pay attention to these local variables

```hcl
locals {
  region = "ap-southeast-2"
  author = "FCJ-DNTU"
  network_root_name = "FCJ-Lab"
  compute_root_name = "FCJ-Lab"
  vpc_cidr = "10.0.0.0/16"
  db_username = "admin"
  db_password = "letmein12345"
  db_name = "fcjresbar"
  key_name = "general-use"
  service_discovery_namespace_name = "fcjresbar.internal"
  service_discovery_service_name = "backend"
}
```

- You must have a user that is granted enough permissions.

# Steps

## 1 - Deploy the infrastructure

Change current working directiry to `deploy-infrastructure`, you need to link modules in configuration with this command

```bash
terraform get
```

Result Logs:

```bash
- compute in modules/compute
- infrastructure in modules/infrastructure
- rds in modules/rds
- security in modules/security
```

Init **terraform**

```bash
terraform init
```

Result Logs:

```bash
Initializing the backend...
Initializing modules...
Initializing provider plugins...
...

Terraform has been successfully initialized!

...
```

Now we have to validate our configuration and plan it

```bash
terraform plan
```

Then tell Terraform apply the plan to deploy our infrastructure (Terraform will ask you, just say "yes").

```bash
terraform apply
```

Result:

![2024-10-07_221831](https://github.com/user-attachments/assets/2bc86038-345b-4588-ae82-54abeed1471d)

## 2 - Insert Data

Next, we'll need to insert data into our Database. First, you need to get EC2 Public IPv4 in Management Console or in Terraform Output Deployment, then upload `insert-data` directory to EC2 Instance.

```bash
chmod 400 key/key-name.pem
scp -i key/key-name.pem -r insert-data ubuntu@"ec2-public-ipv4":/home/ubuntu
```

![2024-10-07_222250](https://github.com/user-attachments/assets/646cf53d-01ab-4573-b261-c289bd7178f7)

Connect to this EC2 Instance, check result and permission for script execution

```bash
chmod 700 deploy.sh
```

![2024-10-07_222344](https://github.com/user-attachments/assets/e473dbba-a9f4-43c7-ba89-2b4de12e0a8b)

Replace RDS Endpoint in `deploy.sh`

![2024-10-07_222801](https://github.com/user-attachments/assets/4ee3be1f-91f2-4996-b92c-7ff21aab3707)

Now, you should run `deploy.sh`

![2024-10-07_222801](https://github.com/user-attachments/assets/3f819cfb-c389-49a2-bd70-fcf7fe6b2607)

![2024-10-07_223238](https://github.com/user-attachments/assets/5a7139ae-0705-4fdd-9c67-4cb0962bd400)

## 3 - Test result

Connect to MySQL Server in RDS

```bash
mysql -h "you-rds-endpoint" -u admin -p
```

![2024-10-07_223518](https://github.com/user-attachments/assets/be4ae0a2-01f7-49cd-b436-47d49372899d)

Perform some query

```sql
USE fcjresbar;
SELECT * FROM Clients;
```

```sql
SELECT * FROM Tables;
```

![2024-10-07_223558](https://github.com/user-attachments/assets/58ff53a6-75fe-474a-9650-8052a5b169a7)

## 4 - Clean up resources

Change directory to `deploy-infrastructure`

```bash
cd deploy-infrastructure/
```

Destroy resources (Terraform will ask you, just say "yes").

```bash
terraform destroy
```

![2024-10-07_225053](https://github.com/user-attachments/assets/4f3cef0e-5258-413b-88b8-c2ceba965a85)
