# Ranger File Associations Setup

This document describes the custom Ranger configuration included in the AI system for optimal file opening workflow.

## Configuration File
**Location:** `~/.config/ranger/rifle.conf`

## File Type Mappings

| File Type | MIME Pattern | Program | Description |
|-----------|--------------|---------|-------------|
| **Text files** | `^text` | `kate` | Text editor (KDE) |
| **Image files** | `^image` | `imv` | Image viewer |
| **Video files** | `^video` | `mpv` | Video player |
| **Unknown** | `*` | `kate` | Default fallback |

## Programs Used

### kate
- **Type:** KDE Text Editor
- **Package:** `kate`
- **Purpose:** Editing all text-based files (.md, .txt, .sh, .conf, etc.)
- **Installation:** `paru -S kate`

### imv
- **Type:** Image Viewer
- **Package:** `imv`
- **Purpose:** Quick image viewing (.png, .jpg, .gif, .svg, etc.)
- **Installation:** `paru -S imv`
- **Features:** Terminal-based, fast, lightweight

### mpv
- **Type:** Video Player
- **Package:** `mpv`
- **Purpose:** Video playback (.mp4, .webm, .mkv, etc.)
- **Installation:** `paru -S mpv`
- **Features:** Terminal-based, supports wide range of formats

## How It Works

When you press `Enter` or `l` on a file in Ranger:

1. **rifle** checks the file's MIME type
2. Matches it against configured patterns
3. Opens the appropriate program:
   - Text files → kate
   - Image files → imv
   - Video files → mpv
   - Unknown files → kate (fallback)

## Benefits

- **Automatic file type detection** - No need to remember which program opens what
- **Consistent workflow** - Text always opens in kate, images in imv
- **Lightweight** - All viewers are terminal-based and fast
- **Reproducible** - Configuration is backed up in `~/AI/config/ranger/`

## Customization

To modify file associations, edit `~/AI/config/ranger/rifle.conf` and run:

```bash
cd ~/AI
./setup.sh
```

## Troubleshooting

### Ranger not opening files with correct program
```bash
# Check rifle configuration
cat ~/.config/ranger/rifle.conf

# Test manually
rifle -l ~/.config/ranger/rifle.conf /path/to/file
```

### Image files still opening in kate
1. Verify imv is installed: `which imv`
2. Check rifle.conf syntax
3. Reinstall configuration: `./setup.sh`

## Related Files

- **Configuration:** `~/AI/config/ranger/rifle.conf`
- **Setup Script:** `~/AI/setup.sh` (automatically copies rifle.conf)
- **Documentation:** `~/AI/ranger-setup.md` (this file)
