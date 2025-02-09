resource "aws_iam_role" "ec2_role" {
 name = "ec2_role"


 assume_role_policy = <<EOF
 {
   "Version": "2012-10-17",
   "Statement": [
     {
       "Effect": "Allow",
       "Principal": {
         "Service": "ec2.amazonaws.com"
       },
       "Action": "sts:AssumeRole"
     }
   ]
 }
 EOF
}


resource "aws_iam_role_policy_attachment" "ec2_role_attachment" {
 role       = aws_iam_role.ec2_role.name
 policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}


resource "aws_iam_instance_profile" "ec2_instance_profile" {
 name = "ec2_instance_profile"
 role = aws_iam_role.ec2_role.name
}
