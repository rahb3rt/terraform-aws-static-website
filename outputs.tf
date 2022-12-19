output "website_url" {
  value = "https://${var.cname}.${var.domain}"
}

output "s3_bucket" {
  value = "${var.app}-site-bucket--stage-${var.stage}"
}

/* get the logging s3 bucket */
data "aws_s3_bucket" "logging" {
  bucket = "${var.app}-logs"
}