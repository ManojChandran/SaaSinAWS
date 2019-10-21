#----20_Flowlogs/main.tf----

resource "aws_security_group" "tf_public_sg" {
  name         = "tf_public_sg"
  vpc_id       = "${var.vpc_id}"

  ingress {
  # TLS (change to whatever ports you need)
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
