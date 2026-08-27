ARG PYTHON_VERSION=3.11-slim

FROM python:${PYTHON_VERSION} AS build

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:${PATH}"

COPY requirements.txt .
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

FROM python:${PYTHON_VERSION} AS run

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/opt/venv/bin:${PATH}"

WORKDIR /app

COPY --from=build /opt/venv /opt/venv
COPY . .

RUN python manage.py migrate --noinput

EXPOSE 8080

CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
