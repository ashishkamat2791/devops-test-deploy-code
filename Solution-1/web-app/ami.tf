 #AMI 
  
  resource "random_id" "golden_ami" {
    byte_length = 8
  }
  
  resource "aws_ami_from_instance" "buildit_golden" {
    name               = "media_ami-${random_id.golden_ami.b64}"
    source_instance_id = "${aws_instance.buildit_dev_node.id}"
  
  }