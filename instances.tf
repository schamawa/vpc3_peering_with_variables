########################instances#########################################
resource "aws_instance" "public_ec2" {
   ami = var.image_id
   subnet_id = aws_subnet.subnet1.id
   instance_type = var.instance_type
   vpc_security_group_ids = [aws_security_group.sg1.id]




   tags = {
    name = "prod"
}
}

resource "aws_instance" "private_ec21" {
   ami = var.image_id
   subnet_id = aws_subnet.subnet2.id
   instance_type = var.instance_type
   vpc_security_group_ids = [aws_security_group.sg2.id]




   tags = {
    name = "dev"
}
}

resource "aws_instance" "private_ec22" {
   ami = var.image_id
   subnet_id = aws_subnet.subnet3.id
   instance_type = var.instance_type
   vpc_security_group_ids = [aws_security_group.sg3.id]




   tags = {
    name = "UAT"
}
}

