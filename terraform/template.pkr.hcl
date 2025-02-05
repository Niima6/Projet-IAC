packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "example" {
  region           = "us-east-1"      
  source_ami       = "ami-0241b1d769b029352"   
  instance_type    = "t2.micro"                
  ssh_username     = "ec2-user"             
  ami_name         = "custom-ami-{{timestamp}}"
}

build {
  sources = ["source.amazon-ebs.example"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",           
      "sudo yum install -y httpd",    
      "sudo systemctl enable httpd",  
      "sudo systemctl start httpd",
      "sleep 30"
    ]
  }
}