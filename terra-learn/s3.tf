resource "random_id" "random-id" {
    byte_length = 8
  
}

resource "aws_s3_bucket" "s3-buck" {
    bucket = "bucket-${random_id.random-id.hex}"

    force_destroy = true
}