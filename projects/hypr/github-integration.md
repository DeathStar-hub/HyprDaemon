# GitHub Version Control Integration

## Overview
Full Git version control setup for the AI folder with encrypted token storage for multi-computer synchronization.

## Repository
- **URL:** https://github.com/DeathStar-hub/HyprDaemon
- **Type:** Private repository
- **Branch:** main

## Encrypted Token

### Location
`~/AI/github/token.asc` - GPG-encrypted GitHub Personal Access Token

### Default Password
**`hyprdaemon`**

⚠️ **You should re-encrypt with your own strong password!**

### Decrypt Token
```bash
~/AI/github/show-token.sh
# OR
gpg --decrypt ~/AI/github/token.asc
```

### Re-encrypt with Custom Password
```bash
cd ~/AI/github
gpg --decrypt token.asc > token.txt
gpg --symmetric --cipher-algo AES256 --armor --output token-new.asc token.txt
mv token-new.asc token.asc
rm token.txt
```

## Usage

### Commit Changes
```bash
~/AI/git-commit.sh "Description of changes"
```

### Manual Git Commands
```bash
cd ~/AI
git status          # Check status
git add .           # Stage changes
git commit -m "msg" # Commit
git push            # Push to GitHub
git pull            # Pull updates
```

## Multi-Computer Workflow

### Computer A (makes changes)
1. Make edits to configs
2. `~/AI/git-commit.sh "Updated hibernation settings"`
3. Syncthing syncs to Computer B

### Computer B (receives changes)
1. Syncthing syncs ~/AI folder
2. `cd ~/AI && git pull` to get latest
3. Run `~/AI/setup.sh` if needed

## Security

- ✅ Token is GPG-encrypted (AES256)
- ✅ Safe to sync via Syncthing
- ✅ Password required on each computer
- ✅ Can use different passwords per computer
- ✅ Repository is private

## Files

| File | Purpose |
|------|---------|
| `~/AI/github/token.asc` | Encrypted GitHub token |
| `~/AI/github/show-token.sh` | Decrypt helper script |
| `~/AI/github/README.md` | Documentation |
| `~/AI/git-commit.sh` | Easy commit & push |
| `~/AI/.gitignore` | Excludes temp files |

## Created
2026-02-20
