# Package Manager Configuration

## Overview
Configuration and optimization of package managers for the Hyprland system.

## Paru AUR Helper Configuration

### Status
✅ **COMPLETED** - Paru configuration optimized and deployed

### Configuration File
- **Location**: `~/.config/paru/paru.conf`
- **Backup**: `doc-sync/Config/RunningCF/Package_Managers/paru.conf`

### Key Settings Applied
- **BottomUp**: Search results display from bottom to top (AUR packages first)
- **CleanAfter**: Automatically removes build sources after installation
- **Devel**: Enables development package updates (git/svn versions)

### Configuration Details
```ini
[options]
BottomUp          # Results start at bottom of terminal
CleanAfter        # Clean build sources after install
Devel             # Update development packages
# NoSign          # GPG signing disabled (commented)
# NoSignDB        # Database signing disabled (commented)
```

### Optional Settings (Available)
- **NoConfirm**: Skip confirmation prompts
- **MFlags**: Custom makepkg flags (e.g., `--skippgpcheck`)
- **GitFlags**: Git optimization flags (e.g., `--depth=1`)
- **AurUrl**: Alternative AUR mirror URL
- **CloneDir**: Custom AUR package download directory

### Benefits
- **Better UX**: Search results start at terminal bottom as requested
- **Space Saving**: Automatic cleanup of build sources
- **Development Support**: Keeps git/svn packages updated
- **Faster Builds**: Optional GPG check skipping available

### Usage Notes
- Configuration active system-wide
- Test with `paru -Ss <package>` to verify bottom-up display
- Can override settings with command-line flags
- Backup maintained in RunningCF config directory

---

## Future Package Manager Configurations

### Potential Additions
- **Pacman**: Main repository package manager configuration
- **Yay**: Alternative AUR helper (if needed)
- **Flatpak**: Sandbox application management
- **Snap**: Universal package management (if required)

### Documentation Structure
- System parameters tracked in `doc-sync/AI/model parameters.md`
- Package configs backed up in `doc-sync/Config/RunningCF/Package_Managers/`
- Project-specific details in respective project files