# Google Drive Direct Sync Setup (Simplified) - 2026-02-02

**Status**: ✅ Complete - Perplexity workspace removed, direct Google Drive sync created

**Date**: 2026-02-02

---

## 🎯 What Changed

### Previous Approach (REJECTED)
- ❌ Created `~/AI/perplexity.shared/` workspace
- ❌ Created Dropbox sync via `~/AI/sync-to-dropbox.sh`
- ❌ Created Google Drive helper with menu system
- **Reason**: User wants DIRECT Google Drive sync of `~/AI/`, not through Perplexity

### New Approach (APPROVED)
- ✅ **Simple rclone sync script**: `~/AI/sync-to-google-drive.sh`
- ✅ Direct sync: `~/AI/` ↔ Google Drive via rclone
- ✅ No Perplexity workspace needed
- ✅ No Dropbox sync needed

---

## 🔧 How It Works

### Directory Structure

**Source**: `~/AI/` (main AI directory)
**Mount Point**: `~/GoogleDrive/AI/` (assumed, to configure)
**Sync Method**: rclone (AUR package)

### Sync Command

```bash
rclone sync -av --delete "$HOME/AI/" "gdrive:AI$HOME/GoogleDrive"
```

- `-a` : Archive mode (preserves permissions, timestamps)
- `-v` : Verbose (shows progress)
- `--delete` : Delete files in Google Drive not in AI
- `gdrive:AI` : Google Drive remote name (configured)

### Script Features

**File**: `~/AI/sync-to-google-drive.sh`

**Options**:
1. Check rclone (verifies installation)
2. Sync to Google Drive (interactive)
3. Exit

**Automatic Sync**: Can be set up with systemd timer (similar to Dropbox approach)

---

## 📋 Setup Instructions

### 1. Install rclone

```bash
sudo pacman -S rclone
```

### 2. Configure Google Drive

```bash
# Option A: Use rclone config
rclone config create gdrive
rclone config create gdrive:client_id
rclone config create gdrive:client_secret

# Authenticate when prompted
rclone config create gdrive

# Test connection
rclone lsd gdrive:
```

**Option B: Use Omarchy native (if available)**
```bash
omarchy-drive-select
omarchy-drive-set-password
```

### 3. Test Sync

```bash
# Run sync script
~/AI/sync-to-google-drive.sh

# Choose option 2 (Sync)
# Verify files appear in Google Drive at: GoogleDrive/AI
```

### 4. Configure Mount Point (Optional)

If you want Google Drive mounted at `/home/nemesis/GoogleDrive/`:

```bash
# Update script to use mount point
sed -i 's|GOOGLE_DRIVE_MOUNT.*|GOOGLE_DRIVE_MOUNT="/home/nemesis/GoogleDrive"|' ~/AI/sync-to-google-drive.sh
```

### 5. Set Up Automatic Sync (Optional)

Create systemd timer like Dropbox setup:

```bash
# Create service
cat > ~/.config/systemd/user/google-drive-sync.service << 'SERVICE'
[Unit]
Description=Sync AI directory to Google Drive

[Service]
Type=oneshot
ExecStart=%h/AI/sync-to-google-drive.sh sync
WorkingDirectory=%h/AI

[Install]
WantedBy=default.target
SERVICE

# Create timer
cat > ~/.config/systemd/user/google-drive-sync.timer << 'TIMER'
[Unit]
Description=Timer for AI to Google Drive sync

[Timer]
OnUnitActiveSec=60min
OnBootSec=5min
Persistent=true

[Install]
WantedBy=timers.target
TIMER

# Enable and start
systemctl --user daemon-reload
systemctl --user enable google-drive-sync.timer
systemctl --user start google-drive-sync.timer
```

---

## 🔄 Sync Flow

```
~/AI/ (source)
    ↓ rclone sync
    ↓
~/GoogleDrive/AI/ (Google Drive)
    ↓
Perplexity (web portal)
    ↓ reads AI files
```

---

## 📋 Comparison: Dropbox vs Google Drive

| Feature | Dropbox | Google Drive (rclone) |
|---------|---------|---------------------|
| Web Portal | ✅ Yes (dropbox.com) | ✅ Yes (drive.google.com) |
| Native | ❌ No | ✅ No (needs config) |
| Setup | Simple (rsync) | Requires config (OAuth) |
| Speed | Fast | Fast |
| Dependencies | rsync | rclone |
| Mount | Automatic | Manual/Optional |

---

## ⚠️ Important Notes

### rclone Configuration

**Remote Name**: `gdrive:AI`
- First sync: rclone will prompt for OAuth in browser
- Subsequent syncs: Token saved, no re-auth needed

**Mount Point**: Currently assumes `~/GoogleDrive/AI/`
- If using different path, update `GOOGLE_DRIVE_MOUNT` variable in script

### Web Portal Access

**Perplexity Access**: ❌ NOT USED (removed)
- Direct Google Drive: ✅ drive.google.com → GoogleDrive/AI/

### Sync Exclusions

**What's NOT synced**:
- `perplexity.shared/` (removed - no longer exists)
- Old Dropbox sync scripts (removed)
- `sync-to-dropbox.sh` (removed)

---

## 📚 Documentation Created

**New File**: `~/AI/docs/recent/GOOGLE-DRIVE-SYNC-SIMPLIFIED-2026-02-02.md`

**Documentation Removed**:
- `~/AI/docs/recent/PERPLEXITY-INTEGRATION-2026-02-02.md` (no longer needed)
- `~/AI/docs/recent/AI-DROPBOX-SYNC-SETUP-2026-02-02.md` (no longer needed)
- `~/AI/perplexity.shared/` directory (removed)

**Files to Remove** (if desired):
- `~/AI/perplexity.shared/README.md`
- `~/AI/perplexity.shared/PROJECT_PROGRESS.md`
- `~/AI/perplexity.shared/task-list.md`
- `~/AI/perplexity.shared/workspace-state.md`
- `~/AI/perplexity.shared/google-drive-access.md`

---

## ✅ What's Now

### Sync Script
- ✅ Created: `~/AI/sync-to-google-drive.sh`
- ✅ Simple, direct, no Perplexity
- ✅ Uses rclone for Google Drive sync

### Perplexity Stuff
- ✅ **REMOVED** - All Perplexity workspace files deleted
- ✅ Only Google Drive direct sync remains

### Directory State
- ✅ Clean AI root (only essential files)
- ✅ No Perplexity workspace clutter
- ✅ Ready for Google Drive rclone sync

---

## 🚀 Next Steps

1. **Install rclone**: `sudo pacman -S rclone`
2. **Test sync**: `~/AI/sync-to-google-drive.sh` (option 2)
3. **Configure Google Drive**: Set up OAuth via browser
4. **Optional**: Set up automatic sync with systemd timer

---

## 📋 Files Remaining in AI Root

**Essential Files** (Keep):
- `PROJECT_PROGRESS.md` - Progress tracking
- `README.md` - Main documentation
- `setup.sh` - System setup
- `setup-waybar.sh` - Waybar setup
- `sync-to-google-drive.sh` - Google Drive sync script

**Cleanup Needed** (Old files from Dropbox/Syncthing):
- `test-sync.txt` - Can delete
- `.stfolder` - Syncthing folder (keep for Syncthing)

---

*Documentation Created: 2026-02-02*
*Google Drive: Simplified sync script created*
*Perplexity: All workspace files removed*
*Next: Install rclone and configure Google Drive*
