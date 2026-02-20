# GitHub Token Storage

## Encrypted Token File

**File:** `token.asc` (password protected)

This file contains your GitHub Personal Access Token in encrypted form.

### Default Password
The token is encrypted with password: **`hyprdaemon`**

**⚠️ SECURITY WARNING:** You should re-encrypt this with your own strong password!

---

## How to Use

### Decrypt the Token (on a new computer)

```bash
cd ~/AI/github
gpg --decrypt token.asc
```

You'll be prompted for the password. Enter it to see the token.

### Re-encrypt with Your Own Password (RECOMMENDED)

```bash
cd ~/AI/github

# Decrypt first
gpg --decrypt token.asc > token.txt

# Re-encrypt with new password
gpg --symmetric --cipher-algo AES256 --armor --output token-new.asc token.txt

# Replace old file
mv token-new.asc token.asc
rm token.txt
```

---

## Repository Info

- **Repository:** https://github.com/DeathStar-hub/HyprDaemon
- **Username:** DeathStar-hub
- **Local Path:** ~/AI

---

## Quick Git Commands

```bash
# Check status
git status

# Add and commit all changes
git add .
git commit -m "Description of changes"

# Push to GitHub
git push origin main

# Or use the helper script
~/AI/git-commit.sh "Description of changes"
```

---

## Setting Up on Another Computer

### Option 1: Clone Fresh
```bash
git clone https://github.com/DeathStar-hub/HyprDaemon.git ~/AI
```

### Option 2: If ~/AI exists via Syncthing
```bash
cd ~/AI
git pull
```

### Authenticate
When you first push, you'll need the token:
```bash
cd ~/AI
git push origin main
# Username: DeathStar-hub
# Password: (decrypt token.asc to get it)
```

---

## Security Notes

- Never commit the unencrypted token
- The token.asc file IS safe to sync via Syncthing (it's encrypted)
- Change your GitHub token if you ever lose control of the encrypted file
- Consider using SSH keys instead for better long-term security
