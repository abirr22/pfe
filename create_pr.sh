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

# Authentification avec le token
echo "$GITHUB_TOKEN" | gh auth login --with-token

# Branche source dynamique depuis Jenkins
SOURCE_BRANCH=${BRANCH:-preprod}

# Créer la Pull Request
gh pr create \
  --base main \
  --head "$SOURCE_BRANCH" \
  --title "🚀 PR automatique : $SOURCE_BRANCH -> main" \
  --body "Cette Pull Request a été générée automatiquement par Jenkins pour la mise en prod."

echo "✅ Pull Request vers main (prod) créée avec succès."
