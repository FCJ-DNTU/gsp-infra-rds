# Configuration of Infrastructure with VPC, RDS, EC2

# Requirements

- Terraform CLI
- AWS CLI

> Note: you should use WSL.

# Note

- If you want to change something, you should look into `deploy-infrastructure/terraform.tf`. All of variables are setup in there.

```hcl
locals {
  region = "ap-southeast-1"
  author = "FCJ-DNTU"
  network_root_name = "FCJ-Lab"
  compute_root_name = "FCJ-Lab"
  vpc_cidr = "10.0.0.0/16"
  db_username = "admin"
  db_password = "letmein12345"
  db_name = "fcjresbar"
  key_name = "general-use"
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

Then tell Terraform apply the plan to deploy our infrastructure

```bash
terraform apply
```

Result:

**INSERT IMAGE HERE**

## 2 - Insert Data

Next, we'll need to insert data into our Database. First, you need to get EC2 Public IPv4 in Management Console or in Terraform Output Deployment, then upload `insert-data` directory to EC2 Instance.

```bash
chmod 400 key/key-name.pem
scp -i key/key-name.pem -r insert-data ubuntu@"ec2-public-ipv4":/home/ubuntu
```

**INSERT IMAGE HERE**

Connect to this EC2 Instance and check result

**INSERT IMAGE HERE**

Provide permission for script execution

```bash
chmod 700 deploy.sh
```

Replace RDS Endpoint in `deploy.sh`

**INSERT IMAGE HERE**

Now, you should run `deploy.sh`

**INSERT IMAGE HERE**

**INSERT IMAGE HERE**

## 3 - Test result

Connect to MySQL Server in RDS

```bash
mysql -h "you-rds-endpoint" -u admin -p
```

**INSERT IMAGE HERE**

Perform some query

```sql
USE fcjresbar;
SELECT * FROM Clients;
```

```sql
SELECT * FROM Tables;
```

**INSERT IMAGE HERE**

## 4 - Clean up resources

Change directory to `deploy-infrastructure`

```bash
cd deploy-infrastructure/
```

Destroy resources

```bash
terraform destroy
```

**INSERT IMAGE HERE**
