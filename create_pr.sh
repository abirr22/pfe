#!/bin/bash
set -e

# Vérifier que GitHub CLI est installé
if ! command -v gh &> /dev/null
then
    echo "❌ GitHub CLI (gh) n'est pas installé. Installe-le avant de lancer ce script."
    exit 1
fi

# Vérifier que le token est fourni
if [ -z "$GITHUB_TOKEN" ]; then
  echo "❌ La variable d'environnement GITHUB_TOKEN n'est pas définie."
  exit 1
fi

# Créer la Pull Request directement, GitHub CLI utilisera automatiquement GITHUB_TOKEN
gh pr create \
  --base main \
  --head preprod \
  --title "PR automatique : preprod -> main" \
  --body "Cette Pull Request a été générée automatiquement par Jenkins pour la mise en prod."

echo "✅ Pull Request de preprod vers main créée avec succès."
