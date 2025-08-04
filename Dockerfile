# Stage 1: Build Stage
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION} AS builder

# Set the working directory
WORKDIR /app

# Copy only requirements first to leverage Docker layer caching
COPY requirements.txt .

# Install dependencies into temporary location
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Stage 2: Run Stage
FROM python:${PYTHON_VERSION} AS run

WORKDIR /app

ENV PYTHONUNBUFFERED=1

# Copy the application code and dependencies from the builder stage
COPY --from=builder /app .

# Run database migrations
RUN python manage.py migrate

# Start the Django development server
ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8080"]
