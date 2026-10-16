#This is a Terraform configuration file that deploys a static website to AWS S3.

# Identifies the AWS provider and sets the region to "us-east-1".
provider "aws" {
  region = var.region
}

# Creates an S3 bucket to host the static website.
resource "aws_s3_bucket" "portfolio_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = "StaticWebsiteBucket"
  }
} 

#bucket ownership is set to the AWS account that is running the Terraform configuration. This ensures that the S3 bucket is owned by the correct AWS account.
resource "aws_s3_bucket_ownership_controls" "ownership_controls" {
  bucket = aws_s3_bucket.portfolio_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#disables public access to the S3 bucket to ensure that the website is not accessible to the public.
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.portfolio_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}



#enables static website hosting on the S3 bucket and specifies the index document as "index.html".
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.portfolio_bucket.id

  index_document {
    suffix = var.html_file_name
  }
  error_document {
    key = var.error_file_name
  }
}

#attach a policy to the S3 bucket to allow public read access to the website files. The policy allows anyone to read the objects in the bucket, which is necessary for a static website.
resource "aws_s3_bucket_policy" "portfolio_bucket_policy" {
  bucket = aws_s3_bucket.portfolio_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.portfolio_bucket.arn}/*"
      }
    ]
  })
}

#Upload index.html file to the S3 bucket and set the ACL to "public-read" to make the file publicly accessible. The source parameter specifies the local path to the index.html file that will be uploaded to the S3 bucket.
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.portfolio_bucket.id
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.portfolio_bucket.id
  key    = "error.html"
  source = "error.html"
  content_type = "text/html"
}
