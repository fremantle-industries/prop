FROM nginx:1.20.0-alpine
CMD sh -c 'envsubst \
  "\$PROP_HOST \$WORKBENCH_HOST \$SLURPEE_HOST \$LIVEBOOK_HOST \$GRAFANA_HOST \$PROMETHEUS_HOST \$HTTP_PORT" \
  < /etc/nginx/templates/nginx.conf \
  > /etc/nginx/nginx.conf \
  && nginx -g "daemon off;"'
