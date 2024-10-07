# Configuration of Infrastructure with VPC, RDS, EC2

# Requirements

- Terraform CLI
- AWS CLI

> Note: you should use WSL.

## Steps

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

## 3 - Test result

## 4 - Clean up resources
