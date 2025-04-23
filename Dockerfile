# ---------- Build Stage ----------
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION} AS base

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# ---------- Run Stage ----------
FROM python:${PYTHON_VERSION}-slim

COPY --from=base /usr/local /usr/local
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY accounts ./accounts
COPY api ./api
COPY lists ./lists
COPY todolist ./todolist
COPY manage.py ./
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]