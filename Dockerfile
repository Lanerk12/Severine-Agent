FROM node:22-bookworm-slim
RUN apt-get update && apt-get install -y git cmake make g++ python3 pkgconfig
RUN corepack enable && npm install -g openclaw@latest npm@latest
RUN npx openclaw@latest init --yes --data /data
WORKDIR /data
COPY . .
EXPOSE 3000
CMD ["openclaw", "gateway", "--port", "3000"]
