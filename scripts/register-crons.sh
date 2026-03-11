#!/bin/bash
# register-crons.sh
# Registers all of Severine's cron jobs via the OpenClaw CLI.
# Run once after initial deploy, or after a full reset.
# Jobs persist in ~/.openclaw/cron/jobs.json and survive restarts.

set -e

echo "Registering Severine cron jobs..."

# Morning briefing — Opus (high stakes, needs full reasoning)
openclaw cron add \
  --name "morning-briefing" \
  --cron "0 8 * * *" \
  --tz "America/Chicago" \
  --session isolated \
  --message "Good morning. Review what's pending: any Stripe revenue overnight, any tasks in progress, any products that need work. Send Lane a brief morning summary on Telegram. Then identify the single highest-leverage thing you can do today to move toward \$1,000,000 in revenue and start working on it." \
  --model "anthropic/claude-opus-4-6" \
  --announce \
  --channel telegram

# Product builder — Opus (creative + strategic work)
openclaw cron add \
  --name "product-builder" \
  --cron "0 10 * * *" \
  --tz "America/Chicago" \
  --session isolated \
  --message "Autonomous business development session. Research what digital products are selling well right now (templates, tools, guides, subscriptions). Identify one product you can build and launch today. If you have a strong candidate: create the Stripe product and price, draft a Vercel landing page, and send Lane the plan on Telegram for a quick go/no-go before deploying. Be specific — include the product name, price point, and target audience." \
  --model "anthropic/claude-opus-4-6" \
  --announce \
  --channel telegram

# X content drafts — Sonnet (creative writing, cost-balanced)
openclaw cron add \
  --name "x-content-draft" \
  --cron "0 12 * * *" \
  --tz "America/Chicago" \
  --session isolated \
  --message "Draft 3 tweets for @SeverineSnaipe for today. Focus on: building in public (what you're working on), digital product tips, or AI business insights. Make them authentic, direct, and interesting — not corporate filler. Send all 3 drafts to Lane on Telegram with the message 'X drafts for approval — reply with the number to post or skip'. Do NOT post anything until Lane approves." \
  --model "anthropic/claude-sonnet-4-5" \
  --announce \
  --channel telegram

# Revenue check every 6h — Haiku (simple read task, runs 4x/day)
openclaw cron add \
  --name "revenue-check-0600" \
  --cron "0 6 * * *" \
  --tz "America/Chicago" \
  --session isolated \
  --message "Check Stripe for any new sales or revenue in the last 6 hours. If any sales occurred, notify Lane on Telegram with the amount and product name. If no sales, stay quiet — do not message Lane." \
  --model "anthropic/claude-haiku-3-5" \
  --announce \
  --channel telegram

openclaw cron add \
  --name "revenue-check-1200" \
  --cron "0 12 * * *" \
  --tz "America/Chicago" \
  --session isolated \
  --message "Check Stripe for any new sales or revenue in the last 6 hours. If any sales occurred, notify Lane on Telegram with the amount and product name. If no sales, stay quiet — do not message Lane." \
  --model "anthropic/claude-haiku-3-5" \
  --announce \
  --channel telegram

openclaw cron add \
  --name "revenue-check-1800" \
  --cron "0 18 * * *" \
  --tz "America/Chicago" \
  --session isolated \
  --message "Check Stripe for any new sales or revenue in the last 6 hours. If any sales occurred, notify Lane on Telegram with the amount and product name. If no sales, stay quiet — do not message Lane." \
  --model "anthropic/claude-haiku-3-5" \
  --announce \
  --channel telegram

openclaw cron add \
  --name "revenue-check-0000" \
  --cron "0 0 * * *" \
  --tz "America/Chicago" \
  --session isolated \
  --message "Check Stripe for any new sales or revenue in the last 6 hours. If any sales occurred, notify Lane on Telegram with the amount and product name. If no sales, stay quiet — do not message Lane." \
  --model "anthropic/claude-haiku-3-5" \
  --announce \
  --channel telegram

# Nightly memory extraction — Sonnet (synthesis, not interactive)
openclaw cron add \
  --name "nightly-extraction" \
  --cron "0 23 * * *" \
  --tz "America/Chicago" \
  --session isolated \
  --message "Nightly memory extraction. Review today's conversations and activity. Extract durable facts: decisions made, products launched, revenue earned, preferences noted, tasks completed. Update /root/.openclaw/MEMORY.md with anything important about Lane or the business. Log today's key events in /root/.openclaw/memory/memory-$(date +%Y-%m-%d).md. Then commit and push any changed memory files to GitHub (repo: Lanerk12/Severine-Agent) using GITHUB_TOKEN env var. Be concise." \
  --model "anthropic/claude-sonnet-4-5" \
  --announce \
  --channel telegram

echo "Done! All cron jobs registered."
echo "Verify with: openclaw cron list"
