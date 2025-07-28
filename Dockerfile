FROM apache/airflow:3.0.3-python3.12

USER root
# (optional) apt-get install -y your-system-packages

USER airflow
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt
