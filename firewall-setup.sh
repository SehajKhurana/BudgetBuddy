#!/bin/bash

# Firewall Setup Script for BudgetBuddy Server

green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)
reset=$(tput sgr0)

# Check if script is running as root
if [[ $EUID -ne 0 ]]; then
   echo "${red}This script must be run as root! Use sudo.${reset}"
   exit 1
fi

echo "${yellow}Setting up the firewall...${reset}"

# Install UFW if not installed
if ! command -v ufw &> /dev/null; then
    echo "${yellow}UFW not found. Installing...${reset}"
    apt-get update && apt-get install -y ufw
fi

# Reset UFW to default settings
ufw --force reset

# Default deny all incoming, allow all outgoing
ufw default deny incoming
ufw default allow outgoing

# Allow SSH (port 22)
ufw allow 22/tcp comment "Allow SSH"

# Allow Docker internal communication (if needed)
ufw allow 2375/tcp comment "Allow Docker (insecure TCP, optional)"

# Enable the firewall
ufw --force enable

echo
ufw status verbose

echo "${green}Firewall configured and enabled successfully!${reset}"
