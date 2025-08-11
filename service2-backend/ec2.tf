resource "aws_instance" "test-dreamsquad-diogolpievan" {
    ami                    = var.ami_id
    instance_type          = var.instance_type
    vpc_security_group_ids = [aws_security_group.demoday-test-dreamsquad-diogolpievan-sg.id]
    user_data              = file("script.sh")

    tags = {
        Name = "test-dreamsquad-diogolpievan"
    }

}
