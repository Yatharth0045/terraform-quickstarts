## Terraform quickstarts

For better follow up of this documentation, set alias for `terraform`
```bash
alias tf=terraform
```

### Enable Pre-commit

```bash
## Install pre-commit
pre-commit install

## Add pre-commit config
cat <<EOF > .pre-commit-config.yaml
repos:
- repo: https://github.com/antonbabenko/pre-commit-terraform
  rev: <VERSION> # Get the latest from: https://github.com/antonbabenko/pre-commit-terraform/releases
  hooks:
    - id: terraform_fmt
EOF

## Add hooks as per requirements
```yaml
    hooks:
    - id: ....
    - id: ....
```

### Variable precedence

Uncomment code in tfvars to proceed and test

```bash
cd variable-precedence
export TF_VAR_byte_length=8
tf init
tf plan -var 'byte_length=6' -var-file values.tfvars
tf plan -var 'byte_length=6'
tf plan
```

## Dependency graph

```bash
cd dependency-graph
tf init
tf graph
tf graph | dot -Tsvg > graph.svg
```

## Meta-arguments: `count` and `for_each`

```bash
cd meta_arguments
tf init
tf plan
tf apply
```

## VPC Infrastucture Setup via Terraform

### Pre-requisites
1. Create AWS IAM User with admin permission and create security credentials: [AWS IAM](https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-1#/security_credentials?section=IAM_credentials)

2. Setup aws access and secret credentials
    ```bash
    ## Configure access and secret keys
    aws configure --profile kodekloud

    ## Export Profile and Region
    export AWS_PROFILE=kodekloud
    export AWS_REGION='us-east-1'
    ```

3. Create s3 backend bucket
    ```bash
    aws s3api create-bucket --bucket yatharth-terraform-state-bucket
    ```

4. Create dynamodb table
    ```bash
    aws dynamodb create-table --table-name terraform-locking --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 --deletion-protection-enabled
    ```

### Provision Infra
1. Setup VPC and EC2 instance
    ```bash
    tf init -reconfigure
    tf plan
    tf apply
    ```

### Deprovision Infra and cleanup
1. Cleanup terraform
    ```bash
    tf destroy
    ```

2. Cleanup s3 bucket
    ```bash
    aws s3 rm s3://yatharth-terraform-state-bucket --recursive
    aws s3 rb s3://yatharth-terraform-state-bucket --force
    ```

3. Delete dynamodb table
    ```bash
    aws dynamodb update-table --table-name terraform-locking --no-deletion-protection-enabled
    aws dynamodb delete-table --table-name terraform-locking
    ```
