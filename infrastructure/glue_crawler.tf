# create glue crawler

resource "aws_glue_crawler" "processed_data_crawler" {
  name          = "processed-data-crawler"
  role          = aws_iam_role.glue_role.arn
  database_name = "edc_mod2_desafio_database"

  s3_target {
    path = "s3://${aws_s3_bucket.datalake.bucket}/staging-zone/"
  }

  schema_change_policy {
    update_behavior = "UPDATE_IN_DATABASE"
    delete_behavior = "LOG"
  }

}