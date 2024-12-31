resource "aws_key_pair" "deployer" {
 key_name   = "keypairname"
 public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDSVEoEp8K2uT/fuTUG5SrmPW1GmZCR5ak5eScOev84gl6kchavHwHku4U4J6J6OvKGuq+57XmWeIiReo9w3TBIFB6tWOQr2+p0D3balZmSA7WNN65OU+xdITIr68/AeqyKqGiS7SH8WYbI/mhKiYtzWfX+HoqLDdSejl8sH4/FCotzyTVh62SWJZnMtrXs821gbzDQT42oTIzL13ei9Mcrx8H6CKHhcCYi1/W11+Ptrpq1iq20WQPoGf8aJFx63J+HirEEcGCGHSq5Zf1KtGldt71AJ+3aMDx5Pm3JvWAySbOX71ExAymX0xADP0l+UH2C1W6o0fIXjzuaKVMxDaUEsDo2n6fjRi90b7ishc8CY8NKnwT9pr2PZjQTr5g/gbIxbKsI19KoCV3NlApCXyXJ/u/9iFlFsxLnPrxO2GSvyFrKDvKnSmTfDQlOBtCLr2CGCjXb3ewOHVo5x4O5Tw7oXEeoFvD3igHnxg3KuCS2yIOA8sC15i4UcKhkLYOtLGqAz5XGGvEIqhgL9j9y0vtDxosA7rZ9UlrhrqFQuIOajCW26YTQRWijgd5QSBn/0b83H2u9nIv/i4cMH3vy9CWDuKhewQhE0lDFI2DZsFw9EHaNR3eX6ZQpOuZp55fYG4xDW4IHUqiHkmTIP4eGXWkXuL00+RXPPokMvN/h0Oc0nQ== emezu1234@gmail.com"
}
resource "aws_launch_template" "web" {
 name_prefix       = "web-launch-configuration-"
 image_id          = "ami-0e001c9271cf7f3b9"  # Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
 instance_type     = "t2.micro"
 vpc_security_group_ids   = [aws_security_group.web.id]
 iam_instance_profile {
   name = aws_iam_instance_profile.ec2_instance_profile.name
 }
 key_name          = aws_key_pair.deployer.key_name


 user_data = filebase64("${path.module}/user_data.sh")
}


resource "aws_autoscaling_group" "web" {
 min_size             = 2
 max_size             = 4
 desired_capacity     = 2
 vpc_zone_identifier  = [aws_subnet.public_a.id, aws_subnet.public_b.id]
 launch_template {
   id      = aws_launch_template.web.id
   version = "$Latest"
 }


 tag {
   key                 = "Name"
   value               = "DockerWebApp"
   propagate_at_launch = true
 }


 # Attach the Auto Scaling group to the ELB
 depends_on = [aws_lb.web]


  # to give time for the ec2 instance status check to be = checks passed before accepting traffic
 provisioner "local-exec" {
   command = "sleep 120"
 }
}
