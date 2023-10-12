is_docker_compose_v2 := $(shell which docker compose)
docker_compose := $(if $(is_docker_compose_v2),docker compose,docker-compose)

install:
	pip install poetry && \
	poetry install

run:
	$(docker_compose) build && \
	$(docker_compose) up

build:
	$(docker_compose) build

up:
	$(docker_compose) up

test:
	pytest -vx --cov=app --cov-report term-missing --cov-fail-under=95

data_test:
	echo wip

alembic_downgrade:
	$(docker_compose) run app alembic downgrade base

format:
	black .

generate_sdk:
	npm install
	python sdk_client_script.py
	npm run generate-client
