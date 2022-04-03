# Wemoux
Wemoux is the Discord bot used in the Tick Tock server.<br>
It only has one purpose, and that's to notify of a new day in the #log-of-lag channel.

This project is deployed using Kubernetes, so apply the following secret before applying the manifest at `kubernetes.yaml`.
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: wemoux-bot-config
type: Opaque
stringData:
    DISCORD_TOKEN: 'bot_token'
    LOG_OF_LAG_ID: 'log_of_lag_id'
```
