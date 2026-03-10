FROM node:22-alpine
RUN apk add --no-cache git
WORKDIR /app
COPY . .
RUN npx openclaw@latest init
EXPOSE $PORT
CMD ["npx", "openclaw@latest", "gateway", "--port", "$PORT"]
