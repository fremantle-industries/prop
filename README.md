# Prop

DeFi? CeFi? TradeFi?

`prop` is an opinionated suite of tools for traders & quants using
productive & familiar open source libraries and products for strategy research,
execution and monitoring.

## Usage

You can run the app natively on the host `http://prop.localhost:4000`

```bash
$ mix setup
$ mix phx.server
```

Or within `docker-compose` `http://prop.localhost`

```bash
docker-compose up
```

When running the application with `docker-compose` you will need to enter the basic auth development credentials:

```
username: admin
passowrd: password
```

## Prop - [http://prop.localhost](http://prop.localhost)

![prop tools](./docs/prop-tools.png)

## Workbench - [http://workbench.localhost](http://workbench.localhost)

TODO...

## Slurpee - [http://slurpee.locahost](http://slurpee.localhost)

[![recent heads and blocks](https://github.com/fremantle-industries/slurpee/blob/main/docs/recent-blocks-and-events.png)](https://github.com/fremantle-industries/slurpee)

## Explore Data with LiveBook - [http://livebook.localhost](http://livebook.localhost)

![live book](./docs/live-book.png)

## Grafana - [http://grafana.localhost](http://grafana.localhost)

![grafana dashboards](./docs/grafana-dashboards.png)

## Prometheus - [http://prometheus.localhost](http://prometheus.localhost)

![prometheus](./docs/prometheus.png)

## Tools

* [workbench](https://github.com/fremantle-industries/workbench) - Manage your trading operation across a distributed cluster
* [tai](https://github.com/fremantle-capital/tai) - Composable, real time, market data and trade execution toolkit
* [slurp](https://github.com/fremantle-industries/slurp) - Blockchain ingestion toolkit
* [slurpee](https://github.com/fremantle-industries/slurpee) - A GUI frontend to manage blockchain ingestion with slurp
* [rube](https://github.com/fremantle-industries/rube) - A multi-chain DeFi development toolkit for Elixir
* [livebook](https://github.com/elixir-nx/livebook) - Livebook is a web application for writing interactive and collaborative code notebooks built with Phoenix LiveView
* [grafana](https://grafana.com) - Dashboard Monitoring. Store & Visualize Your Metrics
* [timescaledb](https://www.timescale.com) - Relational database for time-series data. Supercharged PostgreSQL
* [prometheus](https://prometheus.io) - An open-source monitoring system with a dimensional data model, flexible query language, efficient time series database and modern alerting

## Authors

- Alex Kwiatkowski - alex+git@fremantle.io

## License

`prop` is released under the [MIT license](./LICENSE.md)
