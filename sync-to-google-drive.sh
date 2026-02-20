#!/bin/bash
# Simple Google Drive sync script - Syncs ~/AI/ to Google Drive
# Direct sync - no Perplexity workspace needed

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Directories
SOURCE_DIR="$HOME/AI"
# TODO: Configure Google Drive mount point after setup
GOOGLE_DRIVE_MOUNT="$HOME/GoogleDrive/AI"

# Backup directory
BACKUP_DIR="$HOME/GoogleDrive/AI.backup-$(date +%Y%m%d_%H%M%S)"

# Functions
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if rclone is installed
check_rclone() {
    if ! command -v rclone &>/dev/null; then
        print_error "rclone not installed!"
        echo ""
        echo "Install rclone:"
        echo "  sudo pacman -S rclone"
        echo ""
        echo "Then configure:"
        echo "  rclone config create gdrive"
        echo "  rclone config create gdrive:client_id"
        echo "  rclone config create gdrive:client_secret"
        echo ""
        echo "Authenticate in browser when prompted"
        echo ""
        echo "Then sync:"
        echo "  rclone sync $SOURCE_DIR gdrive:AI $GOOGLE_DRIVE_MOUNT"
        return 1
    fi
}

# Sync to Google Drive
sync_to_google() {
    print_info "Syncing $SOURCE_DIR → Google Drive"
    print_warning "This will OVERWRITE Google Drive/AI"
    read -p "Continue? [y/N]: " confirm
    
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        # Create backup
        print_info "Creating backup..."
        cp -r "$GOOGLE_DRIVE_MOUNT" "$BACKUP_DIR" 2>/dev/null
        print_success "Backup created: $BACKUP_DIR"
        
        # Sync using rclone
        print_info "Syncing files..."
        rclone sync -av --delete "$SOURCE_DIR/" "gdrive:AI$GOOGLE_DRIVE_MOUNT"
        
        print_success "Sync complete!"
        print_info "AI files now in Google Drive/AI/"
    fi
}

# Show menu
show_menu() {
    echo -e "${BLUE}═════════════════════════${NC}"
    echo -e "${BLUE}   AI to Google Drive Sync${NC}"
    echo -e "${BLUE}═══════════════════════${NC}"
    echo ""
    echo "Choose action:"
    echo "  1) Check rclone"
    echo "  2) Sync to Google Drive"
    echo "  3) Exit"
    echo ""
    read -p "Select [1-3]: " choice
}

# Main
main() {
    # Check rclone first
    if ! command -v rclone &>/dev/null; then
        print_error "rclone not installed!"
        echo ""
        echo "Install rclone:"
        echo "  sudo pacman -S rclone"
        echo ""
        echo "Then run: $0 $0"
        exit 1
    fi
    
    while true; do
        show_menu
        
        case $choice in
            1)
                check_rclone
                echo ""
                read -p "Press Enter to continue or 'q' to quit: " cont
                [[ "$cont" =~ ^[Qq]$ ]] && exit 0
                ;;
            2)
                sync_to_google
                ;;
            3)
                print_info "Exiting..."
                exit 0
                ;;
            *)
                print_error "Invalid option"
                ;;
        esac
    done
}

main "$@"
