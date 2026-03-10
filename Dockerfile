FROM node:22-bookworm-slim
RUN apt-get update && apt-get install -y git cmake make g++ python3 pkg-config
RUN corepack enable && npm install -g openclaw@latest npm@latest
WORKDIR /data
COPY . .
EXPOSE $PORT
CMD ["sh", "-c", "openclaw gateway --port ${PORT:-3000}"]
