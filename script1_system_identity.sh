#!/bin/bash
# Script 1: System Identity Report
# Author: Yash Dalal | Reg No: 24BAI10153
# Course: Open Source Software | Capstone Project
# Purpose: Displays a welcome screen with system info and open-source license details

STUDENT_NAME="Yash Dalal"
REG_NO="24BAI10153"
SOFTWARE_CHOICE="Git"

KERNEL=$(uname -r)
USER_NAME=$(whoami)
HOME_DIR=$HOME
UPTIME=$(uptime -p)
CURRENT_DATE=$(date '+%A, %d %B %Y %H:%M:%S')

DISTRO=$(lsb_release -d 2>/dev/null | cut -f2)
if [ -z "$DISTRO" ]; then
    DISTRO=$(cat /etc/os-release 2>/dev/null | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')
fi
if [ -z "$DISTRO" ]; then
    DISTRO="Unknown Linux Distribution"
fi

OS_LICENSE="GNU General Public License v2 (GPL v2)"

echo "========================================================"
echo "        Open Source Audit — System Identity Report      "
echo "========================================================"
echo ""
echo "  Student  : $STUDENT_NAME ($REG_NO)"
echo "  Software : $SOFTWARE_CHOICE"
echo ""
echo "--------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "--------------------------------------------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  User         : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date & Time  : $CURRENT_DATE"
echo ""
echo "--------------------------------------------------------"
echo "  OPEN SOURCE LICENSE"
echo "--------------------------------------------------------"
echo "  This operating system (Linux) is covered under:"
echo "  $OS_LICENSE"
echo ""
echo "  The Linux kernel was created by Linus Torvalds in 1991"
echo "  and is maintained by thousands of contributors worldwide."
echo "  You are free to use, study, modify, and distribute it."
echo "========================================================"
