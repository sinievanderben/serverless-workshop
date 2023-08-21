import json

def lambda_handler(event, context):
    
    if event['httpMethod'] == 'OPTIONS':
            
            return {
                  "statusCode": 200,
                  "body": "",
                  "headers" : {
                        "Access-Control-Allow-Origin": "*",
                        "Access-Control-Allow-Methods" : "POST, GET, DELETE, PUT",
                        "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept"
                  }
    }

    else:

        if type(event['body'] == str):
             event_info = json.loads(event['body'])\
        
        name = event_info["firstName"] + ' ' + event_info["lastName"]

        message = {'Message': 'Hello from Lambda, ' + name}

        return {
        "statusCode": 200,
        "body": json.dumps(message),
        "headers" : {
             "Access-Control-Allow-Origin": "*",
             "Access-Control-Allow-Headers": "Content-Type",
             "Content-Type": "text/plain"
             }
        }