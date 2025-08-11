resource "aws_security_group" "test-dreamsquad-diogolpievan-sg" {
    name        = "test-dreamsquad-diogolpievan-sg"
    description = "Allow incoming HTTP and HTTPS connections."

    ingress {
        description = "HTTP to EC2"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
        description = "HTTPS to EC2"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Permitir todo trafego"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
        Name = "test-dreamsquad-diogolpievan-sg"
    }

}
