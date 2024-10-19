from flask import Flask, jsonify, request
import os
app = Flask(__name__)

test = ['hi', 't']
@app.route("/", methods=['GET','POST'])
def hello_world():
    print(request.method)
    if request.method  == 'GET':
        return jsonify(test)