# Prop
[![Build Status](https://github.com/fremantle-industries/prop/workflows/test/badge.svg?branch=main)](https://github.com/fremantle-industries/prop/actions?query=workflow%3Atest)
[![hex.pm version](https://img.shields.io/hexpm/v/prop.svg?style=flat)](https://hex.pm/packages/prop)

DeFi? CeFi? TradeFi?

`prop` is an open and opinionated trading platform using productive & familiar
open source libraries and tools for strategy research, execution and operation.

## Install

Add `prop` to your list of dependencies in `mix.exs`

```elixir
def deps do
  [
    {:prop, "~> 0.0.1"}
  ]
end
```

## Usage

You can run the app natively on the host `http://prop.localhost:4000`

```bash
$ mix deps.get
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
password: password
```

## Requirements

`prop` requires Elixir 1.12+ & Erlang/OTP 22+

## Prop - [http://prop.localhost](http://prop.localhost)

![prop tools](./docs/prop-tools.png)

## Workbench - [http://workbench.localhost](http://workbench.localhost)

From idea to execution, manage your trading operation across a distributed cluster

[![stream-realtime-orders](https://github.com/fremantle-industries/workbench/blob/main/docs/stream-realtime-orders.png)](https://github.com/fremantle-industries/workbench)

## History - [http://history.localhost](http://history.localhost)

Download and warehouse historical trading data

[![history-jobs](https://github.com/fremantle-industries/history/blob/main/docs/predicted-funding-rate-download.png)](https://github.com/fremantle-industries/history)

## Rube - [http://rube.localhost](http://rube.localhost)

A multi-chain DeFi development toolkit

[![rube-poc-overview](https://github.com/fremantle-industries/rube/blob/main/docs/rube-poc-overview-thumbnail.png)](https://youtu.be/f2phGFZrh80)

## Slurpee - [http://slurpee.locahost](http://slurpee.localhost)

A GUI frontend to manage blockchain ingestion with slurp

[![recent heads and blocks](https://github.com/fremantle-industries/slurpee/blob/main/docs/recent-blocks-and-events.png)](https://github.com/fremantle-industries/slurpee)

## Explore Data with LiveBook - [http://livebook.localhost](http://livebook.localhost)

![livebook](./docs/livebook.png)

## Grafana - [http://grafana.localhost](http://grafana.localhost)

![dashboard-beam-vm-health](https://github.com/fremantle-industries/workbench/blob/main/docs/grafana-dashboard-beam-vm-health.png)

## Prometheus - [http://prometheus.localhost](http://prometheus.localhost)

![prometheus](./docs/prometheus.png)

## Tools

* [workbench](https://github.com/fremantle-industries/workbench) - Manage your trading operation across a distributed cluster
* [history](https://github.com/fremantle-industries/history) - Download and warehouse historical trading data
* [tai](https://github.com/fremantle-capital/tai) - Composable, real time, market data and trade execution toolkit
* [rube](https://github.com/fremantle-industries/rube) - A multi-chain DeFi development toolkit for Elixir
* [slurpee](https://github.com/fremantle-industries/slurpee) - A GUI frontend to manage blockchain ingestion with slurp
* [slurp](https://github.com/fremantle-industries/slurp) - Blockchain ingestion toolkit
* [livebook](https://github.com/elixir-nx/livebook) - Livebook is a web application for writing interactive and collaborative code notebooks built with Phoenix LiveView
* [grafana](https://grafana.com) - Dashboard Monitoring. Store & Visualize Your Metrics
* [timescaledb](https://www.timescale.com) - Relational database for time-series data. Supercharged PostgreSQL
* [prometheus](https://prometheus.io) - An open-source monitoring system with a dimensional data model, flexible query language, efficient time series database and modern alerting

## Authors

- Alex Kwiatkowski - alex+git@fremantle.io

## License

`prop` is released under the [MIT license](./LICENSE.md)
