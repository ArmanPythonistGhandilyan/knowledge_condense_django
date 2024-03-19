# DC = docker compose
# STORAGES_FILE = docker_compose/storages.yaml
# EXEC = docker exec -it
# DB_CONTAINER = example-db
# LOGS = docker logs
# ENV = --env-file .env
# APP_FILE = docker_compose/app.yaml
# APP_CONTAINER = main-app
# MANAGE_PY = python manage.py

.PHONY: storages
storages:
	docker compose -f docker_compose/storages.yaml --env-file .env up -d

.PHONY: storages-down
storages-down:
	docker compose -f docker_compose/storages.yaml down

.PHONY: postgres
postgres:
	docker exec -it example-db psql

.PHONY: storages-logs
storages-logs:
	docker logs example-db -f

.PHONY: app
app:
	docker compose -f docker_compose/app.yaml --env-file .env -f docker_compose/storages.yaml up --build -d

.PHONY: app-logs
app-logs:
	docker logs main-app -f

.PHONY: db-logs
db-logs:
	docker compose -f docker_compose/storages.yaml logs -f

.PHONY: app-down
app-down:
	docker compose -f docker_compose/app.yaml -f docker_compose/storages.yaml down

.PHONY: migrate
migrate:
	docker exec -it main-app python manage.py migrate

.PHONY: migrations
migrations:
	docker exec -it main-app python manage.py makemigrations

.PHONY: superuser
superuser:
	docker exec -it main-app python manage.py createsuperuser

.PHONY: collectstatic
collectstatic:
	docker exec -it main-app python manage.py collectstatic

.PHONY: run-test
run-test:
	docker exec -it main-app pytest
