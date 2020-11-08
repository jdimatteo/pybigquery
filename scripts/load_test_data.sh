bq mk test_pybigquery
bq mk --data_location=asia-northeast1 test_pybigquery_location
bq mk test_pybigquery_alt

bq rm -f -t test_pybigquery.sample
bq rm -f -t test_pybigquery_alt.sample_alt
bq rm -f -t test_pybigquery.sample_one_row
bq rm -f -t test_pybigquery.sample_col_name_same_as_table
bq rm -f -t test_pybigquery.sample_dml
bq rm -f -t test_pybigquery_location.sample_one_row

bq mk --table --schema=$(dirname $0)/schema.json --time_partitioning_field timestamp --clustering_fields integer,string test_pybigquery.sample
bq mk --table --schema=$(dirname $0)/schema.json --time_partitioning_field timestamp --clustering_fields integer,string test_pybigquery_alt.sample_alt
bq load --source_format=NEWLINE_DELIMITED_JSON --schema=$(dirname $0)/schema.json test_pybigquery.sample $(dirname $0)/sample.json

bq mk --table --schema=$(dirname $0)/schema.json --time_partitioning_field timestamp --clustering_fields integer,string test_pybigquery.sample_one_row
bq load --source_format=NEWLINE_DELIMITED_JSON --schema=$(dirname $0)/schema.json test_pybigquery.sample_one_row $(dirname $0)/sample_one_row.json

bq mk --table --schema=$(dirname $0)/schema_col_name_same_as_table.json test_pybigquery.sample_col_name_same_as_table
bq load --source_format=NEWLINE_DELIMITED_JSON --schema=$(dirname $0)/schema_col_name_same_as_table.json test_pybigquery.sample_col_name_same_as_table $(dirname $0)/sample_col_name_same_as_table.json

bq --location=asia-northeast1 load --source_format=NEWLINE_DELIMITED_JSON --schema=$(dirname $0)/schema.json test_pybigquery_location.sample_one_row $(dirname $0)/sample_one_row.json
bq mk --schema=$(dirname $0)/schema.json -t test_pybigquery.sample_dml
