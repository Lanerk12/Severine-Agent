FROM node:22-alpine
WORKDIR /app
COPY . .
RUN corepack enable && corepack prepare
RUN npm install -g openclaw@latest
VOLUME /data
EXPOSE $PORT
CMD ["openclaw", "gateway", "--port", "$PORT"]
