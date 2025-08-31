#!/bin/bash
# backup-restore.sh
# Simple backup/restore system for VPS session

BACKUP_DIR="backup_data"

if [ "$1" == "backup" ]; then
    echo "[*] Backing up VPS data..."
    mkdir -p $BACKUP_DIR
    # Example: backup /root and /etc (customize as needed)
    sudo tar -czf $BACKUP_DIR/vps_backup_$(date +%s).tar.gz /root /etc || true
    echo "[*] Backup complete."

elif [ "$1" == "restore" ]; then
    echo "[*] Restoring latest backup..."
    LATEST_BACKUP=$(ls -t $BACKUP_DIR/vps_backup_*.tar.gz 2>/dev/null | head -n 1)
    if [ -f "$LATEST_BACKUP" ]; then
        sudo tar -xzf "$LATEST_BACKUP" -C /
        echo "[*] Restore complete."
    else
        echo "[!] No backup found, skipping restore."
    fi
else
    echo "Usage: $0 {backup|restore}"
fi
