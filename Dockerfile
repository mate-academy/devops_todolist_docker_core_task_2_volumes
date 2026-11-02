# Stage 1: Build
ARG PYTHON_VERSION=3.10

FROM python:${PYTHON_VERSION}-slim AS builder

WORKDIR /app

# Create Python virtual environment
RUN python -m venv /opt/venv

# Use virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Copy dependencies
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt


# Stage 2: Runtime
FROM python:${PYTHON_VERSION}-slim AS runtime

WORKDIR /app

ENV PYTHONUNBUFFERED=1
ENV PATH="/opt/venv/bin:$PATH"

# Copy installed dependencies from builder
COPY --from=builder /opt/venv /opt/venv

# Copy Django application
COPY . .

# Expose Django port
EXPOSE 8080

# Start Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]