# AWS IAM Policy
resource "aws_iam_policy" "cw_canary_iam_policy" {
  name        = "cw-canary-iam-policy"
  path        = "/"
  description = "CloudWatch Canary Synthetic IAM Policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "cloudwatch:PutMetricData",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "cloudwatch:namespace": "CloudWatchSynthetics"
                }
            }
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "logs:CreateLogStream",
                "s3:ListAllMyBuckets",
                "logs:CreateLogGroup",
                "logs:PutLogEvents",
                "s3:GetBucketLocation",
                "xray:PutTraceSegments"
            ],
            "Resource": "*"
        }
    ]
})
}

# AWS IAM Role
resource "aws_iam_role" "cw_canary_iam_role" {
  name                = "cw-canary-iam-role"
  description = "CloudWatch Synthetics lambda execution role for running canaries"
  path = "/service-role/"
  #assume_role_policy  = data.aws_iam_policy_document.instance_assume_role_policy.json # (not shown)
  assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}" 
  managed_policy_arns = [aws_iam_policy.cw_canary_iam_policy.arn]
}

# Create S3 Bucket
resource "aws_s3_bucket" "cw_canary_bucket" {
  bucket = "cw-canary-bucket-${random_pet.this.id}"
  #acl    = "private" # UPDATED 
  force_destroy = true

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
# Create S3 Bucket Ownership control - ADDED NEW
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.cw_canary_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
# Create S3 Bucket ACL - ADDED NEW
resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]
  bucket = aws_s3_bucket.cw_canary_bucket.id
  acl    = "private"
}

# AWS CloudWatch Canary
resource "aws_synthetics_canary" "sswebsite2" {
  name                 = "sswebsite2"
  artifact_s3_location = "s3://${aws_s3_bucket.cw_canary_bucket.id}/sswebsite2"
  execution_role_arn   = aws_iam_role.cw_canary_iam_role.arn 
  handler              = "sswebsite2.handler"
  zip_file             = "sswebsite2/sswebsite2v1.zip"
  #runtime_version      = "syn-nodejs-puppeteer-3.1"
  runtime_version      = "syn-nodejs-puppeteer-10.0" # UPDATED June2025
  start_canary = true

  run_config {
    active_tracing = true
    memory_in_mb = 960
    timeout_in_seconds = 60
  }
  schedule {
    expression = "rate(1 minute)"
  }
}

# AWS CloudWatch Metric Alarm for Synthetics Heart Beat Monitor when availability is less than 10 percent
resource "aws_cloudwatch_metric_alarm" "synthetics_alarm_app1" {
  alarm_name          = "Synthetics-Alarm-App1"
  comparison_operator = "LessThanThreshold"
  datapoints_to_alarm = "1" # "2"
  evaluation_periods  = "1" # "3"
  metric_name         = "SuccessPercent"
  namespace           = "CloudWatchSynthetics"
  period              = "300"
  statistic           = "Average"
  threshold           = "90"  
  treat_missing_data  = "breaching" # You can also add "missing"
  dimensions = {
    CanaryName = aws_synthetics_canary.sswebsite2.id 
  }
  alarm_description = "Synthetics alarm metric: SuccessPercent  LessThanThreshold 90"
  ok_actions          = [aws_sns_topic.myasg_sns_topic.arn]  
  alarm_actions     = [aws_sns_topic.myasg_sns_topic.arn]
}