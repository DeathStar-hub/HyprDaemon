#!/bin/bash
# AI Directory Sync Script - Syncs ~/AI to Google Drive
# This enables Perplexity AI agent to access full AI directory via Google Drive

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directories
SOURCE_DIR="$HOME/AI"
# TODO: Configure Google Drive mount point
# GOOGLE_DRIVE_MOUNT="$HOME/GoogleDrive"  # Update after setup

# Functions
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check Google Drive status
check_google_drive() {
    # Try to check if Google Drive is mounted
    if [[ -d "/home/nemesis/GoogleDrive" ]]; then
        print_success "Google Drive appears to be mounted"
        return 0
    else
        print_warning "Google Drive not detected at /home/nemesis/GoogleDrive"
        print_info "You may need to set up Google Drive with Omarchy"
        return 1
    fi
}

# Show menu
show_menu() {
    echo -e "${BLUE}═════════════════════════════════${NC}"
    echo -e "${BLUE}   AI Directory Sync to Google Drive${NC}"
    echo -e "${BLUE}═════════════════════════════════${NC}"
    echo ""
    echo "Choose sync method:"
    echo "  1) Check Google Drive status"
    echo "  2) Setup instructions"
    echo "  3) Exit"
    echo ""
    read -p "Select option [1-3]: " choice
}

# Setup instructions
show_setup_instructions() {
    clear
    cat << 'SETUP'
${BLUE}═══════════════════════════════════${NC}
${YELLOW}Google Drive Setup Instructions${NC}

${BLUE}Google Drive Sync requires setup${NC}

${GREEN}Option 1: Omarchy Native Google Drive${NC}
${BLUE}─────────────────────────────────────────${NC}

Omarchy provides native Google Drive integration commands:
${YELLOW}• omarchy-drive-info${NC}     - Check drive status/info
${YELLOW}• omarchy-drive-select${NC}   - Select account/drive
${YELLOW}• omarchy-drive-set-password${NC} - Set drive password

${BLUE}To set up:${NC}
1. Run: ${YELLOW}omarchy-drive-select${NC}
2. Select your Google Drive account
3. Run: ${YELLOW}omarchy-drive-set-password${NC}

${BLUE}After setup, Google Drive will sync to: /home/nemesis/GoogleDrive${NC}

${GREEN}Then configure this script to sync to /home/nemesis/GoogleDrive${NC}

${BLUE}─────────────────────────────────────────${NC}

${GREEN}Option 2: rclone (Manual Setup)${NC}
${BLUE}─────────────────────────────────────────${NC}

Use rclone to sync ${SOURCE_DIR} to Google Drive:

1. Install rclone: ${YELLOW}sudo pacman -S rclone${NC}
2. Configure: ${YELLOW}rclone config create gdrive${NC}
3. Auth: ${YELLOW}rclone config create gdrive${NC}
4. Mount: ${YELLOW}rclone mount gdrive: /home/nemesis/GoogleDrive${NC}
5. Test: ${YELLOW}ls /home/nemesis/GoogleDrive${NC}

${BLUE}─────────────────────────────────────────${NC}

${GREEN}Option 3: Placeholder (Not yet implemented)${NC}
${BLUE}─────────────────────────────────────────${NC}

Other tools (rclone wrapper, etc.) could be used.

SETUP
}

# Check Google Drive
check_drive() {
    print_info "Checking Google Drive status..."
    check_google_drive
    echo ""
    
    if [[ -d "/home/nemesis/GoogleDrive" ]]; then
        echo "Google Drive contents:"
        ls -la "/home/nemesis/GoogleDrive" | head -20
    else
        print_error "Google Drive not mounted. See setup instructions above."
    fi
}

# Main execution
main() {
    while true; do
        show_menu
        
        case $choice in
            1)
                check_drive
                ;;
            2)
                show_setup_instructions
                ;;
            3)
                print_info "Exiting..."
                exit 0
                ;;
            *)
                print_error "Invalid option"
                ;;
        esac
        
        echo ""
        read -p "Press Enter to continue or 'q' to quit: " cont
        [[ "$cont" =~ ^[Qq]$ ]] && exit 0
    done
}

main "$@"
