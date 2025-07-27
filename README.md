# f1-dashboard-grafana
Grafana Dashboard for F1 data analysis

# Running locally

You also need to start your F1 API server on localhost 8000. F1 API server defined here: https://github.com/sachinh35/f1-dashboard-backend 

```
docker build -t f1-grafana .
docker run -p 3000:3000 f1-grafana
```