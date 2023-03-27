# upload scripts to datalake bucket

resource "aws_s3_object" "job_spark" {
    bucket = aws_s3_bucket.datalake.id
    key    = "emr-code/job_spark.py"
    acl    = "private"
    source  = "../etl/job_spark.py"
    etag   = filemd5("../etl/job_spark.py")

}