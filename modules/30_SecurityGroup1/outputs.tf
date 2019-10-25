#----31_SecurityGroup1/outputs.tf----

output "tf_securitygroup_01_id" {
  value = "${aws_security_group.tf_public_sg.id}"
}
