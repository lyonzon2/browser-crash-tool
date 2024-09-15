# Browser Crash Tool - Kali

## Overview

This tool exploits a vulnerability in iOS WebKit (CVE-2020-27950) using Metasploit’s `webkit_backdrop_filter_blur` auxiliary module. But seems it work on all browsers after some testing ,It crashes the target browser by loading a crafted web page. The tool also uses `ngrok` to create a publicly accessible link to the malicious page, making it easy to send to a target.

https://github.com/user-attachments/assets/1eb73bec-cc79-4f0a-8859-70e4a4d7db5a

## Requirements

- Kali Linux
- Metasploit Framework
- ngrok (for creating public URLs)

## Features

- Automatically configures Metasploit and runs the WebKit DoS exploit.
- Integrates with `ngrok` to generate a public URL for easy access.
- Checks for `ngrok` installation and handles exceptions gracefully.
- User-friendly with informative messages and error handling.

## Installation

1. **Install Metasploit**: If Metasploit is not installed, you can install it with:
   ```bash
   sudo apt install metasploit-framework```
2. **Install Ngrok**: If ngrok is not installed, you can install it with:
   ```bash
   sudo apt install ngrok```

3. **Authenticate Ngrok using your token**:
   - Sign up for a free Ngrok account on the [Ngrok website](https://ngrok.com).
   - Obtain your authentication token from the Ngrok Dashboard.
   - Authenticate Ngrok with the following command:
     ```bash
     ngrok authtoken YOUR_AUTH_TOKEN
     ```
     Replace `YOUR_AUTH_TOKEN` with the token you obtained from the Ngrok Dashboard.
