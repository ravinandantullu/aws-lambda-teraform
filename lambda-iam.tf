resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_assume_role.id

  policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
            "Sid": "Stmt1684709158208",
            "Action": "*",
            "Effect": "Allow",
            "Resource": "*"
            }
        ]
    })
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_assume_role" {
  name               = "lambda_assume_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}