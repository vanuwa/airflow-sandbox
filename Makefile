init:
	mkdir -p ./dags ./logs ./plugins ./config
	#echo -e "AIRFLOW_UID=$(id -u)" > .env
	docker compose up airflow-init

start:
	docker compose up -d

stop:
	docker compose down

.PHONY: clean
clean:
	docker compose down --volumes --rmi all
	@echo "DONE"
