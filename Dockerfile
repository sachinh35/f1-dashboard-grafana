FROM grafana/grafana-oss

USER root

# Install tools
RUN apk add --no-cache jq curl

# Install the Infinity plugin
RUN grafana-cli plugins install yesoreyeram-infinity-datasource
# Make sure plugin directory is correct
ENV GF_PLUGINS_ALLOW_LOADING_UNSIGNED_PLUGINS=yesoreyeram-infinity-datasource

COPY provisioning /etc/grafana/provisioning
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
