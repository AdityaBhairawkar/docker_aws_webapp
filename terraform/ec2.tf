#create-key-pair
resource "aws_key_pair" "tf_key" {
    key_name = "tf_key"
    public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "local_file" "tf_key" {
    content = tls_private_key.rsa.private_key_openssh
    filename = "tf_key"
}

#create-ec2
resource "aws_instance" "web" {
    ami             = "ami-00ca32bbc84273381"
    instance_type   = "t2.micro"
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    key_name       = "tf_key"

    user_data = file("script.sh")

     tags = {
        Name = "docker-web-app"
     }
}