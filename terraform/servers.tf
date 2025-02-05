resource "aws_lb" "exploraria_alb" {
  name               = "ExplorariaALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.subnet-us-1.id, aws_subnet.subnet-us-2.id]
}

resource "aws_lb_target_group" "exploraria_target_group" {
  name     = "exploraria-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "exploraria_http" {
  load_balancer_arn = aws_lb.exploraria_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.exploraria_target_group.arn
  }
}

resource "aws_autoscaling_group" "my_asg" {
  vpc_zone_identifier = [aws_subnet.subnet-us-1.id, aws_subnet.subnet-us-2.id]
  desired_capacity    = 2
  min_size           = 2
  max_size           = 6

  launch_template {
    id      = aws_launch_template.httpdlaunchtemplate.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.exploraria_target_group.arn]
}


resource "aws_db_instance" "mysql_rds" {
  identifier             = "mysql-instance"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  username              = "admin"
  password              = "password"  # Consider using AWS Secrets Manager instead
  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name

  tags = {
    Name = "mysql-rds-instance"
  }
}
