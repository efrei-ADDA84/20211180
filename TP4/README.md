# 20211180
  <img src="https://blog.logrocket.com/wp-content/uploads/2020/01/dirty-terraform-hacks.png" alt="Terraform Logo" />



                                             23/06/2023    
                                             TP 4 : Cloud - Terraform
    
                                             OBJECTIFS

Ce TP a pour objectifs de :

- Créer une machine virtuelle Azure (VM) avec une adresse IP publique dans un réseau
existant
- Utiliser Terraform
- Se connecter à la VM avec SSH
- Comprendre les différents services Azure (ACI vs. AVM)



                                        Création de la machine virtuelle
                Pour développer la machine virtuelle, nous avons diviser le TP en plusieurs modules


                                            1- provider.tf
Dans ce fichier, nous avons défini les providers permettant d'initialiser l'environnement terraform.

                                            2- variables.tf
Dans ce fichier sont définies toutes les variables utilisées (groupe de ressources, subscription id, admin name, ...) dans le TP afin d'éviter la duplication de code.

                                            3- data.tf
Ici, nous importons les ressources déjà présentes sur azure (:Data_source) network et subnet.

                                            4- net_conf.tf
Ici sont définies toutes les ressources nécessaires à la mise en place du réseau (attribution d'une adresse IP publique à la VM) et à la création de la clé ssh.

                                            5- vm.tf
Dans ce fichier nous créons une machine virtuelle azurerm_linux_virtual_machine qui est née d'une évolution de azurerm_virtual_machine (maintenant dépréciée). Après la spécification des paramètres, nous avons installé docker sur la machine virtuelle en utilsant le provisioner remote_exec qui permet d'exécuter des commandes shell à la création de la machine.
L'une des difficultés les plus importantes a été la compréhension et l'utilisation de l'objet connection permettant d'établir la connexion entre le provisioner et la machine virtuelle.

Remarque :  le fichier vm_deprecated.tf contient le code de création d'une machine virtuelle azurerm_virtual_machine. Lors de la création de cette machine, la difficulté la plus importante à laquelle nous avons été confronté fut la mise en place de la connexion ssh. En effet, lors de la création de la machine, terraform ne reconnaissait pas le chemin de stockage de la clé ssh.
 
                                            6- outputs.tf
Ici nous récupérons et affichons certains éléments créés lors de l'instanciation de la machine virtuelle. Il s'agit de l'addresse IP publique utile pour la connexion ssh via le terminal, du nom du groupe de ressource et de la clé publique ssh.

                                            7- Exécution
Ouvrez le terminal et saisissez les commandes suivantes : 
terraform init      #Initialise l'environnement en utilisant le fichier provider.tf

terraform validate  #Vérifie que le code terraform est correctement formaté et ne contient pas d'erreur de syntaxe

terraform apply     #Effectue un terraform plan affichant les différentes actions prévues et demande l'autorisation d'exécution. Après exécution, toutes les #                   ressources sont créées

terraform output -raw tls_private_key > id_rsa   #Récupère la clée ssh créée et la stocke dans un fichier nommé id_rsa

ssh -i id_rsa devops@{vm_public_ip_adress}       #Effectue la connexion à la machine virtuelle en utilisant la clé ssh et l'adresse ip publique affichée #                                                 dans le terminal