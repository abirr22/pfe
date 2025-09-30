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

BRANCH="preprod"
TARGET="main"

# Vérifier s’il existe une PR ouverte de preprod vers main
EXISTING_PR=$(gh pr list --head "$BRANCH" --base "$TARGET" --state open --json number --jq '.[0].number')

if [ -n "$EXISTING_PR" ]; then
  echo "🔄 Fermeture de la PR existante #$EXISTING_PR..."
  gh pr close "$EXISTING_PR" --delete-branch=false
fi

# Créer une nouvelle PR
echo "✨ Création d'une nouvelle PR de $BRANCH vers $TARGET..."
gh pr create \
  --base "$TARGET" \
  --head "$BRANCH" \
  --title "PR automatique : $BRANCH -> $TARGET" \
  --body "Cette Pull Request a été générée automatiquement par Jenkins pour la mise en prod."

echo "✅ Pull Request de $BRANCH vers $TARGET créée avec succès."
