from flask import Flask, jsonify
import os
from flask_restful import Resource, Api
import google.generativeai as genai
import Keys
app = Flask(__name__)
genai.configure(api_key=os.environ['API_key'])
model = genai.GenerativeModel("gemini-1.5-flash")

@app.route("/")

def prompt_gene():
    return "<p>"