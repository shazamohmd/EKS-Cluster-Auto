terraform {
  backend "s3" {
    bucket = "clusterbucket0"
    key = "statefile"
    region = "us-east-1"
  }
}