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
