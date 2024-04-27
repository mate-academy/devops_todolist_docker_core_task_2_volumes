ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION} as builder


WORKDIR /app
COPY . .


RUN pip install --upgrade pip && \
    pip install -r requirements.txt


FROM python:${PYTHON_VERSION} as run

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY --from=builder /app .

EXPOSE 8000

RUN pip install --upgrade pip && \
    pip install -r requirements.txt



CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]

