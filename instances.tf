resource "aws_instance" "dblog" {
  ami = "ami-0df368112825f8d8f"
  instance_type = "t3.micro"
  key_name = "tom"

  subnet_id = aws_subnet.subnet1.id
  vpc_security_group_ids = ["${aws_security_group.dblog-http.id}"]

  tags = {
    Name = "dblog"
  }

  provisioner "file" {
    source      = "dockerscript.sh"
    destination = "/tmp/dockerscript.sh"
  }

  provisioner "remote-exec" {
  inline = [
    "chmod +x /tmp/dockerscript.sh",
    "sudo /tmp/dockerscript.sh"
  ]
  }

  connection {
    user        = "ubuntu"
    private_key = file(var.key_path)
    host        = self.public_dns
  }
}