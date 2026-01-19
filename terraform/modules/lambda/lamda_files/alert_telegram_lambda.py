import json
import urllib.request
import os

def lambda_handler(event, context):
    # Configuration
    TOKEN = os.environ.get('TELEGRAM_TOKEN')
    CHAT_ID = os.environ.get('TELEGRAM_CHAT_ID')
    
    # Extract message from CloudWatch Alarm
    # If direct from CloudWatch, event is the alarm dict
    alarm_name = event.get('alarmName', 'Unknown Alarm')
    new_state = event.get('newStateValue', 'UNKNOWN')
    reason = event.get('newStateReason', 'No reason provided')
    
    message = f"🚨 *AWS Alert* 🚨\n\n*Alarm:* {alarm_name}\n*Status:* {new_state}\n*Reason:* {reason}"
    
    # Telegram API URL
    url = f"https://api.telegram.org/bot{TOKEN}/sendMessage"
    
    data = json.dumps({
        "chat_id": CHAT_ID,
        "text": message,
        "parse_mode": "Markdown"
    }).encode('utf-8')
    
    req = urllib.request.Request(url, data=data, headers={'Content-Type': 'application/json'})
    
    try:
        with urllib.request.urlopen(req) as response:
            return {"statusCode": 200, "body": "Message sent!"}
    except Exception as e:
        print(f"Error: {e}")
        return {"statusCode": 500, "body": str(e)}