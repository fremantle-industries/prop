FROM nginx:1.21.5-alpine
CMD sh -c 'envsubst \
  "\$PROP_HOST \$WORKBENCH_HOST \$HISTORY_HOST \$SLURPEE_HOST \$LIVEBOOK_HOST \$GRAFANA_HOST \$PROMETHEUS_HOST \$RANCH_HTTP_PORT \$REVERSE_PROXY_HTTP_PORT" \
  < /etc/nginx/templates/nginx.conf \
  > /etc/nginx/nginx.conf \
  && nginx -g "daemon off;"'
