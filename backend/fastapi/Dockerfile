FROM python:3.12-slim AS base

WORKDIR /app

COPY requirements.txt ./

RUN python -m pip install --no-cache-dir -U pip \
 && python -m pip install --no-cache-dir -r requirements.txt

ENV PYTHONPATH=/app

COPY . .

EXPOSE 8080

FROM base AS dev

COPY requirements-ci.txt ./
RUN python -m pip install --no-cache-dir -r requirements-ci.txt

ENV APP_ENV=dev

CMD ["uvicorn", "conduit.app:app", "--host", "0.0.0.0", "--port", "8080", "--reload"]

FROM base AS production

ENV APP_ENV=production

CMD ["uvicorn", "conduit.app:app", "--host", "0.0.0.0", "--port", "8080", "--workers", "4"]