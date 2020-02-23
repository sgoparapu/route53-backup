data "archive_file" "route53_lambda_backup" {
  type        = "zip"
  source_file = "route53_lambda_backup.py"
  output_path = "outputs/route53_lambda_backup.zip"
}
resource "aws_lambda_function" "route53_lambda_backup" {
  filename      = "outputs/route53_lambda_backup.zip"
  function_name = "route53_lambda_backup"
  role          = "${aws_iam_role.lambda_role.arn}"
  handler       = "route53_lambda_backup.lambda_handler"
  source_code_hash = "${filebase64sha256("outputs/route53_lambda_backup.zip")}"
  runtime       = "python3.8"
}
