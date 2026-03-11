#!/bin/bash
set -e

echo "=== Severine startup ==="

# Start the gateway in the background first
echo "Starting OpenClaw gateway..."
openclaw gateway &
GATEWAY_PID=$!

# Wait for gateway to be ready (up to 60s)
echo "Waiting for gateway to be ready..."
for i in $(seq 1 30); do
  if openclaw cron list > /dev/null 2>&1; then
    echo "Gateway ready after ${i}s"
    break
  fi
  sleep 2
done

# Register cron jobs now that gateway is up
echo "Registering Severine cron jobs..."
/data/scripts/register-crons.sh || echo "Cron registration note - check logs"

# Wait for gateway process to keep container alive
wait $GATEWAY_PID
