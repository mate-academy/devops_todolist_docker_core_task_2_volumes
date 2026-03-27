ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION} AS builder


WORKDIR /app
COPY . .


FROM python:${PYTHON_VERSION} AS run

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY --from=builder /app .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8080"]
