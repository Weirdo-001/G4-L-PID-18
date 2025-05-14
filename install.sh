#!/bin/bash

# ==============================
#  Network Diagnostic Toolkit
#       Installation Script
# ==============================

# Colors for pretty output
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}🔧 Installing dependencies...${NC}"

# Dependencies List
DEPENDENCIES=(
    nmap
    tcpdump
    traceroute
    curl
    dnsutils
    figlet
    dialog
)

# Loop through dependencies and install if missing
for package in "${DEPENDENCIES[@]}"; do
    if dpkg -s "$package" >/dev/null 2>&1; then
        echo -e "${GREEN}✅ $package is already installed.${NC}"
    else
        echo -e "${CYAN}➕ Installing $package...${NC}"
        sudo apt-get install -y "$package"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ $package installed successfully.${NC}"
        else
            echo -e "${RED}❌ Failed to install $package. Please check your internet connection or package name.${NC}"
            exit 1
        fi
    fi
done

echo -e "${CYAN}🔐 Setting executable permissions...${NC}"

# Permissions
chmod +x src/*.sh
chmod +x src/main.sh

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Permissions set.${NC}"
else
    echo -e "${RED}❌ Failed to set permissions. Try running with sudo.${NC}"
    exit 1
fi

# Final Success Message
echo -e "${GREEN}🚀 Installation Complete!${NC}"
echo -e "${CYAN}To run the toolkit, execute: ${GREEN}./src/main.sh${NC}"
