# README
**instaler les gemfiles**

$ bundle install

**installer capfile**
$ cap install STAGE=production

**configurer le capfile**
ajouter les lignes qui sont dans capfile

**configurer deploy.rb**
ajouter les lignes qui sont dans capfile

**mettre database.yml dans .gitignore**
config/database.yml

**envoyer sur github**
$ git add .
$ git commit "first commit"

**créer l'instance**
aller dans EC2 choisir le server UBUNTU
puis le configurer en suivant les étapes
créer une paire de clé

**ouvrir deux terminaux**
un pour le local et l'autre pour le serveur distants

---dans le terminal de EC2
**se connecter à l'instance**
télécharger la clé
$ chmod 400 blog.pem
$ ssh -i "blog.pem" ubuntu@ec2-54-156-57-141

une fois connecté: faire les mises à jours et autre installations sur l'instance
- sudo apt-get update && sudo apt-get -y upgrade

**créer un utilisateur**
- $ sudo useradd -d /home/deploy -m deploy

ajouter un mot de passe à l'utilisateur
- $ sudo passwd deploy

donner tous les droits à l'utilisateur
- $ deploy ALL=(ALL:ALL) ALL

accéder à l'utilisateur
- $ su - deploy

(/bin/bash --login ) au cas où l'utilisateur n'est pas connecter sur le profile

- générer le clé de sécurité 
$ ssh-keygen
$ cat .ssh/id_rsa.pub

--récupérer la clé ssh du serveur EC2 pour l'ajouter à github.c'est pour donner la permission au Ec2 d'envoyer des chose sur github.
- aller dans github
- setting/ SSH key and 
-  ajouter la clé ssh précédement copiée
- vérifier que la connection passe $ ssh -T git@github.com 

- Aller dans le terminal local: pour générer la clé ssh.
$ cat .ssh/id_rsa.pub
copie la clé ssh pour 

- ensuite dans le terminal Ec2 ouvrir authorized_keys
$ vi .ssh/authorized_keys

coller la clé ssh précédement copiée dans l'authorized_key
:wp (pour enregistrer et sortir)

**installer github sur le serveur EC2**

 $ sudo apt-get install git
 
**configurer nginx**

 $ sudo vi /etc/nginx/sites-available/default
( configuration  nginx)
ATTENTION, ce qui était là en commentaire
:wq

**installer postgresql

$ sudo apt-get install postgresql postgresql-contrib libpq-dev

-créer un user postgresql
$ sudo -u postgres createuser -s nom du projet

-créer un mot de pass
sudo -u postgres psql

postgres=# \password urlshortner


sudo -u postgres createdb -O urlshortner urlshortner_production


su - deploy
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable



rvm install 2.2.3


gem install bundler --no-ri --no-rdoc


mkdir urlshortner
mkdir -p urlshortner/shared/config
nano urlshortner/shared/config/database.yml


nano urlshortner/shared/config/application.yml


