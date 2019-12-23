import getpass
import json
import os
from pathlib import Path
import platform
import ssl

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps({
            'Platform': {
                'Platform': platform.platform(),
                'System': platform.system(),
                'Release': platform.release(),
                'Version': platform.version(),
            },
            'User': {
                'User': getpass.getuser(),
                'Home': str(Path.home()),
                'CWD': os.getcwd(),
            },
            'OpenSSL version': ssl.OPENSSL_VERSION,
        })
    }
