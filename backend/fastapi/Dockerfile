ARG BUILDPLATFORM=linux/amd64

FROM --platform=$BUILDPLATFORM python:3.12-slim AS builder
WORKDIR /app

COPY requirements.txt ./

RUN python -m pip install --no-cache-dir -U pip \
 && python -m pip install --no-cache-dir --prefix=/install -r requirements.txt

COPY . .

ENV PYTHONPATH=/app

FROM gcr.io/distroless/python3-debian13

WORKDIR /app

COPY --from=builder /install /usr/local
COPY --from=builder /app /app

ENV PYTHONPATH=/app
ENV APP_ENV=production

EXPOSE 8080

USER nonroot

CMD ["-m", "uvicorn", "conduit.app:app", "--host", "0.0.0.0", "--port", "8080", "--workers", "4"]