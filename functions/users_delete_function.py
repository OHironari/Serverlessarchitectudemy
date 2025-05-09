import boto3
import json

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('users')

# 単一レコード削除
def delete_user(user_id):
    table.delete_item(
        Key={
            'id': user_id
        }
    )
    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({"message": f"User {user_id} deleted successfully."})
    }

# 全レコード削除（テーブル自体は削除しない）
def delete_users():
    scan = table.scan()
    with table.batch_writer() as batch:
        for item in scan.get('Items', []):
            batch.delete_item(Key={'id': item['id']})

    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({"message": "All users deleted successfully."})
    }

def lambda_handler(event, context):
    query = event.get('queryStringParameters') or {}
    user_id = query.get('id')

    if user_id:
        return delete_user(user_id)
    else:
        return delete_users()