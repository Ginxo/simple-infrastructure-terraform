resource "aws_api_gateway_resource" "resource_api_users" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.resource_api.id
  path_part   = "users"
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