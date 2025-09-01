# output "ip-address" {
#   value = aws_instance.server.public_ip
# }

output "s3-bucket-name" {
  value = aws_s3_bucket.s3-buck.id
}

# output "s3-bucket-id" {
#   value = aws_s3_bucket.s3-buck.bucket
# }