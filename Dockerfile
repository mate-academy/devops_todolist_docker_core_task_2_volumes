# Stage 1: Build Stage
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION} as builder

WORKDIR /app
COPY . .

# Stage 2: Run Stage
FROM python:${PYTHON_VERSION} as run

WORKDIR /app
ENV PYTHONUNBUFFERED=1

COPY --from=builder /app .


RUN pip install --upgrade pip && \
    pip install -r requirements.txt


COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh


ENTRYPOINT ["/app/entrypoint.sh"]
