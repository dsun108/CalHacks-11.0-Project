from flask import Flask, jsonify
import os
from flask_restful import Resource, Api
import google.generativeai as genai
import Keys
app = Flask(__name__)
api = Api(app)  
genai.configure(api_key=os.environ['API_key'])
model = genai.GenerativeModel("gemini-1.5-flash")
if True:
    app.run(debug=True)


class getPrompt(Resource):
    def get(self, query):
        response  = model.generate_content(query)
        return {"prompt":query, "responses":response.text}
api.add_resource(getPrompt, '/<string:query>')