#!/bin/bash
# Script 4: Log File Analyzer
# Author: Yash Dalal | Reg No: 24BAI10153
# Course: Open Source Software | Capstone Project
# Purpose: Reads a log file line by line, counts keyword occurrences,
#          and prints a summary with the last 5 matching lines.
# Usage: ./script4_log_analyzer.sh <logfile> [keyword]
# Example: ./script4_log_analyzer.sh /var/log/syslog error

LOGFILE=$1
KEYWORD=${2:-"error"}

echo "========================================================"
echo "         Log File Analyzer                              "
echo "========================================================"
echo ""

if [ -z "$LOGFILE" ]; then
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo ""

    echo "  No log file provided. Searching for an available log file..."
    for TRY_LOG in /var/log/syslog /var/log/auth.log /var/log/kern.log /var/log/dpkg.log; do
        if [ -f "$TRY_LOG" ]; then
            LOGFILE="$TRY_LOG"
            echo "  Using: $LOGFILE"
            break
        fi
    done

    if [ -z "$LOGFILE" ]; then
        echo "  No readable log file found. Exiting."
        exit 1
    fi
fi

MAX_RETRIES=3
RETRY=0

while [ ! -f "$LOGFILE" ] && [ $RETRY -lt $MAX_RETRIES ]; do
    RETRY=$((RETRY + 1))
    echo "  Attempt $RETRY/$MAX_RETRIES: File '$LOGFILE' not found. Retrying in 2 seconds..."
    sleep 2
done

if [ ! -f "$LOGFILE" ]; then
    echo "  Error: File '$LOGFILE' not found after $MAX_RETRIES attempts. Exiting."
    exit 1
fi

if [ ! -s "$LOGFILE" ]; then
    echo "  Warning: File '$LOGFILE' exists but is empty."
    echo "  Nothing to analyze."
    exit 0
fi

echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD'"
echo "  Scanning..."
echo ""

COUNT=0

while IFS= read -r LINE; do
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))
    fi
done < "$LOGFILE"

TOTAL_LINES=$(wc -l < "$LOGFILE")

echo "--------------------------------------------------------"
echo "  SUMMARY"
echo "--------------------------------------------------------"
echo "  Total lines in file  : $TOTAL_LINES"
echo "  Lines matching '$KEYWORD' : $COUNT"

if [ $TOTAL_LINES -gt 0 ]; then
    PERCENT=$(( (COUNT * 100) / TOTAL_LINES ))
    echo "  Match percentage     : $PERCENT%"
fi

echo ""
echo "--------------------------------------------------------"
echo "  LAST 5 MATCHING LINES"
echo "--------------------------------------------------------"
echo ""

MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" | tail -5)

if [ -n "$MATCHES" ]; then
    echo "$MATCHES" | while IFS= read -r LINE; do
        echo "  >> $LINE"
    done
else
    echo "  No matches found for '$KEYWORD' in $LOGFILE"
fi

echo ""
echo "========================================================"
