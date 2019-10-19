#----04_ApiGateway/main.tf-----

# The "REST API" is the container for all of the other API Gateway objects we will create.
resource "aws_api_gateway_rest_api" "tf_api_gateway" {
  name = "${var.api_rest_container_name}"
  description = "Terraform REST api container"

# Valid values: EDGE, REGIONAL or PRIVATE
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.tf_api_gateway.id}"
  parent_id   = "${aws_api_gateway_rest_api.tf_api_gateway.root_resource_id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = "${aws_api_gateway_rest_api.tf_api_gateway.id}"
  resource_id   = "${aws_api_gateway_resource.proxy.id}"
  http_method   = "ANY"
  authorization = "NONE"
}
