# Provision for an S3 bucket that will host a static website
The purpose of this document is to build a static website that will be used to host my resume. This will be hosted on an S3 bucket that will also be deployed on AWS

## Instructions 

# IAM Role 
Create an IAM role and assign the role permission to upload and make changes to S3 buckets

# Build all HTML files for website
The website would need 2 files one for the landing page and the second for the error page to catch errors 

   * Build the index.html file to host the website and upload into directory 
   * Build the error.html file to be the landing page for error directories 

# Variable file
This file will host all variables, this will aid with allowing certain parameters to be changed more effieciently if needed. 

   * Bucket name -- 
   * HTML file name 
   * error file name 

# Main file 
Deploy the S3 bucket in the predefined region and upload the index file into the bucket. Perform the necessary configuration for the static webstite and return the dns name for the website

  * Define the region 
  * Provision for the bucket 
  * Block public access to the bucket
  * Configure the S3 bucket for the static website
  * Add policy to allow access to the HTML file 
  * Upload the index and error files to the S3 Bucket as objects 

  # Issues faced 
   When executing this script at first I ran into the following error 

    !! api error AccessControlListNotSupported: The bucket does not allow ACLs !! 
I resolved the issue by adding the ownership control policy for the cuket and also removing the acl parameter in the s3 object provision

