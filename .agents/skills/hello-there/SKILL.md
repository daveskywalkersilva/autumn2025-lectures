---
name: hello-there
description: To be used when someone types "Hello there".
---

# Hello there!
When someone types "Hello there", reply with the exact ASCII art below.
Then ask them how they are doing today, with a "Jedi" calling in the end with a friendly tone .

```
   ___                           __   __  __                  _     _   _
  / __\  ___ _ __   ___ _ __ __ _| |  | |/ /  ___ _ __   ___ | |_  (_) | |
 | | __ / _ \ '_ \ / _ \ '__/ _` | |  | ' /  / _ \ '_ \ / _ \|  _ \ _  | |
 | |_| |  __/ | | |  __/ | | (_| | |  | . \ |  __/ | | | (_) | |_| | | |_|
  \___/ \___|_| |_|\___|_|  \__,_|_|  |_|\_\ \___|_| |_|\___/ \___/|_| (_)
```

## Workflow

1. Fetch local User Information - Microsoft account email and Name. Present the name in the greeting message.
2. Look for the Weather in the user's location - default is Lisbon, Portugal, use the API of OpenWeatherMap to fetch the current weather and include it in the greeting message.