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

# Branche source dynamique depuis Jenkins
SOURCE_BRANCH=${BRANCH:-preprod}
REPO=ton_organisation/ton_repo  # Remplace par ton repo

# Vérifier si un PR existe déjà
EXISTING_PR=$(gh pr list --head "$SOURCE_BRANCH" --base main --repo "$REPO" --json number -q '.[0].number')

if [ -z "$EXISTING_PR" ]; then
    # Créer le PR si aucun n'existe
    gh pr create \
      --base main \
      --head "$SOURCE_BRANCH" \
      --title "🚀 PR automatique : $SOURCE_BRANCH -> main" \
      --body "Cette Pull Request a été générée automatiquement par Jenkins pour la mise en prod." \
      --repo "$REPO"
    echo "✅ Pull Request vers main (prod) créée avec succès."
else
    echo "ℹ️ Un PR existe déjà : #$EXISTING_PR"
fi
