import boto3
import json

dynamodb = boto3.resource('dynamodb')
table    = dynamodb.Table('users')

def get_user(user_id):
    response = table.get_item(Key={'id': user_id})
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(response.get('Item', {}))
    }

def get_users():
    response = table.scan()
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(response.get('Items', []))
    }

def lambda_handler(event, context):
    query = event.get('queryStringParameters') or {}
    user_id = query.get('id')
    
    if user_id:
        return get_user(user_id)
    else:
        return get_users()