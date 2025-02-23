resource "aws_db_instance" "mysql_rds" {
  identifier             = "mysql-instance"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  username              = "admin"
  password              = "password" 
  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name

  tags = {
    Name = "mysql-rds-instance"
  }
}

resource "aws_codedeploy_app" "backend" {
  name = "Astroshop-Backend"
}

resource "aws_codedeploy_deployment_group" "backend_deployment" {
  app_name               = aws_codedeploy_app.backend.name
  deployment_group_name  = "backend-deployment-group"
  service_role_arn       = aws_iam_role.codedeploy_role.arn

  deployment_config_name = "CodeDeployDefault.OneAtATime"

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "backend-instance"
    }
  }
}

resource "aws_instance" "frontend" {
  ami           = var.ami_ids["us-east-1"]
  instance_type = "t2.micro"
  key_name      = var.ec2_key_pair

  network_interface {
    device_index          = 0
    subnet_id             = aws_subnet.subnet-us-1.id
    associate_public_ip_address = true
    security_groups       = [aws_security_group.instances.id]
  }

  tags = {
    Name = "frontend-instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF
}


