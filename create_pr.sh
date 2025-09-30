#!/bin/bash
set -e

# Vérifier que GitHub CLI est installé
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) n'est pas installé. Installe-le avant de lancer ce script."
    exit 1
fi

# Vérifier que le token est fourni
if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ La variable d'environnement GITHUB_TOKEN n'est pas définie."
    exit 1
fi

# Branches
BRANCH="test"
TARGET="preprod"

# Vérifier s’il existe une PR ouverte de test vers preprod
EXISTING_PR=$(gh pr list --head "$BRANCH" --base "$TARGET" --state open --json number --jq '.[0].number')

if [ -n "$EXISTING_PR" ]; then
    echo "🔄 Fermeture de la PR existante #$EXISTING_PR..."
    gh pr close "$EXISTING_PR" --delete-branch=false
fi

# Créer une nouvelle PR avec timestamp pour identifier facilement
PR_TITLE="PR automatique : $BRANCH -> $TARGET ($(date +%Y-%m-%d_%H-%M))"

echo "✨ Création d'une nouvelle PR de $BRANCH vers $TARGET..."
gh pr create \
    --base "$TARGET" \
    --head "$BRANCH" \
    --title "$PR_TITLE" \
    --body "Cette Pull Request a été générée automatiquement par Jenkins."

echo "✅ Pull Request de $BRANCH vers $TARGET créée avec succès : $PR_TITLE"
