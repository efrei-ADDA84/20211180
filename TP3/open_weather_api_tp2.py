#Import des librairies python
import requests, json, os
from flask import Flask, request
from sys import argv

app= Flask(__name__)
@app.route('/', methods=['GET'])
def api():
    print("==================Welcome to EFREI API Weather=================\n")

    #Définition des variables de l'URL
    lat =  request.args.get('lat')
    lon = request.args.get('lon')
    #API_KEY= argv[1]
    API_KEY = os.environ.get("API_KEY")
    #Requête
    url = f'http://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API_KEY}&units=metric'
    reponse = requests.get(url)
    #Formattage
    reponse_json = reponse.json()

    #Récupération des informations sur la température
    if reponse_json["cod"] != "400":
        response_pretty = json.dumps(reponse_json, indent=4)
        print(response_pretty)
        return reponse_json
    
    else:
        print(" ERREUR : Localisation non trouvée")
        return "ERREUR : Localisation non trouvée"



if __name__=="__main__":
    app.run(port=8081, debug=True)
    api()
