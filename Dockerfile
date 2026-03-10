FROM node:22-bookworm-slim
RUN apt-get update && apt-get install -y git cmake make g++ python3 pkg-config
RUN corepack enable && npm install -g openclaw@latest npm@latest
WORKDIR /data
COPY . .
EXPOSE 3000
CMD ["sh", "-c", "openclaw channels add --channel telegram --token $TELEGRAM_TOKEN && openclaw gateway --port 3000 --allow-unconfigured"]
