
  
  #launch configuration
  
  resource "aws_launch_configuration" "buildit_lc" {
    name_prefix          = "buildit_lc-"
    image_id             = "${aws_ami_from_instance.buildit_golden.id}"
    instance_type        = "t2.micro"
    security_groups      = ["${aws_security_group.main_dev_sg.id}"]
    key_name             = "${aws_key_pair.mykey.id}"
  
    lifecycle {
      create_before_destroy = true
    }
  }
  
  #ASG 
  
  #resource "random_id" "rand_asg" {
  # byte_length = 8
  #}
  
  resource "aws_autoscaling_group" "buildit_asg" {
    name                      = "asg-${aws_launch_configuration.buildit_lc.id}"
    max_size                  = "3"
    min_size                  = "2"
    health_check_grace_period = "300"
    health_check_type         = "EC2"
    desired_capacity          = "2"
    force_delete              = true
    load_balancers            = ["${aws_elb.buildit_elb.id}"]
  
    vpc_zone_identifier = ["${aws_subnet.main-public-1.id}",
      "${aws_subnet.main-public-2.id}",
    ]
  
    launch_configuration = "${aws_launch_configuration.buildit_lc.name}"
  
    tag {
      key                 = "Name"
      value               = "buildit_asg-instance"
      propagate_at_launch = true
    }
  
    lifecycle {
      create_before_destroy = true
    }
  }
  


