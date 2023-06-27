#!/bin/bash

# Define color variables
RED="\e[31m"
YELLOW="\e[33m"
PURPLE="\e[35m"
NC="\e[0m" # No Color

# Function to print with two colors
print_with_colors() {
    label=$1
    value=$2
    echo -ne "${RED}$label${NC}"
    echo -ne "${YELLOW}$value${NC}"
    echo
}

# Function to get the package manager
get_package_manager() {
    if which apt >/dev/null; then
        echo "apt"
    elif which pacman >/dev/null; then
        echo "pacman"
    elif which nix-store >/dev/null; then
        echo "nix"
    else
        echo "unknown"
    fi
}

# Function to get the number of installed packages
get_packages() {
    case $(get_package_manager) in
    "apt")
        dpkg-query -f '.\n' -W | wc -l
        ;;
    "pacman")
        pacman -Q | wc -l
        ;;
    "nix")
        nix-store --query --requisites /run/current-system/sw | wc -l
        ;;
    *)
        echo "unknown"
        ;;
    esac
}

# Function to get the weather information
get_weather() {
    curl -s "https://wttr.in/?format=3"
}

# Fetch system information
CURRENT_USER=$(whoami)
UPTIME=$(uptime -p)
HOSTNAME=$(hostname)
NUM_CORES=$(nproc)
PACKAGE_MANAGER=$(get_package_manager)
NUM_PACKAGES=$(get_packages)
WEATHER=$(get_weather)

# Display the information
print_with_colors "Hey, " "$CURRENT_USER"
print_with_colors "Hostname: " "$HOSTNAME"
print_with_colors "Uptime: " "$UPTIME"
print_with_colors "Number of Cores: " "$NUM_CORES"
echo -ne "${RED}Number of Installed Packages: ${NC}"
echo -ne "${YELLOW}${NUM_PACKAGES}${NC} "
echo -ne "${PURPLE}(${PACKAGE_MANAGER})${NC}\n"
echo "-"
echo -ne "${PURPLE}$WEATHER${NC}\n"
echo "---"
