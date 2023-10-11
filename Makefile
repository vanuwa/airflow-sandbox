MONGODB_DATA_LOCAL_PATH = $(shell pwd)/mongodb-data
MONGODB_CONTAINER_NAME = mongodb-sandbox
PG_DATA_LOCAL_PATH = $(shell pwd)/pg-data
PG_CONTAINER_NAME = postgres-sandbox

init:
	mkdir -p ./dags ./logs ./plugins ./config
	#echo -e "AIRFLOW_UID=$(id -u)" > .env
	docker compose up airflow-init

airflow-start:
	docker compose up -d

airflow-stop:
	docker compose down

mongodb-start:
	mkdir -p $(MONGODB_DATA_LOCAL_PATH)
	docker run --name $(MONGODB_CONTAINER_NAME) -v $(MONGODB_DATA_LOCAL_PATH)/mongodb-data:/data/db -p 27017:27017 -d mongo:7

mongodb-stop:
	docker stop $(MONGODB_CONTAINER_NAME) && docker rm $(MONGODB_CONTAINER_NAME)

postgres-start:
	mkdir -p $(PG_DATA_LOCAL_PATH)
	docker run --name $(PG_CONTAINER_NAME) -e POSTGRES_PASSWORD=my-local-sandbox-db -e PGDATA=/var/lib/postgresql/data/pgdata -v $(PG_DATA_LOCAL_PATH):/var/lib/postgresql/data -p 5432:5432 -d postgres:16

postgres-stop:
	docker stop $(PG_CONTAINER_NAME) && docker rm $(PG_CONTAINER_NAME)

.PHONY: clean
clean:
	docker compose down --volumes --rmi all
	@echo "DONE"
