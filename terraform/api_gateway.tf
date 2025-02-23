resource "aws_api_gateway_rest_api" "astroshop_api" {
  name        = var.api_gateway_name
  description = "API Gateway for Astroshop"
}

resource "aws_api_gateway_resource" "products" {
  rest_api_id = aws_api_gateway_rest_api.astroshop_api.id
  parent_id   = aws_api_gateway_rest_api.astroshop_api.root_resource_id
  path_part   = "products"
}

resource "aws_api_gateway_method" "get_products" {
  rest_api_id   = aws_api_gateway_rest_api.astroshop_api.id
  resource_id   = aws_api_gateway_resource.products.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_get_products" {
  rest_api_id             = aws_api_gateway_rest_api.astroshop_api.id
  resource_id             = aws_api_gateway_resource.products.id
  http_method             = aws_api_gateway_method.get_products.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.get_products.invoke_arn
}

resource "aws_api_gateway_deployment" "astroshop_api_deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_get_products,
    aws_api_gateway_integration.lambda_get_product_by_id,
    aws_api_gateway_integration.lambda_cart,
    aws_api_gateway_integration.lambda_checkout
  ]

  rest_api_id = aws_api_gateway_rest_api.astroshop_api.id
  stage_name  = "prod"
}
resource "aws_api_gateway_resource" "product_by_id" {
  rest_api_id = aws_api_gateway_rest_api.astroshop_api.id
  parent_id   = aws_api_gateway_rest_api.astroshop_api.root_resource_id
  path_part   = "product"
}

resource "aws_api_gateway_method" "get_product_by_id" {
  rest_api_id   = aws_api_gateway_rest_api.astroshop_api.id
  resource_id   = aws_api_gateway_resource.product_by_id.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_get_product_by_id" {
  rest_api_id             = aws_api_gateway_rest_api.astroshop_api.id
  resource_id             = aws_api_gateway_resource.product_by_id.id
  http_method             = aws_api_gateway_method.get_product_by_id.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.get_product_by_id.invoke_arn
}

resource "aws_api_gateway_resource" "cart" {
  rest_api_id = aws_api_gateway_rest_api.astroshop_api.id
  parent_id   = aws_api_gateway_rest_api.astroshop_api.root_resource_id
  path_part   = "cart"
}

resource "aws_api_gateway_method" "cart" {
  rest_api_id   = aws_api_gateway_rest_api.astroshop_api.id
  resource_id   = aws_api_gateway_resource.cart.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_cart" {
  rest_api_id             = aws_api_gateway_rest_api.astroshop_api.id
  resource_id             = aws_api_gateway_resource.cart.id
  http_method             = aws_api_gateway_method.cart.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.cart.invoke_arn
}

resource "aws_api_gateway_resource" "checkout" {
  rest_api_id = aws_api_gateway_rest_api.astroshop_api.id
  parent_id   = aws_api_gateway_rest_api.astroshop_api.root_resource_id
  path_part   = "checkout"
}

resource "aws_api_gateway_method" "checkout" {
  rest_api_id   = aws_api_gateway_rest_api.astroshop_api.id
  resource_id   = aws_api_gateway_resource.checkout.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_checkout" {
  rest_api_id             = aws_api_gateway_rest_api.astroshop_api.id
  resource_id             = aws_api_gateway_resource.checkout.id
  http_method             = aws_api_gateway_method.checkout.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.checkout.invoke_arn
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.astroshop_api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.astroshop_api.id
  stage_name    = "prod"
}

