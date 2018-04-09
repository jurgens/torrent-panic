# README

[![Build Status](https://semaphoreci.com/api/v1/kodo/torrent-panic/branches/master/badge.svg)](https://semaphoreci.com/kodo/torrent-panic)

how to setup bot backend locally

1. start rails ```start rails``` 
2. run ```ngrok http 3000```
3. copy URL from ngrok output to BOT_URL

   ```Forwarding https://11444cdb.ngrok.io -> localhost:3000```

4. create new bot and get API key or use existing and set TELEGRAM_API_KEY
5. run ```rake telegram:init``` to set a webhook
6. start sending commands from bot

