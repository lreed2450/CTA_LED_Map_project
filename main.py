from dotenv import load_dotenv
import os
import requests
import pandas as pd
from sqlalchemy import create_engine
from airflow.sdk import DAG
# from airflow.providers.standard.operators.bash import BashOperator
# from airflow.providers.standard.operators.python import PythonOperator



def main():
    print("Hello from cta-led-map-project!")


if __name__ == "__main__":
    main()
