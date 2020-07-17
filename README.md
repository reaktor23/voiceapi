# voiceapi

A simple API running in a container that lets you send a text to it and play that as TTS on the host

Post {"text": "Bring out the trash"} to the API and the sentece will be played on the host machines speakers.
Make sure to set the `Content-Type` to `application/json` for your request.
