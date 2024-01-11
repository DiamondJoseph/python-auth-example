FROM python:3-slim
WORKDIR /app
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt
COPY src/python-auth-example /app/
EXPOSE 80
EXPOSE 5678
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "80"]
