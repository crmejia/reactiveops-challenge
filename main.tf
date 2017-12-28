provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "example" {
  ami = "ami-3066c15e"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  tags {
    Name = "reactiveops-challenge"
  }

  connection {
    # The default username for our AMI
    user = "ubuntu"
    # The connection will use the local SSH agent for authentication.
  }
  # The name of our SSH keypair we created above.
  key_name = "${aws_key_pair.auth.id}"

}

resource "aws_security_group" "instance" {
  name = "reachtiveops-challenge-instance"
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "${var.ssh_port}"
    to_port = "${var.ssh_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}
