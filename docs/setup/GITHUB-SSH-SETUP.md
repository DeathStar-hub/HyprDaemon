# GitHub SSH Setup for New Computer

## Purpose
Set up SSH key for AI to access GitHub repos (push/pull) on a new computer. Key unlocks automatically when you log into desktop.

---

## Step 1: Install Required Packages

```bash
# Arch/Manjaro
sudo pacman -S openssh ssh-askpass

# Debian/Ubuntu
sudo apt install openssh-client x11-ssh-askpass
```

**Why ssh-askpass?** Enables graphical password prompt so SSH key unlocks automatically when you log into desktop (not just terminal).

---

## Step 2: Generate SSH Key

```bash
# Run in terminal
ssh-keygen -t ed25519 -C "your@email.com"
```

**Important prompts:**
- Save location: Press Enter (default: ~/.ssh/id_ed25519)
- **Passphrase: ENTER A STRONG PASSWORD** (protects key from AI access)
- Confirm passphrase: Enter again

---

## Step 3: Add Public Key to GitHub

```bash
# Display your public key
cat ~/.ssh/id_ed25519.pub
```

1. Copy the output (starts with `ssh-ed25519 ...`)
2. Go to: https://github.com/settings/keys
3. Click "New SSH key"
4. Paste the key
5. Click "Add SSH key"

---

## Step 4: Test Connection

```bash
# Should reply: "Hi DeathStar-hub! You've successfully authenticated..."
ssh -T git@github.com
```

If it asks for password, enter your SSH key passphrase.

---

## Step 5: Accept GitHub Host Key

If you get "Host key verification failed":

```bash
# Type "yes" when prompted
ssh git@github.com
```

---

## Step 6: Configure Auto-Unlock on Desktop Login

### Option A: Using systemd (recommended)

```bash
# Create systemd user service
mkdir -p ~/.config/systemd/user

cat > ~/.config/systemd/user/ssh-agent.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=SSH Agent
Comment=SSH Key Agent
Exec=/usr/bin/ssh-add
EOF

# Copy to autostart
mkdir -p ~/.config/autostart
cp ~/.config/systemd/user/ssh-agent.desktop ~/.config/autostart/
```

### Option B: Using fish shell (if using fish)

```bash
# Create ssh agent function
mkdir -p ~/.config/fish/functions

cat > ~/.config/fish/functions/fish_greeting.fish << 'EOF'
# SSH Agent auto-start (non-blocking)
# Only starts agent - key unlocks via ssh-askpass on desktop login
if not set -q SSH_AUTH_SOCK
    eval (ssh-agent -c)
end
EOF
```

---

## Step 7: Sync AI Config to New Computer

### Option A: Clone from GitHub

```bash
# Clone your AI config repo
git clone git@github.com:DeathStar-hub/AI.git ~/AI
```

### Option B: Copy from existing computer

```bash
# On old computer - push latest
cd ~/AI
git add .
git commit -m "Update before sync"
git push origin main

# On new computer - pull latest
cd ~/AI
git pull origin main
```

---

## Step 8: Verify AI Has GitHub Access

In OpenCode, test:

```bash
ssh -T git@github.com
```

Should return: `Hi DeathStar-hub! You've successfully authenticated...`

---

## How It Works

| Stage | What Happens |
|-------|--------------|
| 1. Desktop login | ssh-askpass prompts for SSH key password |
| 2. Key unlocked | Decrypted key stored in ssh-agent memory |
| 3. Terminal opened | New terminals inherit ssh-agent socket |
| 4. Git operations | Work without asking for password |

**Security:** AI can't access the password-protected key on disk, but you get seamless access after entering password once per desktop login.

---

## Security Notes

| What | Protection |
|------|------------|
| SSH key on disk | 🔒 Password encrypted (AI can't use without password) |
| SSH agent memory | ✅ Unlocked for your session |
| AI reading key file | ❌ Can't use - needs password |

**Never share your private key** (id_ed25519) - only the public key (id_ed25519.pub) goes on GitHub.

---

## Troubleshooting

### "Permission denied (publickey)"
- Key not added to GitHub? Go to Step 3
- Wrong key file? Check `~/.ssh/config`

### "Host key verification failed"
- Run Step 5 to accept host key

### "Too many authentication failures"
- Too many keys? Add to ~/.ssh/config:
  ```
  Host github.com
    IdentityFile ~/.ssh/id_ed25519
  ```

### Key doesn't auto-unlock
- Make sure ssh-askpass is installed (Step 1)
- Check ~/.config/autostart/ for ssh-agent desktop file

---

## Quick Reference

```bash
# Install packages
sudo pacman -S openssh ssh-askpass

# Generate key
ssh-keygen -t ed25519 -C "your@email.com"

# View public key
cat ~/.ssh/id_ed25519.pub

# Test connection
ssh -T git@github.com

# Clone repo
git clone git@github.com:DeathStar-hub/AI.git ~/AI
```
