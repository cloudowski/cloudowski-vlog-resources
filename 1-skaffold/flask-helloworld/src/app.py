from flask import Flask
import socket
app = Flask(__name__)


@app.route('/')
def hello_world():
    h = socket.gethostname()
    return h + ': 0.0.2 Hello, World!!!\n'


app.run(host='0.0.0.0', port=8080)
