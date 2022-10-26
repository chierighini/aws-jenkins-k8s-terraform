# Jenkins Terraform for AWS

## Usage

Ensure that the AWS credentials are properly exported into your environment:

```
$ export AWS_SECRET_KEY_ID=<your_key_id>
$ export AWS_SECRET_ACCESS_KEY=<your_key>
```
Create a `secrets.tfvars` in project root, and put your aws public key in a `jenkins-public-key` variable:

```
jenkins-public-key=<your-public-key>
```

Initialize terraform using 
```
$ terraform init
```

Then run 
```
$ terraform plan -var-file="secrets.tfvars"
```
Check if the changes match the expected infrastructure and run 

```
$ terraform apply -var-file="secrets.tfvars"
```

## KMS

SSH keys is specified in special `secrets.tfvars`