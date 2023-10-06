from datetime import datetime, timedelta

from airflow import DAG

PARENT = 'butelka'

default_args = {
  'owner': 'airflow',
  'depends_on_past': False,
  'start_date': datetime(2023, 6, 1),
  'retries': 3,
  'retry_delay': timedelta(minutes=1),
  'pool': PARENT
}

schedule_interval = '@once'

with DAG(
  PARENT,
  max_active_runs=1,
  concurrency=32,
  tags=[],
  catchup=False,
  default_args=default_args,
  schedule_interval=schedule_interval,
  template_searchpath=['/opt/airflow/dags/butelka/sql']
) as dag:

