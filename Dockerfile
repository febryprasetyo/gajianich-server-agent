FROM node:20-alpine

# Install CLI utilities required for Linux host & Docker telemetry inspection
RUN apk add --no-cache \
    docker-cli \
    util-linux \
    iproute2 \
    procps \
    coreutils

WORKDIR /app

COPY package.json tsconfig.json ./
RUN npm install

COPY src ./src
COPY scripts ./scripts
RUN chmod +x scripts/*.sh 2>/dev/null || true
RUN npm run build

ENV NODE_ENV=production

CMD ["node", "dist/index.js"]
