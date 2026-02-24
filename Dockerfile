# Stage 1: Build Stage
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION} as builder

WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --prefix=/install -r requirements.txt


# Stage 2: Run Stage
FROM python:${PYTHON_VERSION}

WORKDIR /app

ENV PYTHONUNBUFFERED=1
ENV PATH="/install/bin:$PATH"

COPY --from=builder /install /install
COPY . .

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]