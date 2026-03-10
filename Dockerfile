FROM node:22-bookworm-slim
RUN apt-get update && apt-get install -y git cmake make g++ python3 pkg-config
RUN corepack enable && npm install -g openclaw@latest npm@latest
WORKDIR /data
COPY . .
# OpenClaw looks for config at ~/.openclaw/openclaw.json by default
RUN mkdir -p /root/.openclaw && cp /data/openclaw.config.json /root/.openclaw/openclaw.json
EXPOSE 3000
CMD ["openclaw", "gateway"]
