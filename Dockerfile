FROM node:22-alpine
RUN apk add --no-cache git
WORKDIR /app
COPY . .
EXPOSE $PORT
CMD sh -c "npx openclaw@latest gateway --port \${PORT:-8080} --data /data"
