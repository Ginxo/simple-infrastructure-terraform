resource "aws_api_gateway_rest_api" "api" {
  name = "${var.environment}-api-gateway"
  description = "Proxy to handle requests to our API"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = var.environment

  depends_on = [aws_api_gateway_integration.integration_api_users_endpoints]
}

