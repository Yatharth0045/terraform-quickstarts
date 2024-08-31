## Terraform quickstarts

For better follow up of this documentation, set alias for `terraform`
```bash
alias tf=terraform
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