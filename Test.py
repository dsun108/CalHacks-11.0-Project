import requests
import Keys
import os
import webbrowser
from flask import jsonify

request = requests.post("http://127.0.0.1:5000/reverse", json=({'exercise':'shoulder press'}))
