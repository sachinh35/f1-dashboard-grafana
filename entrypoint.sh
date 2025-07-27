#!/bin/bash

/usr/share/grafana/bin/grafana-server --homepath=/usr/share/grafana &
GRAFANA_PID=$!
echo "Starting Grafana..."

# Wait for Grafana (max 60s)
for i in {1..30}; do
  STATUS=$(curl -s http://localhost:3000/api/health | jq -r .database)
  if [[ "$STATUS" == "ok" ]]; then
    echo "Grafana is healthy."
    break
  fi
  echo "Waiting for Grafana to become healthy... ($i)"
  sleep 2
done

if [[ "$STATUS" != "ok" ]]; then
  echo "Timed out waiting for Grafana to become healthy."
  exit 1
fi

# Get Infinity plugin UID
INFINITY_UID=$(curl -s -u admin:admin http://localhost:3000/api/datasources \
  | jq -r '.[] | select(.type=="yesoreyeram-infinity-datasource") | .uid')

if [[ -z "$INFINITY_UID" ]]; then
  echo "Failed to retrieve Infinity datasource UID"
  exit 1
fi

echo "Using Infinity UID: $INFINITY_UID"

# Replace UID in dashboard JSON
sed -i "s|\${INFINITY_UID}|$INFINITY_UID|g" /etc/grafana/provisioning/dashboards/json/f1_years_dashboard.json

# Keep Grafana running
wait $GRAFANA_PID
