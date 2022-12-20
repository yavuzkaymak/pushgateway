# pushgateway

This docker compose stack spins up grafana, graphite, influxdb, prometheus and pushgateway.
send_metric.sh sends the same metric to pushgateway, graphite and inlufxdb.
In grafana you can find a comparision dashboard which visualizes all three tsdbs.

## How to start
First generate ssl certificates for grafana
```
docker compose -f generate-certs.yml run --rm cert  
```
```

docker compose up -d 

```

## Send some metric

```

./send_metric.sh
```

Check [grafana](https://localhost:3000)