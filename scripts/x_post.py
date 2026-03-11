import asyncio
import sys
import os
import tempfile
from twikit import Client

async def main():
    cookies_raw = os.environ.get('X_COOKIES_JSON')
    with tempfile.NamedTemporaryFile(mode='w', suffix='.json', delete=False) as f:
        f.write(cookies_raw)
        cookies_path = f.name

    client = Client('en-US')
    client.load_cookies(cookies_path)

    action = sys.argv[1]

    if action == 'tweet':
        tweet = await client.create_tweet(text=sys.argv[2])
        print(f"Posted: {tweet.id}")
    elif action == 'reply':
        tweet = await client.create_tweet(text=sys.argv[3], reply_to=sys.argv[2])
        print(f"Replied: {tweet.id}")

asyncio.run(main())
