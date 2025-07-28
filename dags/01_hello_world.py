"""
Hello-World DAG - Airflow 3.0.3 / Python 3.12
"""
from datetime import timedelta, datetime
from airflow.sdk import DAG
from airflow.providers.standard.operators.bash import BashOperator

with DAG(
    dag_id="01_hello_world",
    start_date=datetime(2025, 1, 1),
    schedule="@daily",
    catchup=False,
    tags=["level0", "tutorial"],
):
    hello = BashOperator(
        task_id="say_hello",
        bash_command='echo "Hello from Airflow 3.0.3 running on Python 3.12!"',
    )
