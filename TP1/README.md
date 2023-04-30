  <img src="https://d1.awsstatic.com/acs/characters/Logos/Docker-Logo_Horizontel_279x131.b8a5c41e56b77706656d61080f6a0217a3ba356d.png" alt="docker logo" />
                                                  
                                                  28/04/2023
                                                  
                                TP 1 : Docker
    
                                Objectifs
Les objectis de ce TP sont multiples
- Créer un repository Github avec pour nom l'identifiant EFREI
- Créer un wrapper qui retourne la météo d'un lieu donné avec sa latitude et sa longitude
(passées en variable d'environnement) en utilisant openweather API et python comme langage de programmation 
- Packager le code dans une image Docker
- Mettre à disposition l'image sur DockerHub
- Mettre à disposition le code dans le repository Github

                                  
                                  Développement et fonctionnement du wrapper
                                  
- Créer un wrapper qui retourne la météo d'un lieu donné avec sa latitude et sa longitude
=> Avec un python requests on récpère les données de l'API
=> L'aspect de le plus critique était la gestion des variables d'environnement qui sont passées en paramètre de l'appel API. Pour ce faire, nous avons utilisé la bibliothèque os de python avec la méthode get() qui récupère les variables d'environnement.

- Packager le code dans une image Docker : nous avons utilisé un Dockerfile puis build

- Mettre à disposition l'image sur DockerHub : avec un docker push nous avons placé notre image dons notre registry sur docker hub


                                  Tests du fonctionnement du wrapper
- Récupérer l'image docker : sudo docker pull axelloyanta/tp1:0.0.4
- Run l'image : sudo docker run --env LAT="31.2504" --env LONG="-99.2506" --env API_KEY=**** axelloyanta/tp1:0.0.4


                                  Bonnus
- Vérification de la propreté du Dockerfile avec hadolint
- Aunce données sensibles stockées dans l'image : les données sensibles sont définies en variable d'environnement.
