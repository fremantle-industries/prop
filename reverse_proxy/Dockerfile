FROM nginx:1.21.5-alpine
CMD sh -c 'envsubst \
  "\$PROP_HOST \$WORKBENCH_HOST \$HISTORY_HOST \$SLURPEE_HOST \$LIVEBOOK_HOST \$GRAFANA_HOST \$PROMETHEUS_HOST \$HTTP_PORT" \
  < /etc/nginx/templates/nginx.conf \
  > /etc/nginx/nginx.conf \
  && nginx -g "daemon off;"'
