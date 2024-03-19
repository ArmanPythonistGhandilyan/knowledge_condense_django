# Use a Python 3.12.1 image on Alpine Linux
FROM python:3.12.1-alpine

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONBUFFERED 1

# Set the working directory inside the container
WORKDIR /app

# Update package index and install system dependencies
RUN apk update && \
    apk add --no-cache python3-dev \
    gcc \
    musl-dev \
    libpq-dev

# Copy the pyproject.toml file to the container
COPY pyproject.toml .

# Upgrade pip and install Poetry
RUN python -m pip install --upgrade pip && \
    pip install poetry

# Configure Poetry and install dependencies
RUN poetry config virtualenvs.create false && \
    poetry install --no-root --no-interaction --no-ansi

# Copy the project files to the container
COPY . /app/

# Copy the entrypoint.sh script to the root directory in the container
# COPY docker_compose/entrypoint.sh /entrypoint.sh

# Grant execute permission to the entrypoint.sh script
RUN chmod +x /entrypoint.sh

# Command to run the application
CMD ["./entrypoint.sh"]
