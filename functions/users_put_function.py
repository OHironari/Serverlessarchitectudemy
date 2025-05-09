import boto3
import json

dynamodb = boto3.resource('dynamodb')
table    = dynamodb.Table('users')
 
def post_users(requestJSON):
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
    response = table.get_item(Key={'id': requestJSON['id']})
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(response.get('Item', {}))
    }

def lambda_handler(event, context):
    requestJSON = json.loads(event['body'])
    return post_users(requestJSON)