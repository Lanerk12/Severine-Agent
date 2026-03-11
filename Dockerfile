FROM node:22-bookworm-slim
RUN apt-get update && apt-get install -y git cmake make g++ python3 pkg-config
RUN corepack enable && npm install -g openclaw@latest npm@latest
WORKDIR /data
COPY . .
# Copy config to where OpenClaw expects it
RUN mkdir -p /root/.openclaw && cp /data/openclaw.config.json /root/.openclaw/openclaw.json
# Copy identity/memory files into the openclaw workspace
RUN cp /data/SOUL.md /root/.openclaw/SOUL.md \
 && cp /data/IDENTITY.md /root/.openclaw/IDENTITY.md \
 && cp /data/MEMORY.md /root/.openclaw/MEMORY.md \
 && cp /data/AGENTS.md /root/.openclaw/AGENTS.md
EXPOSE 3000
COPY scripts/start.sh /start.sh
RUN chmod +x /start.sh && chmod +x /data/scripts/register-crons.sh
CMD ["/start.sh"]
