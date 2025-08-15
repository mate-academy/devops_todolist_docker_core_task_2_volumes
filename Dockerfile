ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION}

WORKDIR /app

ENV PYTHONUNBUFFERED=1

# Copy and install dependencies first for better caching
COPY requirements.txt ./
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy application code
COPY . .

EXPOSE 8080

# Start the Django application (migrations should be run at container start, not at build time)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
