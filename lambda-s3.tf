resource "aws_s3_bucket" "route53-backup-cloudops" {
  bucket = "route53-backup-cloudops"
  acl    = "public-read-write"

  tags = {
    Name        = "route53-backup-cloudops"
    Environment = "Dev"
  }
}
