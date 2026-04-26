output "s3_url" {
    value = aws_s3_bucket_website_configuration.demo.website_endpoint
  
}

output "bucket_name" {
    value = aws_s3_bucket.demo-bucket.id
      
}