FROM node:22-alpine
WORKDIR /app
COPY . .
RUN npm install -g openclaw@latest
EXPOSE $PORT
CMD ["openclaw", "gateway", "--port", "$PORT"]
