#!/usr/bin/env bash

## PUSHGATEWAY
read -r -d '' metric << EOM
# TYPE rows_inserted gauge
rows_inserted{stage="biw", instance="talend", table_name="prd_customer"} 10 
EOM

echo sending metric to Pushgateway
echo $metric
echo "$metric" | curl --data-binary @- http://localhost:9091/metrics/job/customer -ks



## INFLUXDB
read -r -d '' metric << EOM
rows_inserted,stage=biw,instance=talend,table_name=prd_customer value=10
EOM

echo sending metric to Influxdb
echo $metric
echo "$metric" | curl -i -XPOST --data-binary @- http://localhost:8086/write?db=mammut -s


## GRAPHITE
read -r -d '' metric << EOM
rows_inserted;stage=biw;instance=talend;table_name=prd_customer 10 $(date +%s)
EOM

echo sending metric to GRAPHITE
echo $metric
echo $metric | nc localhost 2003 -q 0