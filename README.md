Etape 1 :<--- accerder au projet depuis le terminal bash --->

$ git clone https://github.com/UnicSibyl/istc_bouakeapp.git
cd istc_bouakeapp
code .

Etape 2 :<--- récupérer les dernières modifications du projet --->
git pull origin main


Etape 3 :<--- apres chaque modif executer cette commande pour mettre à jour le prjet en ligne --->

git add .
git commit -m "Modification du projet"
git push origin main
