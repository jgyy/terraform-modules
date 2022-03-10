# LB logs

data "aws_elb_service_account" "main" {
  count = length(var.access_logs)
}

resource "aws_s3_bucket" "lb_logs" {
  count  = length(var.access_logs)
  bucket = "${var.lb_name}-lb-logs"

  tags = {
    Name = "${var.lb_name}-lb-logs"
  }
}


resource "aws_s3_bucket_public_access_block" "lb-logs" {
  count  = length(var.access_logs)
  bucket = aws_s3_bucket.lb_logs[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}
