# EFS Security Group 
resource "aws_security_group" "efs" {
  name        = "EFS-Access"
  description = "Manage access to EFS"
  vpc_id      = "${aws_vpc.da-wordpress-vpc.id}"

  ingress {
    description = "Access to NFS"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    #security_groups = ["${aws_security_group.ecs.id}"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EFS-Access"
  }
}
