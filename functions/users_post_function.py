import boto3
import json
import logging

dynamodb = boto3.resource('dynamodb')
table    = dynamodb.Table('users')
 
def post_users(requestJSON):
    table.put_item(Item={'id': requestJSON['id'], 'name': requestJSON['name'], 'age': requestJSON['age'], 'address': requestJSON['address'], 'tel': requestJSON['tel']})

def lambda_handler(event, context):
    requestJSON = json.loads(event['body'])
    post_users(requestJSON)
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({"message": "Success!"})
    }