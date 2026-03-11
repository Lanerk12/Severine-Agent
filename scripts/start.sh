#!/bin/bash
set -e

echo "=== Severine startup ==="

# Register Telegram channel via config (openclaw.config.json handles this)
# No CLI registration needed - channel is defined in config

# Register Severine cron jobs
echo "Registering Severine cron jobs..."
/data/scripts/register-crons.sh || echo "Cron registration note - check logs"

# Start the gateway
echo "Starting OpenClaw gateway..."
exec openclaw gateway
