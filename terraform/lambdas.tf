resource "aws_lambda_function" "get_products" {
  function_name = "get_products"
  runtime       = var.lambda_runtime
  handler       = "index.getProducts"
  role          = aws_iam_role.lambda_role.arn
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout

  filename         = "../lambdas/get_products.zip"
  source_code_hash = filebase64sha256("../lambdas/get_products.zip")

  environment {
    variables = {
      DB_HOST     = aws_db_instance.mysql_rds.address
      DB_USER     = "admin"
      DB_PASSWORD = "password"
      DB_NAME     = "astroshop"
    }
  }
}

resource "aws_lambda_function" "get_product_by_id" {
  function_name = "get_product_by_id"
  runtime       = var.lambda_runtime
  handler       = "index.getProductById"
  role          = aws_iam_role.lambda_role.arn
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout

  filename         = "../lambdas/get_product_by_id.zip"
  source_code_hash = filebase64sha256("../lambdas/get_product_by_id.zip")

  environment {
    variables = {
      DB_HOST     = aws_db_instance.mysql_rds.address
      DB_USER     = "admin"
      DB_PASSWORD = "password"
      DB_NAME     = "astroshop"
    }
  }
}

resource "aws_lambda_function" "cart" {
  function_name = "cart"
  runtime       = var.lambda_runtime
  handler       = "index.cart"
  role          = aws_iam_role.lambda_role.arn
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout

  filename         = "../lambdas/cart.zip"
  source_code_hash = filebase64sha256("../lambdas/cart.zip")
}

resource "aws_lambda_function" "checkout" {
  function_name = "checkout"
  runtime       = var.lambda_runtime
  handler       = "index.checkout"
  role          = aws_iam_role.lambda_role.arn
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout

  filename         = "../lambdas/checkout.zip"
  source_code_hash = filebase64sha256("../lambdas/checkout.zip")
}
