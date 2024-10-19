import requests



response = requests.get("http://127.0.0.1:5000/what_is_a_good_name?")
print(response.json()['responses:'])