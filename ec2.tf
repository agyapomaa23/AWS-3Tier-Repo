# First EC2 
resource "aws_instance" "Test-server1" {
ami = "ami-00950d2c99bfd49a6" #eu-west-2
instance_type = var.instance-type
key_name = "flapakp1"
vpc_security_group_ids =[aws_security_group.sec-group.id]
associate_public_ip_address = true
subnet_id = aws_subnet.public_subnet_1.id

tags = {
name = "Test-server1"
}
}

# Second EC2 
resource "aws_instance" "Test-server2" {
ami = "ami-00950d2c99bfd49a6" # eu-west-2
instance_type = var.instance-type
key_name = "flapakp1"
vpc_security_group_ids =[aws_security_group.sec-group.id]
associate_public_ip_address = true
subnet_id = aws_subnet.public_subnet_2.id

tags = {
name = "Test-server2"
}
}