#!/bin/bash
# Script 2: FOSS Package Inspector
# Author: Yash Dalal | Reg No: 24BAI10153
# Course: Open Source Software | Capstone Project
# Purpose: Checks if a FOSS package is installed, shows its version/license,
#          and prints a philosophy note about it using a case statement

PACKAGE="git"

echo "========================================================"
echo "         FOSS Package Inspector                         "
echo "========================================================"
echo ""
echo "  Checking package: $PACKAGE"
echo ""

if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
    echo "  [INSTALLED] $PACKAGE is installed on this system."
    echo ""

    VERSION=$(dpkg -l "$PACKAGE" 2>/dev/null | grep "^ii" | awk '{print $3}')
    DESCRIPTION=$(dpkg -l "$PACKAGE" 2>/dev/null | grep "^ii" | awk '{$1=$2=$3=$4=""; print $0}' | sed 's/^ *//')

    echo "  Version     : $VERSION"
    echo "  Description : $DESCRIPTION"

    LICENSE_FILE=$(find /usr/share/doc/$PACKAGE -name "copyright" 2>/dev/null | head -1)
    if [ -n "$LICENSE_FILE" ]; then
        LICENSE_LINE=$(grep -m1 "License:" "$LICENSE_FILE" 2>/dev/null)
        if [ -n "$LICENSE_LINE" ]; then
            echo "  License     : $LICENSE_LINE"
        else
            echo "  License     : GPL v2 (see /usr/share/doc/$PACKAGE/copyright)"
        fi
    fi
else
    echo "  [NOT INSTALLED] $PACKAGE was not found on this system."
    echo ""
    echo "  To install it, run:"
    echo "    sudo apt update && sudo apt install $PACKAGE -y"
fi

echo ""
echo "--------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "--------------------------------------------------------"
echo ""

case $PACKAGE in
    git)
        echo "  Git: Born out of necessity when proprietary tools failed"
        echo "  the Linux community in 2005. Linus Torvalds wrote it in"
        echo "  10 days. Under GPL v2, it can never be taken away."
        ;;
    apache2 | httpd)
        echo "  Apache: The web server that built the open internet."
        echo "  It powered the first wave of websites and proved that"
        echo "  collaborative open-source could outperform proprietary tools."
        ;;
    mysql | mysql-server)
        echo "  MySQL: A dual-licensed database that shows the tension"
        echo "  between open-source ideals and commercial reality."
        echo "  Its GPL license keeps the community version free forever."
        ;;
    firefox)
        echo "  Firefox: A nonprofit's answer to browser monopoly."
        echo "  Built on the ruins of Netscape, it fights to keep"
        echo "  the web open and free from single-vendor control."
        ;;
    vlc)
        echo "  VLC: Written by students in Paris who just wanted"
        echo "  to watch video over their university network."
        echo "  Now it plays everything, everywhere, for free."
        ;;
    python3 | python)
        echo "  Python: A language shaped entirely by its community."
        echo "  Its PSF license is permissive by design — Guido wanted"
        echo "  maximum adoption over maximum control."
        ;;
    libreoffice)
        echo "  LibreOffice: A community fork that refused to let"
        echo "  OpenOffice die under corporate neglect. A real lesson"
        echo "  in what open-source governance should look like."
        ;;
    *)
        echo "  $PACKAGE: Every open-source project carries a story —"
        echo "  a problem someone cared enough to solve and share freely."
        echo "  Understanding that story is part of understanding the tool."
        ;;
esac

echo ""
echo "========================================================"
