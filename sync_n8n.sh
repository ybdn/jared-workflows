#!/bin/bash
LOGFILE="/var/lib/docker/volumes/n8n_data/_data/workflows/git_sync.log"

echo "----- $(date) : Début de la synchronisation -----" >> $LOGFILE
cd /var/lib/docker/volumes/n8n_data/_data/workflows || exit

# Récupérer les mises à jour de GitHub
echo "Exécution de git pull --rebase origin master" >> $LOGFILE
git pull --rebase origin master >> $LOGFILE 2>&1

# Ajouter toutes les modifications
echo "Ajout des fichiers modifiés avec git add -A" >> $LOGFILE
git add -A >> $LOGFILE 2>&1

# Vérifier s'il y a des changements à committer
if ! git diff --cached --exit-code > /dev/null; then
    echo "Commit des modifications avec git commit" >> $LOGFILE
    git commit -m "Auto-update n8n workflows - $(date)" >> $LOGFILE 2>&1
    echo "Push des modifications avec git push origin master" >> $LOGFILE
    git push origin master >> $LOGFILE 2>&1
else
    echo "Aucune modification détectée, pas de push nécessaire." >> $LOGFILE
fi

echo "----- $(date) : Fin de la synchronisation -----" >> $LOGFILE
