FROM node:22-bookworm-slim
RUN apt-get update && apt-get install -y git cmake make g++ && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY . .
ENV PORT=3000
EXPOSE $PORT
CMD ["npx", "openclaw@latest", "gateway", "--port", "$PORT"]
