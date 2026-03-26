# ---- Development ----
FROM python:3.10-slim AS dev

WORKDIR /code

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

ENV PYTHONPATH="/code"
EXPOSE 8000

# Source code is mounted as a volume for hot reloading (see docker-compose)
CMD ["uvicorn", "api.main:app", "--reload", "--host", "0.0.0.0", "--port", "8000", "--reload-dir", "/code/api", "--reload-dir", "/code/engine"]

# ---- Production ----
FROM python:3.10-slim AS prod

WORKDIR /code

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/api /code/api
COPY src/engine /code/engine

ENV PYTHONPATH="/code"
EXPOSE 8000

CMD ["uvicorn", "api.main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "8000", "--workers", "4"]
