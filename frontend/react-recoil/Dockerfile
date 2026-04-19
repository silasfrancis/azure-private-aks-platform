ARG BUILDPLATFORM=linux/amd64

FROM --platform=$BUILDPLATFORM node:24-bullseye-slim AS builder
WORKDIR /app

COPY package.json yarn.lock ./

RUN --mount=type=cache,target=/app/.yarn_cache \
    yarn config set cache-folder /app/.yarn_cache && \
    yarn install --frozen-lockfile

COPY . .

RUN yarn build

RUN yarn install --frozen-lockfile --production

FROM gcr.io/distroless/nodejs20-debian13

WORKDIR /app

COPY --from=builder /app /app

ENV NODE_ENV=production

EXPOSE 3000

USER nonroot

CMD ["node", "node_modules/serve/build/main.js", "-s", "build", "-l", "3000"]