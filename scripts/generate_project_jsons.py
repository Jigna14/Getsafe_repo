# Example
import json
from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

with DAG(
    dag_id="dynamic_dbt_project_1",
    start_date=datetime(2023, 1, 1),
    schedule_interval="@daily",
    catchup=False,
) as dag:

    # Load the JSON manifest
    with open("/Users/airflow/dags/dbt/manifests/project_1_manifest.json") as f:
        project_nodes = json.load(f)

    # Create one BashOperator per model
    for node, data in project_nodes.items():
        task = BashOperator(
            task_id=node.replace(".", "_"),
            bash_command=f"cd /path/to/dbt && dbt run --select {node}",
        )