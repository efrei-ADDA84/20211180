# 20211180
  <img src="https://expertime.com/wp-content/uploads/2021/03/ACI-container.png" alt="Azure Container Instance Logo" />



                                             27/05/2023     
                                             TP 3 : Cloud - ACI
    
                                             OBJECTIFS

Ce TP a pour objectifs de :

- Mettre à disposition le code dans un repository Github
- Utiliser Github Actions pour :
    - Mettre à disposition l'image (format API) sur Azure Container Registry (ACR)
    - Deployer sur Azure Container Instance (ACI) 



                                        Développement de l'API et du workflow

                                1- Développement de l'API : on utilisera l'API développée au TP2

                                2- Configuration du workflow Github Action 

Pour configurer le workflow, on utilise de nouveau un fichier de configuration yaml après avoir défini les github secrets pour les données sensibles.

Structure du fichier : il est constitué d'un job nommé "build-and-deploy" qui tourne sur ubuntu. Ce job comporte plusieurs tâche dont :
- La vérification du répertoire git
- La connexion à Azure portail afin de pouvoir effectuer le déploiement sur azure container instance
- La construction d'une image docker en vérifiant au préalable le Dockerfile avec Hadoloint
- Le déploiement sur ACI où on spécifie notament le numéro de port de connexion et les variable d'environnement nécessaires au wrapper


                                3- Choix de l'outil de déploiement

Nous utilisons Github Actions au lieu de l'interface utilisateur ou la CLI car c'est l'outil qui nous permet de nous rapprocher le plus des principes devops. En effet, avec le workflow github actions, le déploiement est effectué automatiquement à chaque push. On peut ainsi développer et déployer de manière rapide afin de répondre quasi spontanément aux besoins d'un marché qui est en constant changement.


                                4- Test de fonctionnement de l'API

Après le déploiement de l'application (push ou run du workflow), on peut interroger l'API déployée sur ACI avec une commande curl :
curl "http://devops-20211180.francesouth.azurecontainer.io:8081/?lat=5.90275&lon=102.754175"


                                5- Difficultés rencontrées

Nous avons été confrontés à deux problèmes :
- comment spcéifier l'enplacement du dockerfile?
  Solution :
  run: |
        docker build ./TP3

- un bug lors de l'intrrogation de l'API : dans un premier temps, l'API renvoie les informations sur la météo. Puis, après un certain nombre de requêtes, le message revoyé est une erreur 404. Ce bug est probablement lié à azure cloud.
Solution possible : supprimer la container instance et relancer le workflow github actions.
