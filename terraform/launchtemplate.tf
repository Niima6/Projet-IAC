resource "aws_launch_template" "httpdlaunchtemplate" {
  name = "httpdlaunchtemplate"
  image_id = var.ami_ids["us-east-1"]
  instance_type = "t2.micro"
  

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.instances.id]
  }

  tag_specifications {
    resource_type = "instance"
    

    tags = {
      Name = "App-Instance"
    }
  }
}