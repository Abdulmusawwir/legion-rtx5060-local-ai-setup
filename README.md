# Local AI Coding Setup (Lenovo Legion RTX 5060 + OpenCode)

This repository contains my personal setup guide, launcher script, and daily cheat sheet for running local AI coding assistants completely offline on a Windows laptop (8GB RTX 5060 GPU, AMD Ryzen 9, 32GB RAM).

## What Is Inside This Repository

- `SETUP-GUIDE.md` - Step-by-step instructions from a fresh Windows install to a working local AI coding setup.
- `local-llm-opencode-cheatsheet.md` - Quick daily reference for switching models, OpenCode keyboard shortcuts, and fixing common hiccups.
- `start_llm.bat` - One-click menu launcher to start or stop the local AI server.
- `opencode.jsonc` - Ready-to-use OpenCode configuration file that connects OpenCode to the local AI server.

## Quick Start (After Formatting Windows)

1. Open `SETUP-GUIDE.md` and follow Steps 1 through 6 in order.
2. Copy `start_llm.bat` into your `llama.cpp` folder.
3. Copy `opencode.jsonc` into your OpenCode configuration folder (`C:\Users\YOUR_USERNAME\.config\opencode\opencode.jsonc`).
4. Double-click `start_llm.bat`, pick Option 1 or Option 2, and open your project in OpenCode.

## Files Included

| File | Purpose |
| :--- | :--- |
| `SETUP-GUIDE.md` | Full beginner-friendly setup guide from scratch |
| `local-llm-opencode-cheatsheet.md` | Daily commands, shortcuts, and troubleshooting |
| `start_llm.bat` | Windows launcher menu for 9B, 35B, and 35B Vision |
| `opencode.jsonc` | OpenCode settings file |
