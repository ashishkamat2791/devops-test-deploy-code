 resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
resource "aws_instance" "buildit_dev_node" {
    instance_type = "t2.micro"
    ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
    key_name = "${aws_key_pair.mykey.key_name}"

  provisioner "local-exec" {
    command = <<EOD
    sudo -i
   sudo   apt-get install curl python-software-properties
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
   sudo apt-get install nodejs
    node --version
    npm --version
EOD

  }
  connection {
    host = "${self.public_ip}"
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  } 
  
} 
  
