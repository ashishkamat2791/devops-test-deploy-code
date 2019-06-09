 #load balancer
  
  resource "aws_elb" "buildit_elb" {
    name = "buildit-elb" 
    subnets = ["${aws_subnet.main-public-1.id}",
      "${aws_subnet.main-public-2.id}",
    ]
  
    security_groups = ["${aws_security_group.buildit_public_sg.id}"]
  
    listener {
      instance_port     = 3000
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    }
  
    health_check {
     healthy_threshold   = "2"
      unhealthy_threshold = "2"
      timeout             = "3"
      target              = "TCP:80"
      interval            = "30"
    }
  
    cross_zone_load_balancing   = true
    idle_timeout                = 400
    connection_draining         = true
    connection_draining_timeout = 400
  
    tags {
      Name = "buildit-elb"
    }
  }
