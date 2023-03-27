# create glue crawler to process raw data

resource "aws_glue_catalog_database" "datalake_desafio" {
  name = "edc_mod1_desafio_database"
}

resource "aws_glue_crawler" "datalake_desafio" {
  name          = "raw-data-crawler"
  role          = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.datalake_desafio.name

  s3_target {
    path = "s3://${aws_s3_bucket.datalake.bucket}/raw-data/"
  }

  configuration = <<EOF
{
   "Version": 1.0,
   "Grouping": {
      "TableGroupingPolicy": "CombineCompatibleSchemas" }
}
EOF

  tags = local.common_tags
}