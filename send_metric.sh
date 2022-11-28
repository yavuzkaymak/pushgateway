#!/usr/bin/env bash


read -r -d '' metric << EOM
# TYPE rows_insterted counter
rows_insterted{stage="biw", instance="talend", table_name="prd_customer"} 10 
EOM


echo $metric
echo "$metric" | curl --data-binary @- http://localhost:9091/metrics/job/customer -ks