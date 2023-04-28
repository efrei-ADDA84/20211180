#Téchargement de l'image
FROM python:3.9.12

# Empêcher Python de générer des fichiers .pyc dans le conteneur => alléger l'image
ENV PYTHONDONTWRITEBYTECODE=1

# Désactivation de la mise en mémoire tampon pour faciliter l'enregistrement des conteneurs
ENV PYTHONUNBUFFERED=1


#Installation des librairies
#Éviter l'utilisation du répertoire cache avec pip
RUN pip install --no-cache-dir requests==2.7.0 


WORKDIR /weather_app_tp1
COPY . /weather_app_tp1

# Pendant le débogage, ce point d'entrée sera remplacé.
CMD ["python3", "open_weather_tp1.py"]
 