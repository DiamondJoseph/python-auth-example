FROM python:3-slim

WORKDIR /app
RUN python -m venv .venv
ENV PATH="/app/.venv/bin:$PATH"

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY src /app/src

EXPOSE 80
EXPOSE 5678

CMD ["uvicorn", "src.python-auth-example.app:app", "--host", "0.0.0.0", "--port", "80"]
