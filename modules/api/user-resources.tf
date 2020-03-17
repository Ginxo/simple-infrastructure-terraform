resource "aws_api_gateway_resource" "resource_api_users" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.resource_api.id
  path_part   = "tm-users"
}

resource "aws_api_gateway_resource" "resource_api_users_endpoints" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.resource_api_users.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "method_api_users_endpoints" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource_api_users_endpoints.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "integration_api_users_endpoints" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource_api_users_endpoints.id
  http_method = aws_api_gateway_method.method_api_users_endpoints.http_method
  connection_type = "VPC_LINK"
  connection_id = aws_api_gateway_vpc_link.vpc_link.id
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "http://${var.lb_dns}:8080/api/{proxy}"

  request_parameters =  {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}