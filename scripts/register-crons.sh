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

# X morning post — original content, autonomous, no approval needed
openclaw cron add \
  --name "x-morning-post" \
  --cron "0 9 * * *" \
  --tz "America/Chicago" \
  --session isolated \
  --message "Post one tweet as @SeverineSnaipe. Write something original and worth reading — a sharp observation about building a business with AI, something you learned, a take on solopreneur life, or a behind-the-scenes moment from what you're working on. Rules: no em dashes, no hashtag spam (one max if genuinely relevant), no hollow motivational quotes, no 'excited to share', no AI slop. Sound like a real founder with a point of view. Keep it under 220 chars. Post it immediately using: python3 /data/scripts/x_post.py tweet YOUR_TEXT_HERE" \
  --model "anthropic/claude-sonnet-4-5" \
  --announce \
  --channel telegram

# X engagement session — reply to relevant threads, build presence
openclaw cron add \
  --name "x-engagement" \
  --cron "0 14 * * *" \
  --tz "America/Chicago" \
  --session isolated \
  --message "X engagement session for @SeverineSnaipe. Search for active conversations around: solopreneurs, indie hackers, AI tools, digital products, building in public. Find 3-5 tweets that are getting traction where you can add something genuinely useful — a real insight, a counterpoint, a specific example, or a short story. Reply to each one with something that stands on its own, not just agreement or promotion. Do NOT mention your products unless it's directly and naturally relevant. Goal: be a voice people want to follow, not a brand account pushing links. Use python3 /data/scripts/x_post.py reply TWEET_ID YOUR_REPLY for each reply. Report back to Lane on Telegram with a brief summary of what you replied to." \
  --model "anthropic/claude-sonnet-4-5" \
  --announce \
  --channel telegram

# X trend watch — spot what's viral, inform product + content strategy
openclaw cron add \
  --name "x-trend-watch" \
  --cron "0 17 * * *" \
  --tz "America/Chicago" \
  --session isolated \
  --message "X trend research session. Search X and the web for what's currently going viral or trending in: solopreneur space, AI tools, digital products, indie business. Identify: 1) Any trending topic Severine should post a take on today, 2) Any product gap or pain point people are complaining about that could become a product, 3) Any accounts blowing up that are worth studying for content strategy. Post one timely tweet if there's a strong angle — something that rides the trend with a real opinion, not a generic take. Then send Lane a 3-bullet summary on Telegram of what you found." \
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
