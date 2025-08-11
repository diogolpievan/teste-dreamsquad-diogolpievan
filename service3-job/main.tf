locals {
    bucket_name = "service3-job-output-${random_id.bucket_suffix.hex}"
}

resource "random_id" "bucket_suffix" {
    byte_length = 4
}

resource "aws_s3_bucket" "job_bucket" {
    bucket        = local.bucket_name
    force_destroy = true
}

resource "aws_iam_role" "lambda_role" {
    name = "service3-job-lambda-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [{
            Action = "sts:AssumeRole",
            Effect = "Allow",
            Principal = { Service = "lambda.amazonaws.com" }
        }]
    })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "s3_access" {
    name = "service3-job-s3-access"
    role = aws_iam_role.lambda_role.id

    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [{
            Action = [
                "s3:GetObject",
                "s3:PutObject",
                "s3:ListBucket"
            ],
            Effect   = "Allow",
            Resource = [
                aws_s3_bucket.job_bucket.arn,
                "${aws_s3_bucket.job_bucket.arn}/*"
            ]
        }]
    })
}

data "archive_file" "lambda_zip" {
    type        = "zip"
    source_file  = "${path.module}/lambda/lambda_function.py"
    output_path = "${path.module}/lambda_function.zip"
}

resource "aws_lambda_function" "job_function" {
    function_name = "service3-job-function"
    role          = aws_iam_role.lambda_role.arn 
    handler       = "lambda_function.lambda_handler"
    runtime       = "python3.11"
    filename      = data.archive_file.lambda_zip.output_path
    timeout       = 20

    environment {
        variables = {
            BUCKET_NAME = aws_s3_bucket.job_bucket.bucket
        }
    }

    depends_on = [aws_iam_role_policy.s3_access]
}

resource "aws_cloudwatch_event_rule" "job_schedule" {
    name       = "service3-job-schedule"
    description = "Schedule for Service 3 - Job Lambda function"
    schedule_expression = "cron(${var.run_minute_utc} ${var.run_hour_utc} * * ? *)"
}

resource "aws_cloudwatch_event_target" "job_target" {
    rule      = aws_cloudwatch_event_rule.job_schedule.name
    target_id = "service3-job-target"
    arn       = aws_lambda_function.job_function.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
    statement_id  = "AllowExecutionFromCloudWatch"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.job_function.function_name
    principal     = "events.amazonaws.com"
    source_arn    = aws_cloudwatch_event_rule.job_schedule.arn
}


