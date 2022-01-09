SHELL=/bin/bash

run_tests:
	echo "Running tests..."
	docker-compose up --detach db
	mix setup

start_development:
	echo "Starting developer environment..."
	docker-compose up --detach db
	mix setup
	mix phx.server

start:
	echo "Starting grafana, database and prometheus..."
	docker-compose up --detach grafana db prometheus
	echo "Configuring network with reverse proxy..."
	docker-compose up --detach reverse_proxy
	echo "Starting web application..."
	docker-compose up web
