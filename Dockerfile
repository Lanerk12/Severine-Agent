FROM node:22-alpine
RUN apk add --no-cache git
RUN npm install -g openclaw@latest
WORKDIR /app
COPY . .
EXPOSE $PORT
CMD ["openclaw", "gateway", "--port", "$PORT", "--data", "/data"]
