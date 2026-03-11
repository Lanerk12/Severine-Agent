#!/bin/bash
set -e

echo "=== Severine startup ==="

# Register Telegram channel
echo "Registering Telegram channel..."
openclaw channel add telegram \
  --token "$TELEGRAM_BOT_TOKEN" \
  --dmPolicy open \
  --allowFrom "*" || echo "Telegram channel already registered, skipping"

# Register cron jobs
echo "Registering cron jobs..."
/data/scripts/register-crons.sh || echo "Cron registration note - check logs"

# Start the gateway
echo "Starting OpenClaw gateway..."
exec openclaw gateway
