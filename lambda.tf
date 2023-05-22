data "archive_file" "init" {
  type        = "zip"
  source_file = "eventhandler.py"
  output_path = "outputs/eventhandler.zip"
}

resource "aws_lambda_function" "eventhandler" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "outputs/eventhandler.zip"
  function_name = "eventhandler"
  role          = aws_iam_role.lambda_assume_role.arn
  handler       = "eventhandler.getContactDetails"

  #source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.8"

  environment {
    variables = {
      foo = "bar"
    }
  }
}