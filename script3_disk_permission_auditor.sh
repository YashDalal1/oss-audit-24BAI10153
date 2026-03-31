#!/bin/bash
# Script 3: Disk and Permission Auditor
# Author: Yash Dalal | Reg No: 24BAI10153
# Course: Open Source Software | Capstone Project
# Purpose: Loops through key system directories and reports disk usage,
#          ownership, and permissions. Also checks Git's config directory.

DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share" "/var")

echo "========================================================"
echo "         Disk and Permission Auditor                    "
echo "========================================================"
echo ""
printf "  %-20s %-25s %-10s\n" "Directory" "Permissions / Owner" "Size"
echo "  ------------------------------------------------------------"

for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        printf "  %-20s %-25s %-10s\n" "$DIR" "$PERMS" "$SIZE"
    else
        printf "  %-20s %s\n" "$DIR" "[does not exist on this system]"
    fi
done

echo ""
echo "--------------------------------------------------------"
echo "  GIT CONFIG DIRECTORY CHECK"
echo "--------------------------------------------------------"
echo ""

GIT_CONFIG_DIR="/etc/gitconfig"
GIT_SYSTEM_CONFIG=$(git config --system --list 2>/dev/null)

if [ -f "$GIT_CONFIG_DIR" ]; then
    echo "  System-wide Git config found at: $GIT_CONFIG_DIR"
    PERMS=$(ls -l "$GIT_CONFIG_DIR" | awk '{print $1, $3, $4}')
    echo "  Permissions : $PERMS"
    echo ""
    echo "  System-level Git settings:"
    git config --system --list 2>/dev/null | while IFS= read -r LINE; do
        echo "    $LINE"
    done
else
    echo "  No system-wide Git config found at $GIT_CONFIG_DIR"
    echo "  (This is normal — Git may only have user-level config)"
fi

echo ""

USER_GIT_CONFIG="$HOME/.gitconfig"
if [ -f "$USER_GIT_CONFIG" ]; then
    echo "  User Git config found at: $USER_GIT_CONFIG"
    PERMS=$(ls -l "$USER_GIT_CONFIG" | awk '{print $1, $3, $4}')
    echo "  Permissions : $PERMS"
    SIZE=$(du -sh "$USER_GIT_CONFIG" | cut -f1)
    echo "  Size        : $SIZE"
else
    echo "  No user Git config found at $USER_GIT_CONFIG"
    echo "  Run: git config --global user.name 'Your Name' to create it."
fi

echo ""
echo "========================================================"
