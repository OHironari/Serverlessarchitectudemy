import boto3
import json

dynamodb = boto3.resource('dynamodb')
table    = dynamodb.Table('users')
 
def post_users(requestJSON,user_id):
    table.update_item(
        Key={
            'id': requestJSON['id']
        },
        UpdateExpression="SET #name = :newName, age = :newAge, address = :newAddress, tel = :newTel",
        ExpressionAttributeNames= {
        '#name' : 'name'
        },
        ExpressionAttributeValues={
            ':newName': requestJSON['name'],
            ':newAge': requestJSON['age'],
            ':newAddress': requestJSON['address'],
            ':newTel': requestJSON['tel']
        },
    )
    response = table.get_item(Key={'id': user_id})
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(response.get('Item', {}))
    }

def lambda_handler(event, context):
    requestJSON = json.loads(event['body'])
    query = event.get('queryStringParameters') or {}
    user_id = query.get('id')
    post_users(requestJSON,user_id)
