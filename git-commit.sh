#!/bin/bash
# Git commit helper for AI folder
# Usage: ./git-commit.sh "Your commit message"

if [ -z "$1" ]; then
    echo "Usage: ./git-commit.sh 'Your commit message'"
    echo "Example: ./git-commit.sh 'Fixed walker theme colors'"
    exit 1
fi

cd ~/AI

echo "📦 Adding all changes..."
git add .

echo "📝 Committing with message: $1"
git commit -m "$1"

echo "🚀 Pushing to GitHub..."
git push origin main

echo "✅ Done!"
