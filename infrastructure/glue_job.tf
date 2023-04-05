## create glue job

resource "aws_cloudwatch_log_group" "edc-mod2-desafio" {
  name              = "edc-mod2-desafio-log-group"
  retention_in_days = 3
}

resource "aws_glue_job" "edc-mod2-desafio" {
  name         = "edc-mod2-desafio-job-spark"
  role_arn     = aws_iam_role.glue_role.arn
  glue_version = "3.0"
  default_arguments = {
    "--continuous-log-logGroup"          = aws_cloudwatch_log_group.edc-mod2-desafio.name
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-continuous-log-filter"     = "true"
    "--enable-metrics"                   = ""
  }
  command {
    script_location = "s3://${aws_s3_bucket.datalake.bucket}/emr-code/job_spark.py"
  }
}