# Define the AWS provider
provider "aws" {
  region  = "eu-central-1"
}

###### Lambda policies, role and function
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Attach the necessary IAM policies to the Lambda role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#### lambda 

data "archive_file" "helloworld" {
  type        = "zip"
  source_file = "helloworld.py"
  output_path = "helloworld.zip"
}

# Lambda function 
resource "aws_lambda_function" "hello_world_function"{
    filename = "helloworld.zip"
    function_name = "helloworld"

    source_code_hash = data.archive_file.helloworld.output_base64sha256

    handler = "helloworld.lambda_handler"
    runtime = "python3.8"

    role = aws_iam_role.iam_for_lambda.arn
}

output "function_name" {
  description = "Name of the Lambda function."

  value = aws_lambda_function.hello_world_function.function_name
}
