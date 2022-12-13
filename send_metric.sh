#!/usr/bin/env bash

## send metric to pushgateway
read -r -d '' metric << EOM
# TYPE rows_insterted counter
rows_insterted{stage="biw", instance="talend", table_name="prd_customer"} 10 
EOM

echo sending metric to Pushgateway
echo $metric
echo "$metric" | curl --data-binary @- http://localhost:9091/metrics/job/customer -ks


## send metric to influxdb
read -r -d '' metric << EOM
rows_insterted,stage=biw,instance=talend,table_name=prd_customer value=10
EOM

echo sending metric to Influxdb
echo $metric
echo "$metric" | curl -i -XPOST --data-binary @- http://localhost:8086/write?db=mammut -s

## send metric to graphite
read -r -d '' metric << EOM
rows_insterted;stage=biw;instance=talend;table_name=prd_customer 10 $(date +%s)
EOM

echo sending metric to Influxdb
echo $metric
echo "$metric" | nc localhost 2003 -q0