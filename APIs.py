from flask import Flask, jsonify, request
import os
from flask_restful import Resource, Api
import google.generativeai as genai
import Keys
import random
import requests
import time
app = Flask(__name__)
api = Api(app)
random.seed(time.time())
genai.configure(api_key=os.environ['API_Key'])
model = genai.GenerativeModel("gemini-1.5-flash")

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
        toggle = True
        if Exercise in muscles:
            url = url+'exercises?muscle='+Exercise
        if Exercise in style:
            url = url+'exercises?type='+Exercise
        if Exercise in difficulty:
            url = url+'exercises?difficulty='+Exercise
        if url == 'https://api.api-ninjas.com/v1/':
            url = url+'exercises?name='+Exercise
            toggle = False

        result = requests.get(url, headers={'X-Api-Key': os.environ['ninja']})
        
        dict = {}
        dict['toggle'] = True
        if(toggle):
            for i in range(5):
                dict['name'+str(i)] = result.json()[i]['name']
                dict['howto'+str(i)] = result.json()[i]['instructions']
        else:
            for i in range(5):
                dict['name'+str(i)] = result.json()[0]['name']
                dict['muscle'+str(i)] = result.json()[0]['muscle']
            dict['toggle'] = False
        return dict
api.add_resource(getPrompt, '/google/<string:query>')
api.add_resource(getNutrient, '/food/<string:food>')
api.add_resource(workout, '/workout/<string:Exercise>')

@app.route("/userData",methods=["POST"])
def getter():
    data = request.get_json(force=True)

    type = data['goals']
    exp = data['exp']
    time = data['time']
    dict = {'Day1':'Rest', 'Day2':'Rest', 'Day3':'Rest', 'Day4':'Rest', 'Day5':'Rest'}
    obj = workout.get(workout,'biceps')


    lst2= []
    for i in range(2):
        lst = []
        while(True):
            j = random.randrange(0,5)
            if j not in lst:
                lst += [j]
                break
        lst2 += [obj['name'+str(j)]]

    obj = workout.get(workout,'middle_back')
    lst3= []
    for i in range(3):
        lst = []
        while(True):
            j = random.randrange(0,5)
            if j not in lst:
                lst += [j]
                break
        lst3 += [obj['name'+str(j)]]
    dict['Day1'] = lst2+lst3
    if(int(time) >= 4):
        dict['Day4'] = lst2+lst3


    obj = workout.get(workout,'chest')

    lst2= []
    for i in range(5):
        lst = []
        while(True):
            j = random.randrange(0,5)
            if j not in lst:
                lst += [j]
                break
        lst2 += [obj['name'+str(j)]]

    dict['Day2'] = lst2
    if(int(time) >= 5):
        dict['Day5'] = lst2
    obj = workout.get(workout,'quadriceps')
    for i in range(5):
        lst = []
        while(True):
            j = random.randrange(0,5)
            if j not in lst:
                lst += [j]
                break
        lst2 += [obj['name'+str(j)]]
        
    dict['Day3'] = lst2
    return dict

@app.route("/reverse",methods=["POST"])
def getter2():
    data = request.get_json(force=True)
    exercise = data['exercise']
    obj = workout.get(workout,exercise)
    dict = {}
    for i in range(5):
        dict['name'+str(i)] = obj['name'+str(i)]
        dict['muscle'+str(i)] = obj['muscle'+str(i)]
    print(dict)
    return dict