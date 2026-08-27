# syntax=docker/dockerfile:1
FROM node:26

WORKDIR /app

COPY package.json package-lock.json ./
RUN --mount=type=bind,from=npmcache,target=/root/.npm,rw \
    npm config set fetch-retries 5 \
    && npm config set fetch-retry-maxtimeout 120000 \
    && npm config set fetch-timeout 300000 \
    && npm ci

COPY . .

EXPOSE 4173

CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--port", "4173"]
