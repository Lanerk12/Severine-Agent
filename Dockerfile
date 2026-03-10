FROM node:22-alpine
RUN apk add --no-cache git
WORKDIR /app
COPY . .
EXPOSE $PORT
CMD ["npx", "openclaw@latest", "gateway", "--port", "$PORT", "--data", "/data"]
