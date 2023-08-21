output "function_name" {
  description = "Name of the Lambda function."

  value = aws_lambda_function.hello_world.function_name
}

output "endpoint_url"{
    value = aws_api_gateway_deployment.api_deployment.invoke_url
}

output "execution_arn" {
  value = aws_api_gateway_rest_api.rest_api.execution_arn
}
