from flask import Flask, jsonify
import os
from flask_restful import Resource, Api
import google.generativeai as genai
import Keys
import requests
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

class getNutrient(Resource):
    def get(self,food):
        tokens = food.split('_')
        url =  "https://api.nal.usda.gov/fdc/v1/foods/search?api_key="+os.environ['usda']+"&query="+tokens[0]+"%20"+tokens[1]
        
        response  = requests.get(url)
        return {'Brand': response.json()['foods'][0]['brandName'], 'Protein':response.json()['foods'][0]['foodNutrients'][0]['value'], 'ServingSize':response.json()['foods'][0]['servingSize'], 'kCal':response.json()['foods'][0]['foodNutrients'][3]['value']}
class workout(Resource):
    def get(self,Exercise):
        muscles =["abdominals","adductors","biceps","calves","chest","forearms","glutes","hamstrings","lats","lower_back","middle_back","neck","quadriceps","traps","triceps"]
        style = ["cardio","olympic_weightlifting","plyometrics","powerlifting","strength","stretching","strongman"]
        difficulty =  ["beginner","intermediate","expert"]
        url = 'https://api.api-ninjas.com/v1/'
        if Exercise in muscles:
            url = url+'exercises?muscles='+Exercise
        if Exercise in style:
            url = url+'exercises?type='+Exercise
        if Exercise in difficulty:
            url = url+'exercises?difficulty='+Exercise
        result = requests.get(url, headers={'X-Api-Key': os.environ['ninja']})
        dict = {}
        for i in range(5):
            dict['name'+str(i)] = result.json()[i]['name']
            dict['howto'+str(i)] = result.json()[i]['instructions']

        return dict
api.add_resource(getPrompt, '/google/<string:query>')
api.add_resource(getNutrient, '/food/<string:food>')
api.add_resource(workout, '/workout/<string:Exercise>')