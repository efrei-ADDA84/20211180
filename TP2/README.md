# 20210372
  <img src="https://cdn.invicti.com/statics/img/drive/h2jfrvzrbyh1yff2n3wfu2hkqqps6x_uvqo.png" alt="Github Actions Logo" />

                                                  
                                             TP 2 : GitHub Actions
    
                                             OBJECTIFS
Ce TP a plusieurs objectifs :

- Configurer un workflow Github Action
- Transformer un wrapper en API : le wrapper du TP1
- Publier automatiquement à chaque push sur Docker Hub
- Mettre à disposition son image (format API) sur DockerHub
- Mettre à disposition son code dans un repository Github


                                            Développement de l'API et du workflow 
                              
      
      1- Configuration du workflow Github Action

Pour configurer le workflow, on utilise une fichier de configuration yaml permettant de définir et spécifier les différentes étapes du flux d'exécution
La configuration se déroule en deux étapes : 

Etape 1 : définir les github secret correspondant aux identifiants de connexion à docker (Settings -> Secrets and variables -> Actions)

Etape 2 : définir le fichier de configuration 
name: ci

on:
  push:
    branches:
      - 'main' //Le workflow est exécuté après chaque push sur la branche main

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
          
      - name: Checkout //Vérification du repository git
        uses: actions/checkout@v3

      - name: Hadoloint //Utilisation de Ghadolint pour vérifier la syntaxe du dockerfile
      - uses: hadolint/hadolint-action@v3.1.0
        with:
          dockerfile: TP2/Dockerfile

      - name: Set up QEMU
        uses: docker/setup-qemu-action@v2

      - name: Set up Docker Buildx /*Cette action crée et démarre un constructeur qui sera utilisé dans les étapes suivantes*/
        uses: docker/setup-buildx-action@v2

      - name: Login to Docker Hub //Connexion à docker en utilisant les secrets
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Build and push // Build et push de l'image docker
        uses: docker/build-push-action@v4
        with:
          context : ./TP2
          push: true
          tags: ${{ secrets.DOCKERHUB_USERNAME }}/tp2:latest
  

       2- Transformer le wrapper du TP1 en API

Le wrapper du TP1 a été transformé en API en utilisant Flask, un framework python. Ainsi en configurant les routes, nous pouvons accéder à la météo après avoir fournis la latitude et la longitude.
  -   http://localhost:8081/?lat=5.902785&lon=102.754175 nous permet d'avoir accès à la météo avec pour latitude 5.902785 et longitude 102.754175 


    3- Publier automatiquement a chaque push sur Docker Hub
Le build et le push se font automatiquement avec GitHub actions


    4- Test du fonctionnement de l'API
  - sudo docker pull axelloyanta/tp2:latest 
  - sudo docker run --network host --env API_KEY=****** axelloyanta/tp2:latest
  - curl "http://localhost:8081/?lat=5.902785&lon=102.754175"


    5- Difficultés rencontrées
  La principale difficulté rencontrée se situe au niveau de la configuration du fichier yaml : comment spcéifier l'enplacement du dockerfile?
  Solution :
  with:
    context : ./TP2

                                    Bonus
Aucune donnée sensible stockée dans l'image : les données sensibles sont stockées dans github secrets

