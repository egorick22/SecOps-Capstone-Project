#!/bin/bash
LOGFILE="/var/log/clamav/clamav_scan_$(date +%Y%m%d_%H%M%S).log"
SCAN_DIR="/"

echo "=== ClamAV Full System Scan ===" | tee -a $LOGFILE
echo "Started at: $(date)" | tee -a $LOGFILE

clamscan -r --infected --recursive --log=$LOGFILE $SCAN_DIR 2>/dev/null

INFECTED=$(grep -c "FOUND" $LOGFILE)

if [ $INFECTED -gt 0 ]; then
  echo "WARNING: Found $INFECTED infected files!" | tee -a $LOGFILE
  exit 1
fi
exit 0
