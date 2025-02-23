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

variable "lambda_runtime" {
  description = "Runtime for the AWS Lambda functions"
  type        = string
  default     = "nodejs18.x"
}

variable "lambda_memory_size" {
  description = "Memory size for the AWS Lambda functions"
  type        = number
  default     = 128
}

variable "lambda_timeout" {
  description = "Timeout for the AWS Lambda functions"
  type        = number
  default     = 10
}

variable "api_gateway_name" {
  description = "Name of the API Gateway"
  type        = string
  default     = "astroshop-api"
}