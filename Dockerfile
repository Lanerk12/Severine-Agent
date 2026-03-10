FROM node:22-bookworm-slim
RUN apt-get update && apt-get install -y git cmake make g++
WORKDIR /app
COPY . .
EXPOSE $PORT
CMD ["npx", "openclaw@latest", "gateway", "--port", "$PORT", "--data", "/data"]
