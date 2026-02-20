# Google Drive Setup Guide - 2026-02-02

**Status**: ✅ Helper Script Created
**Date**: 2026-02-02
**Purpose**: Enable Perplexity AI to access full AI/ directory via Google Drive

---

## 🎯 Situation

**Dropbox Sync**: ✅ Stopped and disabled
**New Target**: Google Drive (Gemini recommended)
**Goal**: Sync `~/AI/` directory to Google Drive for Perplexity access

---

## 🔧 What's Been Created

### Helper Script
**File**: `~/AI/scripts/tools/sync-to-google-drive.sh`
**Symlink**: `~/AI/sync-to-google-drive.sh` (easy access)
**Purpose**: Menu-driven helper for Google Drive setup and testing

**Features**:
- Check Google Drive mount status
- Show setup instructions for:
  - Omarchy native Google Drive
  - rclone manual setup
- Test sync to Google Drive

---

## 📚 Available Omarchy Commands

### Google Drive (Native)
- `omarchy-drive-info` - Check drive status/info
- `omarchy-drive-select` - Select account/drive
- `omarchy-drive-set-password` - Set drive password
- `omarchy-install-chromium-google-account` - Install Google account

**Note**: These are available but setup documentation is limited.

---

## 🚨 Current Limitations

### Unknowns
1. **Omarchy Google Drive Sync** - Unknown if this supports automatic background sync
2. **Mount Point** - Unknown where Google Drive mounts to
3. **Sync Method** - Unknown if it uses rclone, gocryptfs, or other
4. **Configuration** - Unknown configuration format

### To Research
1. Check `~/.local/share/omarchy/default/omarchy-skill/SKILL.md` for Google Drive info
2. Test `omarchy-drive-info` to see current status
3. Check if Google Drive creates mount point automatically
4. Determine sync method and frequency

---

## 🧪 Recommended Setup Approach

### Option 1: Use rclone (Most Common)
rclone is widely used for Google Drive syncing and works well.

**Steps**:
1. Install rclone: \`sudo pacman -S rclone\`
2. Configure rclone: \`rclone config create gdrive\`
3. Authenticate with Google OAuth
4. Mount Google Drive: \`rclone mount gdrive: /home/nemesis/GoogleDrive\`
5. Configure sync: Set up automatic sync or manual sync script
6. Update sync script to sync to `/home/nemesis/GoogleDrive/AI/`

**Pros**:
- ✅ Well-documented and reliable
- ✅ Supports bidirectional sync
- ✅ Can handle large directories
- ✅ Works with Google Drive

**Cons**:
- ⚠️ Requires OAuth setup (browser authentication)
- ⚠️ May need to install dependencies

### Option 2: Research Omarchy Native Method
If Omarchy provides full Google Drive sync, use it.

**Steps**:
1. Run \`omarchy-drive-info\` to check status
2. Use \`omarchy-drive-select\` to select account
3. Use \`omarchy-drive-set-password\` if needed
4. Test if automatic sync works

**Pros**:
- ✅ Native integration
- ✅ No extra dependencies
- ✅ Tied to Omarchy system

**Cons**:
- ⚠️ Unknown if it supports directory sync
- ⚠️ May be limited functionality

---

## 📋 Testing Checklist

### Option 1 (rclone)
- [ ] Install rclone
- [ ] Configure rclone with Google account
- [ ] Test mount to `/home/nemesis/GoogleDrive`
- [ ] Create sync script to sync to `/home/nemesis/GoogleDrive/AI/`
- [ ] Test sync works
- [ ] Configure automatic sync (if needed)

### Option 2 (Omarchy Native)
- [ ] Run \`omarchy-drive-info\`
- [ ] Check SKILL.md for Google Drive instructions
- [ ] Set up Google Drive account
- [ ] Test automatic sync
- [ ] Verify Perplexity can access

---

## 📁 Files Created

### New Files
- `~/AI/scripts/tools/sync-to-google-drive.sh` - Helper script

### Documentation
- This file (`GOOGLE-DRIVE-SETUP-2026-02-02.md`) - Setup guide

---

## 🚀 Next Steps

### 1. Research (First)
Choose which setup approach:
- Option 1: rclone (recommended, well-documented)
- Option 2: Omarchy native (requires research)

### 2. Install & Configure
Follow the appropriate setup instructions:
- rclone: Install, configure, authenticate, mount
- Omarchy: Research, configure, test

### 3. Test
Verify that:
- Google Drive mounts correctly
- Syncs \`~/AI/\` to Google Drive
- Perplexity can access files

### 4. Configure Perplexity Integration
Update \`~/AI/perplexity.shared/\` to document Google Drive location
- Create \`~/AI/perplexity.shared/google-drive-access.md\` with instructions

---

## ⚠️ Important Notes

1. **Dropbox is now disabled** - Timer stopped and removed
2. **Need to determine Google Drive sync method** - rclone vs Omarchy native
3. **Perplexity integration** - Will need to update once Google Drive is working
4. **Mount point** - Assuming \`/home/nemesis/GoogleDrive\` (common convention)
5. **Sync target** - Should be \`/home/nemesis/GoogleDrive/AI/\` to avoid conflicts

---

## 📚 Related Resources

- **rclone documentation**: https://rclone.org/drive/
- **rclone arch wiki**: \`man rclone\`
- **Omarchy SKILL.md**: \`~/.local/share/omarchy/default/omarchy-skill/SKILL.md\`

---

*Documentation Created: 2026-02-02*
*Google Drive Setup: Helper script created*
*Status: Ready for research and implementation*
*Dropbox Sync: Disabled*
