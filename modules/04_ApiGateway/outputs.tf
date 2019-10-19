#----04_ApiGateway/outputs.tf----

output "tf_api_gateway_id" {
  value = "${aws_api_gateway_rest_api.tf_api_gateway.id}"
}
output "tf_api_root_resource_id" {
  value = "${aws_api_gateway_rest_api.tf_api_gateway.root_resource_id}"
}
