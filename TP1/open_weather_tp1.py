#Import des librairies python
import requests, json, os

#paramètres de l'URL, définis en tant que variables d'environnement
LAT = os.environ.get("LAT")
LONG = os.environ.get("LONG")
API_KEY= os.environ.get("API_KEY")

#URL
url = f'http://api.openweathermap.org/data/2.5/weather?lat={LAT}&lon={LONG}&appid={API_KEY}&units=metric'


def main():
    #Requête
    reponse = requests.get(url)

    #Formattage
    reponse_json = reponse.json()

    #Récupération des informations sur la température
    if reponse_json["cod"] != "400":
        response_pretty = json.dumps(reponse_json, indent=4)
        print(response_pretty)
    
    else:
        print(" ERREUR : Localisation non trouvée")

if __name__=="__main__":
    main()
