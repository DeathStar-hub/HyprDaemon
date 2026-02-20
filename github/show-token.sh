#!/bin/bash
# Decrypt and show GitHub token
# Usage: ./show-token.sh

cd ~/AI/github

echo "🔐 Decrypting GitHub token..."
echo ""

if [ -f "token.asc" ]; then
    gpg --decrypt token.asc
elif [ -f "token.gpg" ]; then
    gpg --decrypt token.gpg
else
    echo "❌ Token file not found!"
    exit 1
fi

echo ""
echo "✅ Copy the token above and use it as your password when pushing to GitHub"
