#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Clear the screen for a clean start
clear

# Display the banner
echo -e "${CYAN}***************************************************${NC}"
figlet -f slant "Network Diagnostic Toolkit" 
echo -e "${CYAN}***************************************************${NC}"

# Creator Information
echo -e "${YELLOW}Created by ${RED}Team Web Coders${NC}"
echo -e "${CYAN}------------------------------------------------------------${NC}"

# Date and Time
echo -e "${GREEN}📅 Date: $(date +"%A, %d %B %Y")"
echo -e "⏰ Time: $(date +"%T")${NC}"

# System Information
echo -e "${CYAN}------------------------------------------------------------${NC}"
echo -e "${YELLOW}💻 Hostname: ${NC}$(hostname)"
echo -e "${YELLOW}🌐 IP Address: ${NC}$(hostname -I | awk '{print $1}')"
echo -e "${YELLOW}⚙️ OS: ${NC}$(lsb_release -d | cut -f2)"
echo -e "${YELLOW}💡 User: ${NC}$(whoami)"
echo -e "${CYAN}------------------------------------------------------------${NC}"

echo ""
echo -e "${GREEN}Your go-to toolkit for network diagnostics with powerful tools and features!${NC}"
echo ""
