# Use official Airflow 3.0.3 with Python 3.12
FROM apache/airflow:3.0.3-python3.12

# Metadata
LABEL maintainer="Suraj-kumar00"
LABEL description="Airflow 3.0.3 with Python 3.12 for learning"

# Switch to root for system-level installations
USER root

# Install system dependencies for pandas compilation (if needed)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        gcc \
        g++ \
        libpq-dev \
        python3-dev \
        git \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create directories with proper permissions
RUN mkdir -p /opt/airflow/logs /opt/airflow/plugins /opt/airflow/config \
    && chown -R airflow:root /opt/airflow

# Switch back to airflow user
USER airflow

# Copy requirements file
COPY requirements.txt /tmp/requirements.txt

# Install Python dependencies with specific pip flags to avoid compilation
RUN pip install --no-cache-dir \
    --prefer-binary \
    --no-build-isolation \
    -r /tmp/requirements.txt

# Verify installations
RUN python --version && airflow version && python -c "import pandas; print(f'Pandas version: {pandas.__version__}')"

# Set working directory
WORKDIR /opt/airflow

# Expose port for API server
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD airflow db check || exit 1

# Default command
CMD ["api-server"]
