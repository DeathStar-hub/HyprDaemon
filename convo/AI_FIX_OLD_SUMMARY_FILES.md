# URGENT: Fix Old .summary Files

**Problem:** HyprTitan has old-style 0-byte .summary files in dated folders that shouldn't be there.

**These files are causing Syncthing to hang:**

```
convo/2026-01-03/session-ses_47ae.summary  (0 bytes)
convo/2026-01-03/session-ses_47b7.summary   (0 bytes)
convo/2026-01-04/session-ses_4763.summary   (0 bytes)
convo/2026-01-04/session-ses_4764.summary   (0 bytes)
convo/2026-01-05/session-ses_4711.summary   (0 bytes)
convo/2026-01-05/session-ses_4713.summary   (0 bytes)
convo/2026-01-06/session-ses_4710.summary   (0 bytes)
convo/2026-01-07/session-ses_4671.summary   (0 bytes)
convo/2026-01-07/session-ses_4672.summary   (0 bytes)
convo/2026-01-07/session-ses_46a0.summary   (0 bytes)
```

**FIX - Run these commands:**

```bash
rm ~/AI/convo/2026-01-03/*.summary
rm ~/AI/convo/2026-01-04/*.summary
rm ~/AI/convo/2026-01-05/*.summary
rm ~/AI/convo/2026-01-06/*.summary
rm ~/AI/convo/2026-01-07/*.summary
```

**Why:** Our new structure puts summaries in `groups/` subdirectories, NOT in dated folders. These old files are leftover from HyprTitan's old structure.

**After deleting, commit changes to sync back.**

---

# GitHub Setup (for this computer)

If GitHub isn't set up yet:

```bash
# 1. Generate SSH key (if not exists)
ssh-keygen -t ed25519 -C "your_email@example.com"

# 2. Add to ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# 3. Add public key to GitHub
cat ~/.ssh/id_ed25519.pub
# Copy output → GitHub → Settings → SSH Keys → New Key

# 4. Test connection
ssh -T git@github.com

# 5. Configure git (if needed)
git config --global user.name "YourName"
git config --global user.email "your@email"

# 6. Set remote to SSH (if still HTTPS)
cd ~/AI
git remote set-url origin git@github.com:DeathStar-hub/HyprDaemon.git

# 7. Push/pull normally
git pull origin main
git push origin main
```

**To commit changes:**
```bash
cd ~/AI
git add -A
git commit -m "Describe changes"
git push origin main
```
