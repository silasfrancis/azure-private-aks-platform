FROM node:24-bullseye-slim AS base
WORKDIR /app

FROM base AS dev

COPY package.json yarn.lock ./

RUN --mount=type=cache,target=/app/.yarn_cache \
    yarn config set cache-folder /app/.yarn_cache && \
    yarn install --frozen-lockfile

COPY . .

# Build the app
RUN yarn build

# Install serve globally with yarn
RUN yarn global add serve

EXPOSE 3000

CMD ["serve", "-s", "build", "-l", "3000"]

FROM base AS production

COPY package.json yarn.lock ./

RUN --mount=type=cache,target=/app/.yarn_cache \
    yarn config set cache-folder /app/.yarn_cache && \
    yarn install --frozen-lockfile

COPY . .

# Build the app
RUN yarn build

# Install serve globally with yarn
RUN yarn global add serve

EXPOSE 3000

CMD ["serve", "-s", "build", "-l", "3000"]