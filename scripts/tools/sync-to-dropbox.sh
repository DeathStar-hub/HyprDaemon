#!/bin/bash
# AI Directory Sync Script - Syncs ~/AI with ~/Dropbox/AI
# This enables Perplexity web portal access to latest AI work

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directories
SOURCE_DIR="$HOME/AI"
DROPBOX_DIR="$HOME/Dropbox/AI"
PERPLEXITY_SOURCE="$HOME/AI/perplexity.shared"
PERPLEXITY_DROPBOX="$HOME/Dropbox/AI/perplexity"
BACKUP_DIR="$HOME/Dropbox/AI.backup-$(date +%Y%m%d_%H%M%S)"

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

# Check if directories exist
check_dirs() {
    if [[ ! -d "$SOURCE_DIR" ]]; then
        print_error "Source directory not found: $SOURCE_DIR"
        exit 1
    fi
    
    if [[ ! -d "$DROPBOX_DIR" ]]; then
        print_error "Dropbox directory not found: $DROPBOX_DIR"
        exit 1
    fi
    
    print_success "Directories verified"
}

# Show sync options
show_menu() {
    echo -e "${BLUE}═════════════════════════════════════════${NC}"
    echo -e "${BLUE}   AI Directory Sync to Dropbox${NC}"
    echo -e "${BLUE}═════════════════════════════════════════${NC}"
    echo ""
    echo "Choose sync direction:"
    echo "  1) AI → Dropbox  (push main AI + Perplexity to Dropbox)"
    echo "  2) Dropbox → AI   (restore from Dropbox)"
    echo "  3) Bidirectional  (sync both ways - USE WITH CAUTION)"
    echo "  4) Show diff      (see what would change)"
    echo "  5) Backup Dropbox   (backup Dropbox before overwriting)"
    echo "  6) Exit"
    echo ""
    read -p "Select option [1-6]: " choice
}

# Sync AI to Dropbox
sync_to_dropbox() {
    print_info "Syncing $SOURCE_DIR + Perplexity → $DROPBOX_DIR"
    print_warning "This will OVERWRITE Dropbox with local AI + Perplexity changes"
    read -p "Continue? [y/N]: " confirm
    
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        # Create backup first
        print_info "Creating backup of Dropbox AI..."
        cp -r "$DROPBOX_DIR" "$BACKUP_DIR"
        print_success "Backup created: $BACKUP_DIR"
        
        # Sync main AI directory
        print_info "Syncing main AI directory..."
        rsync -av --progress --delete \
            --exclude '.stfolder' \
            --exclude '*.sync-conflict-*' \
            --exclude '*.backup-*' \
            --exclude 'session_logs/' \
            --exclude 'perplexity.shared/' \
            "$SOURCE_DIR/" "$DROPBOX_DIR/"
        
        # Sync Perplexity directory separately
        print_info "Syncing Perplexity workspace..."
        rsync -av --progress --delete \
            "$PERPLEXITY_SOURCE/" "$PERPLEXITY_DROPBOX/"
        
        print_success "Sync complete!"
        print_info "Main AI + Perplexity workspace synced to Dropbox for Perplexity access"
    fi
}

# Sync Dropbox to AI
sync_from_dropbox() {
    print_info "Syncing $DROPBOX_DIR → $SOURCE_DIR"
    print_warning "This will OVERWRITE local AI with Dropbox version"
    read -p "Continue? [y/N]: " confirm
    
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        print_info "Syncing files..."
        rsync -av --progress --delete \
            --exclude '.stfolder' \
            --exclude '*.sync-conflict-*' \
            --exclude '*.backup-*' \
            --exclude 'perplexity/' \
            "$DROPBOX_DIR/" "$SOURCE_DIR/"
        
        print_success "Sync complete!"
    fi
}

# Bidirectional sync (USE WITH CAUTION)
bidirectional_sync() {
    print_warning "BIDIRECTIONAL SYNC CAN CAUSE CONFLICTS"
    print_warning "Only use if you know what you're doing!"
    read -p "Are you sure? [y/N]: " confirm
    
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        print_info "Syncing both directions..."
        rsync -av --progress "$SOURCE_DIR/" "$DROPBOX_DIR/"
        rsync -av --progress "$PERPLEXITY_SOURCE/" "$PERPLEXITY_DROPBOX/"
        rsync -av --progress "$DROPBOX_DIR/" "$SOURCE_DIR/"
        rsync -av --progress "$PERPLEXITY_DROPBOX/" "$PERPLEXITY_SOURCE/"
        print_success "Sync complete!"
    fi
}

# Show differences
show_diff() {
    print_info "Comparing directories..."
    print_info "Files in AI but not in Dropbox (would be added to Dropbox):"
    diff -rq "$SOURCE_DIR" "$DROPBOX_DIR" | grep "^Only in $SOURCE_DIR" || echo "  (none)"
    
    print_info "Files in Dropbox but not in AI (would be removed from Dropbox):"
    diff -rq "$SOURCE_DIR" "$DROPBOX_DIR" | grep "^Only in $DROPBOX_DIR" || echo "  (none)"
}

# Backup Dropbox directory
backup_dropbox() {
    print_info "Backing up Dropbox AI directory..."
    cp -r "$DROPBOX_DIR" "$BACKUP_DIR"
    print_success "Backup created: $BACKUP_DIR"
}

# Auto sync mode (for systemd timer)
auto_sync() {
    check_dirs
    
    # Log to systemd journal
    echo "Starting automatic AI + Perplexity → Dropbox sync at $(date)"
    
    # Create backup first
    BACKUP_DIR="$HOME/Dropbox/AI.auto-backup-$(date +%Y%m%d_%H%M%S)"
    cp -r "$DROPBOX_DIR" "$BACKUP_DIR" 2>/dev/null
    
    # Sync main AI directory
    rsync -av --delete \
        --exclude '.stfolder' \
        --exclude '*.sync-conflict-*' \
        --exclude '*.backup-*' \
        --exclude 'session_logs/' \
        --exclude 'perplexity.shared/' \
        "$SOURCE_DIR/" "$DROPBOX_DIR/"
    
    # Sync Perplexity directory
    rsync -av --delete \
        "$PERPLEXITY_SOURCE/" "$PERPLEXITY_DROPBOX/"
    
    echo "Automatic sync completed at $(date)"
}

# Main execution
main() {
    check_dirs
    
    # Check for auto-sync flag
    if [[ "$1" == "--auto" ]]; then
        auto_sync
        exit 0
    fi
    
    while true; do
        show_menu
        
        case $choice in
            1)
                sync_to_dropbox
                ;;
            2)
                sync_from_dropbox
                ;;
            3)
                bidirectional_sync
                ;;
            4)
                show_diff
                ;;
            5)
                backup_dropbox
                ;;
            6)
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
