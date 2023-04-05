# import libraries

import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from awsglue.context import GlueContext
from awsglue.job import Job
from pyspark.context import SparkContext
import pyspark.sql.functions as f

# define buckets

load_bucket1 = 's3://datalake-igti-fabio-desafio-mod2/raw-data/estabelecimentos/'
load_bucket2 = 's3://datalake-igti-fabio-desafio-mod2/raw-data/cnaes/'
save_bucket = 's3://datalake-igti-fabio-desafio-mod2/staging-zone'

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# read files

spark_df = (
    spark
    .read
    .format('csv')
    .option('header', True)
    .option('inferSchema', True)
    .option('delimiter', ';')
    .option('enconding', 'latin1')
    .load(load_bucket1)
)

spark_df2 = (
    spark
    .read
    .format('csv')
    .option('header', True)
    .option('inferSchema', True)
    .option('delimiter', ';')
    .option('enconding', 'latin1')
    .load(load_bucket2)
)

# merge dataframes

spark_df = spark_df.join(spark_df2, spark_df.CNAE_PRINCIPAL == spark_df2.CNAE, 'left')

# save data in parquet formar

(
    spark_df
    .coalesce(50)
    .write.mode('overwrite')
    .format('parquet')
    .save(save_bucket)
)

job.commit()