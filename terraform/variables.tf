variable "aws_regions" {
  description = "List of AWS regions to deploy resources"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "ami_ids" {
  description = "Map of AMI IDs for different regions"
  type        = map(string)
  default = {
    us-east-1 = "ami-0608e4fc86e096366"  # Replace with Packer AMI ID for us-east-1
  }
}