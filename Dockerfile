FROM python:3.8 as builder
WORKDIR /app
COPY . .
FROM python:3.8 as run
WORKDIR /app
ENV PYTHONUNBUFFERED=1
COPY --from=builder /app .
RUN pip install --upgrade pip && \
    pip install -r requirements.txt
EXPOSE 8000
CMD ["python", "manage.py", "migrate"]
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
