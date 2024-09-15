# Browser Crash Tool - Kali

## Overview

This tool exploits a vulnerability in iOS WebKit (CVE-2020-27950) using Metasploit’s `webkit_backdrop_filter_blur` auxiliary module. It crashes the target browser by loading a crafted web page. The tool also uses `ngrok` to create a publicly accessible link to the malicious page, making it easy to send to a target.

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
   sudo apt install metasploit-framework
