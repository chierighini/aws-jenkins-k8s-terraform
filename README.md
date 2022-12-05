# AWS-TERRAFORM-K8S

K8s module for my [terraform code](https://github.com/chierighini/aws-terraform-main).

Made this for a project and barely got it to work.

Needs the following code in the main VPC module:

```

  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/eks-cluster-1" = "shared"
    "kubernetes.io/role/elb"              = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/eks-cluster-1" = "shared"
    "kubernetes.io/role/internal-elb"     = 1
  }
```
I'm not sure if NAT is necessary, but the internet gateway didn't seem to work.

Subnets must be properly tagged and there must be different availability zones.

## Usage

This is a Terraform module and must be called via the `module` resource:

```
module "k8s" {
  source       = "github.com/chierighini/aws-terraform-k8s.git"
  vpc_id       = your_vpc_id
  subnet_ids   = your_subnet_ids
  ssh_key_name = your_ssh_key_name
  aws_azs      = your_vpc_azs
}
```

## In the main Terraform script that you're importing the module from:

Initialize terraform using 
```
$ terraform init
```

Then run 
```
$ terraform plan
```
Check if the changes match the expected infrastructure and run 

```
$ terraform apply
```

To update this module in your terraform script you can run either

```
$ terraform init -upgrade
```

or

```
$ terraform get -update
```