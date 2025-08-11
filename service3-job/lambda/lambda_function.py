# lambda/lambda_function.py
import os
import boto3
from datetime import datetime
from zoneinfo import ZoneInfo 

def lambda_handler(event, context):
    bucket = os.environ.get("BUCKET_NAME")
    if not bucket:
        raise Exception("BUCKET_NAME environment variable not set")

    s3 = boto3.client("s3")

    now_utc = datetime.now(ZoneInfo("America/Sao_Paulo"))

    filename = now_utc.strftime("%Y-%m-%dT%H:%M:%S") + ".txt"

    body = f"Executed at (UTC): {now_utc.isoformat()}\nEvent: {event}\n"

    s3.put_object(Bucket=bucket, Key=filename, Body=body.encode("utf-8"))

    return {
        "status": "ok",
        "bucket": bucket,
        "key": filename,
        "timestamp_utc": now_utc.isoformat()
    }
