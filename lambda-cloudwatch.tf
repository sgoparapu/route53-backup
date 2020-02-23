resource "aws_cloudwatch_event_rule" "every_minute" {
  name = "every-minute"
  description = "Fires every minute"
  schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_event_target" "route53_lambda_backup_every_five_minutes" {
  rule = "${aws_cloudwatch_event_rule.every_minute.name}"
  target_id = "route53_lambda_backup"
  arn = "${aws_lambda_function.route53_lambda_backup.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_route53_lambda_backup" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.route53_lambda_backup.function_name}"
  principal = "events.amazonaws.com"
  source_arn = "${aws_cloudwatch_event_rule.every_minute.arn}"
}
