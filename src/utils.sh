#!/bin/bash

# ==============================
#  Utility Functions
# ==============================

# Colors for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Ensure logs directory exists
LOG_DIR="../logs"
mkdir -p $LOG_DIR

# Check if the log file exists, and create it if not
LOG_FILE="$LOG_DIR/toolkit.log"
if [ ! -f $LOG_FILE ]; then
    touch $LOG_FILE
fi

# Check write permission for logs
if [ ! -w $LOG_FILE ]; then
    echo -e "${RED}❌ Error: No write permission for $LOG_FILE.${NC}"
    echo -e "${CYAN}💡 Try running with sudo or adjust permissions with:${NC}"
    echo -e "${YELLOW}sudo chmod 666 $LOG_FILE${NC}"
    exit 1
fi

# Log rotation (if log exceeds 5MB, archive and create a new one)
MAX_LOG_SIZE=5242880  # 5MB
if [ $(stat -c%s "$LOG_FILE") -gt $MAX_LOG_SIZE ]; then
    TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
    mv $LOG_FILE "$LOG_DIR/toolkit_$TIMESTAMP.log"
    touch $LOG_FILE
    echo -e "${YELLOW}🌀 Log rotated. Old log archived as toolkit_$TIMESTAMP.log${NC}"
fi

# ==============================
#  Functions
# ==============================

# Logger Function
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') | $1" | tee -a $LOG_FILE
}

# Error Handler
error() {
    echo -e "${RED}❌ Error: $1${NC}"
    log "ERROR: $1"
}

# Success Message
success() {
    echo -e "${GREEN}✅ $1${NC}"
    log "SUCCESS: $1"
}

# Information Message
info() {
    echo -e "${CYAN}ℹ️ $1${NC}"
    log "INFO: $1"
}

