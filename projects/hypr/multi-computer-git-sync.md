# Multi-Computer AI Folder Sync with Git

## Overview
Synchronize the ~/AI folder across multiple computers using **Git + SSH** to eliminate Syncthing sync conflicts and maintain version history across all machines.

**⚠️ Important:** Each computer requires its own SSH key to be **manually added to GitHub** (one-time setup per computer). See [What AI Can Do vs What YOU Must Do](#what-ai-can-do-vs-what-you-must-do) below.

## The Problem with Syncthing-Only Sync

### Before (Syncthing Only)
```
Computer A edits: PROJECT_PROGRESS.md
Computer B edits: PROJECT_PROGRESS.md (different changes)
        ↓
Syncthing syncs
        ↓
CONFLICT: PROJECT_PROGRESS.sync-conflict-20250125-052500.md
```

**Issues:**
- Overwrites of different work
- Sync conflict files everywhere
- Lost changes
- No history of what changed where

### After (Git + Syncthing)
```
Computer A: git commit -m "Added GPU widget" → git push
Computer B: git pull → gets changes, no conflicts
        ↓
Git merges changes intelligently
        ↓
All versions preserved in git history
```

**Benefits:**
- ✅ No more sync conflicts
- ✅ Complete version history
- ✅ Changes from all computers preserved
- ✅ Can see WHO changed WHAT and WHEN
- ✅ Can roll back any change
- ✅ AI can access all versions via git log

---

## Architecture

```
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│  Computer A     │      │  GitHub Repo    │      │  Computer B     │
│  (Tokka)        │◄────►│  (Central Hub)  │◄────►│  (Laptop)       │
│                 │      │                 │      │                 │
│ ~/AI/           │      │ HyprDaemon      │      │ ~/AI/           │
│ .git/           │      │                 │      │ .git/           │
│ SSH Key A       │      │                 │      │ SSH Key B       │
└─────────────────┘      └─────────────────┘      └─────────────────┘
         │                       │                       │
         └───────────────────────┴───────────────────────┘
                          │
                    ┌─────────────┐
                    │  Syncthing  │
                    │  (files)    │
                    └─────────────┘
```

**How It Works:**
1. **Syncthing** keeps ~/AI folder files synced between computers
2. **Git** tracks all changes with version history
3. **GitHub** is the central hub all computers push/pull from
4. **SSH keys** let each computer authenticate securely

---

## What AI Can Do vs What YOU Must Do

| Task | Who Does It | Why |
|------|-------------|-----|
| Generate SSH key on computer | ✅ AI can do this | Just runs a command |
| Copy public key output | ✅ AI can do this | Just displays text |
| **Add key to GitHub website** | ❌ **YOU must do this** | AI cannot access your GitHub account |
| Test SSH connection | ✅ AI can do this | Runs after you add key |
| Git push/pull operations | ✅ AI can do this | Works after setup complete |

**Bottom line:** You only need to paste the SSH key into GitHub once per computer. Everything else AI handles!

---

## Setup Procedure for New Computer

### Step 1: Sync ~/AI Folder via Syncthing
Ensure Syncthing has synced the ~/AI folder to the new computer.

**Verify:**
```bash
ls ~/AI/.git
# Should show: branches/ config description HEAD hooks/ info/ objects/ refs/
```

### Step 2: Generate SSH Key
**On the new computer:**
```bash
ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)"
# Press Enter to accept defaults
```

**This creates:**
- `~/.ssh/id_ed25519` (private key - KEEP SECRET)
- `~/.ssh/id_ed25519.pub` (public key - add to GitHub)

### Step 3: Add Public Key to GitHub ⚠️ **REQUIRED MANUAL STEP**

**⚠️ IMPORTANT:** This step MUST be done manually by YOU. The AI cannot access GitHub settings.

1. **Get your public key:**
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```
   **Copy the entire output** (starts with `ssh-ed25519`)

2. **Go to GitHub:** https://github.com/settings/keys

3. Click **New SSH key**

4. **Fill in the form:**
   - **Title:** Use the computer name (e.g., `Laptop`, `Work-PC`, `NUC`)
   - **Key type:** Authentication key
   - **Key:** Paste the public key you copied in step 1

5. Click **Add SSH key**

**✅ This is a one-time setup per computer. After this, AI can push/pull without credentials!**

### Step 4: Test SSH Connection
```bash
ssh -T git@github.com
```

**Expected output:**
```
Hi DeathStar-hub! You've successfully authenticated...
```

**If it asks about fingerprint:**
Type `yes` and press Enter (first time only)

### Step 5: Configure Git User (Per Computer)
```bash
git config --global user.name "DeathStar-hub"
git config --global user.email "your-email@example.com"
```

### Step 6: Sync with GitHub
```bash
cd ~/AI

# Get latest changes from other computers
git pull origin main

# If there are local changes, commit them first:
git status
# If files are modified:
git add .
git commit -m "Initial sync from $(hostname)"
git push origin main
```

### Step 7: Enable Credential Caching (Optional but Recommended)
```bash
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'
```

---

## Daily Workflow

### Making Changes
```bash
cd ~/AI

# Edit files...
# Then commit and push:
git add .
git commit -m "Description of changes"
git push origin main
```

### Or Use the Helper Script
```bash
~/AI/git-commit.sh "Description of changes"
```

### Getting Changes from Other Computers
```bash
cd ~/AI
git pull origin main
```

**If you get "merge conflicts":**
```bash
# See what's conflicting:
git status

# Edit the conflicted files (look for <<<<<<< HEAD markers)
# Then:
git add .
git commit -m "Merged changes from other computer"
git push origin main
```

---

## AI Access Across Computers

### How AI Sees All Versions

**AI can access git history to see changes from all computers:**

```bash
# See all commits from all computers:
git log --oneline --all

# Example output:
a1b2c3d (Computer A) Added hibernation settings
b2c3d4e (Laptop) Fixed walker theme
c3d4e5f (Work-PC) Updated documentation
```

**AI can compare versions:**
```bash
# See what changed between computers:
git diff ComputerA/main Laptop/main

# See specific file history:
git log -p PROJECT_PROGRESS.md
```

**AI can checkout any version:**
```bash
# Get specific version from any computer:
git checkout <commit-hash>

# Or create branch from specific point:
git checkout -b experiment <commit-hash>
```

---

## Computer Naming Convention

Use consistent names for SSH keys and git configs:

| Computer | SSH Key Title | Git User Config |
|----------|---------------|-----------------|
| Desktop | `Tokka-Desktop` | Same |
| Laptop | `Tokka-Laptop` | Same |
| Work PC | `Work-Desktop` | Same |
| NUC | `Tokka-NUC` | Same |

**GitHub will show which computer pushed:**
```
DeathStar-hub pushed from Tokka-Laptop
DeathStar-hub pushed from Work-Desktop
```

---

## Handling Sync Conflicts

### Scenario: Both Computers Edit Same File

**Computer A:**
```bash
git add .
git commit -m "Updated README"
git push origin main  # Success!
```

**Computer B:**
```bash
git add .
git commit -m "Updated README with more info"
git push origin main  # FAILS - behind origin/main

# Solution:
git pull origin main  # Gets Computer A's changes
# If automatic merge works:
git push origin main  # Now both changes are preserved!
```

### If Automatic Merge Fails

Git will mark conflict sections:
```markdown
<<<<<<< HEAD
Content from Computer B
=======
Content from Computer A
>>>>>>> origin/main
```

**Fix:**
1. Edit file, keep both changes (or choose one)
2. Remove the `<<<<<<<` `=======` `>>>>>>>` markers
3. `git add . && git commit -m "Merged changes"`
4. `git push origin main`

---

## Benefits for AI

### AI Can Now:
1. **See complete project history** - Every change from every computer
2. **Track who did what** - Git commits show computer/source
3. **Recover any version** - Roll back to any point in time
4. **Compare computers** - See differences between setups
5. **No more lost work** - Everything is in git history

### Example AI Queries:
```bash
# "What changed on the laptop?"
git log --oneline --author="DeathStar-hub" | grep -i laptop

# "Show me the last 5 changes to PROJECT_PROGRESS.md"
git log -5 --oneline PROJECT_PROGRESS.md

# "What was different on Computer A vs B yesterday?"
git diff HEAD~1 HEAD
```

---

## Troubleshooting

### "Permission denied (publickey)"
```bash
# Test SSH:
ssh -T git@github.com

# If fails, check key is added:
cat ~/.ssh/id_ed25519.pub
# Copy and add to https://github.com/settings/keys

# Ensure ssh-agent is running:
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### "Merge conflict"
```bash
# See conflicts:
git status

# Open conflicted files, fix markers
# Then:
git add .
git commit -m "Resolved merge conflict"
git push
```

### "Your branch and 'origin/main' have diverged"
```bash
git pull --rebase origin main
# Fix any conflicts
# Then:
git push origin main
```

---

## Quick Reference Card

| Task | Command |
|------|---------|
| Check status | `git status` |
| Stage changes | `git add .` |
| Commit | `git commit -m "message"` |
| Push to GitHub | `git push origin main` |
| Pull changes | `git pull origin main` |
| View history | `git log --oneline` |
| See differences | `git diff` |
| Undo last commit | `git reset --soft HEAD~1` |
| View file history | `git log -p filename` |

---

## Summary

**With Git + SSH:**
- ✅ No more Syncthing sync conflicts
- ✅ Complete version history from all computers
- ✅ AI can access any version from any computer
- ✅ Secure per-computer authentication
- ✅ Easy collaboration between your own computers

**Each computer:**
1. Gets its own SSH key
2. Has its own git config
3. Pushes/pulls to shared GitHub repo
4. Syncthing handles file sync
5. Git handles version control

**Result:** AI has access to complete project evolution across all your systems!
