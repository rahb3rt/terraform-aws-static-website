# AWS S3 Static Website Terraform Module
 
Provision a static website hosted through S3 in AWS.

## Features

- Automatically creates SSL certificate to enable HTTPS for Cloudfront distribution 
- Uses CloudFront to serve content
- Automatically create `Record Set` in Route53 to point to Cloudfront distribution
- Creates a waf for the CDN that requires extra configuration to specify rules
- Creates a cloudwatch resource on top of the S3 bucket to be able to watch logs for the application
- Uses S3 bucekt to store the logs to be able to be processed later by some other application such as Kibana


## Prerequisites
- Make sure you're aws keys are set up in `~/.aws/credentials` to run AWS CLI
- Set the domain's servers DNS Management to point to the AWS nameservers listed in the hosted zone 

## Usage

```HCL
module "static-website" {
  source  = "../static-website/aws"
  version = "1.0.0"

  region            = "$region"
  app               = "$app"
  stage             = "$stage"
  
  artifact_dir      = "$path/to/artifact"
  index_page        = "$index-page"
  error_page        = "$error-page"
  enable_versioning = true
  
  cert_arn          = "$ssl-cert"

  domain            = "$root-domain"
  cname             = "$cname"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| region | AWS Deployed Region | string | - | yes |
| app | App name | string | - | yes |
| stage | Deployed stage | string | `dev` | yes |
| artifact_dir | Host directory containing your public file | string | - | yes |
| index_page | Path to point your index page | string | `index.html` | no |
| error_page | Path to point your error page | string | `index.html` | no |
| enable_versioning | Enable enable_versioning for bucket which serves your public file | bool | `false` | false |
| cert_arn | ARN of the SSL Certificate to use for the Cloudfront Distribution. If no value is provided, new certificate will be created automatically | string | - | no |
| domain | Root domain | string | - | yes |
| cname | CNAME record | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| website_url | Website URL |
| s3_bucket |  
