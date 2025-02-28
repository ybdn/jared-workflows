#!/bin/bash
cd /var/lib/docker/volumes/n8n_data/_data/workflows

# Vérifier s'il y a des modifications
if [[ -n $(git status --porcelain) ]]; then
    git add .
    git commit -m "Auto-update n8n workflows - $(date)"
    git push origin master
else
    echo "Aucune modification détectée, pas de push nécessaire."
fi
