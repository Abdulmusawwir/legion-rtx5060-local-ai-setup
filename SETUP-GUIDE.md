# Complete Setup Guide: Local AI Coding on Windows (Fresh Install)

This guide walks you through setting up a private, offline AI coding assistant on your laptop from scratch. No cloud subscriptions or API fees are required.

---

## My Specs Before Starting

- **Laptop:** Lenovo Legion (8GB RTX 5060 graphics card, AMD Ryzen 9 processor, 32GB system memory)
- **Free Disk Space:** At least 35 GB of free space on your main drive
- **Power:** Keep your laptop plugged into the charger and switch Lenovo Legion Toolkit to **Balanced** or **Performance** mode (press `Fn + Q`). Do not use Quiet mode, as it slows down your graphics card.

---

## Step 1: Download the AI Engine (`llama.cpp`)

`llama.cpp` is the program that runs AI models on your graphics card and memory.

1. Open your web browser and go to the official `llama.cpp` releases page on GitHub:
   `https://github.com/ggml-org/llama.cpp/releases`
2. Look at the latest release at the top and click **Assets** to expand the download list.
3. Find the Windows NVIDIA CUDA zip file (look for a name like `llama-bXXXX-bin-win-cuda-12.4-x64.zip` or `cuda-13.x`).
   - *Tip: If there is also a `cudart-llama-bin-win-cuda-...zip` file listed, download that too and extract its files into the same folder.*
4. Create a folder on your drive called `C:\llama-cpp` (or `D:\llama-cpp`).
5. Extract all files from the zip folder into `C:\llama-cpp`.
6. Inside `C:\llama-cpp`, create a new empty subfolder named `models`.

---

## Step 2: Download the Three AI Model Files

You only need three files inside your `models` folder. Two files are the AI brains, and one file lets the bigger AI read screenshots.

1. **Fast Everyday Coding Brain (~5.6 GB):**
   - Go to `https://huggingface.co/unsloth/Qwen3.5-9B-GGUF`
   - Click the **Files and versions** tab.
   - Download `Qwen3.5-9B-UD-Q4_K_XL.gguf`.
2. **Smart Deep-Thinking Coding Brain (~21.4 GB):**
   - Go to `https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF`
   - Click the **Files and versions** tab.
   - Download `Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf`.
3. **Screenshot Reader Add-on (~882 MB):**
   - On that same `Qwen3.6-35B-A3B-GGUF` page, download `mmproj-Qwen_Qwen3.6-35B-A3B-bf16.gguf`.
4. Move all three downloaded `.gguf` files into your `C:\llama-cpp\models` folder.

Your `models` folder should now contain only these three files:
- `Qwen3.5-9B-UD-Q4_K_XL.gguf`
- `Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf`
- `mmproj-Qwen_Qwen3.6-35B-A3B-bf16.gguf`

---

## Step 3: Create the Menu Launcher (`start_llm.bat`)

This file gives you a simple numbered menu so you can start or stop the AI server with one click.

1. Open **Notepad**.
2. Copy and paste the exact code below into Notepad:

```bat
@echo off
cd /d "%~dp0"

:MENU
cls
echo ========================================================
echo           llama.cpp Local Server Launcher
echo ========================================================
echo.
echo   [1] Qwen 3.5 9B  - Fast Coding (Graphics Card Only, 64K memory)
echo   [2] Qwen 3.6 35B - Deep Coding (Graphics Card + RAM, 64K memory)
echo   [3] Qwen 3.6 35B - Vision + Coding (Graphics Card + RAM, 32K memory)
echo   [4] Stop Running Server
echo   [5] Exit
echo.
set /p CHOICE="Select an option (1-5): "

if "%CHOICE%"=="1" goto RUN_9B_CODING
if "%CHOICE%"=="2" goto RUN_35B_CODING
if "%CHOICE%"=="3" goto RUN_35B_VISION
if "%CHOICE%"=="4" goto STOP_SERVER
if "%CHOICE%"=="5" exit /b
goto MENU

:RUN_9B_CODING
TITLE llama.cpp Server (Qwen3.5 9B - Coding)
taskkill /F /IM llama-server.exe >nul 2>&1
echo Starting Qwen 3.5 9B (Coding) on RTX 5060...
llama-server.exe ^
  -m ".\models\Qwen3.5-9B-UD-Q4_K_XL.gguf" ^
  --alias local-model,qwen3.5-9b ^
  --device CUDA0 ^
  -ngl 99 ^
  --no-reasoning-preserve ^
  -fa on ^
  -ctk q8_0 ^
  -ctv q8_0 ^
  -c 65536 ^
  -b 2048 ^
  -ub 512 ^
  -np 1 ^
  -t 16 ^
  --temp 0.6 ^
  --top-p 0.95 ^
  --top-k 20 ^
  --min-p 0.00 ^
  --jinja ^
  --port 8080 ^
  --host 127.0.0.1
pause
goto MENU

:RUN_35B_CODING
TITLE llama.cpp Server (Qwen3.6 35B-A3B - Coding)
taskkill /F /IM llama-server.exe >nul 2>&1
echo Starting Qwen 3.6 35B-A3B (Coding) on RTX 5060 + 32GB RAM...
llama-server.exe ^
  -m ".\models\Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf" ^
  --alias local-model,qwen3.6-35b-a3b ^
  --device CUDA0 ^
  -ngl 99 ^
  --cpu-moe ^
  --moe-cache-mib 1536 ^
  --load-mode none ^
  --no-reasoning-preserve ^
  -fa on ^
  -ctk q8_0 ^
  -ctv q8_0 ^
  -c 65536 ^
  -b 2048 ^
  -ub 512 ^
  -np 1 ^
  -t 16 ^
  --temp 0.6 ^
  --top-p 0.95 ^
  --top-k 20 ^
  --min-p 0.00 ^
  --jinja ^
  --port 8080 ^
  --host 127.0.0.1
pause
goto MENU

:RUN_35B_VISION
TITLE llama.cpp Server (Qwen3.6 35B-A3B - Vision)
taskkill /F /IM llama-server.exe >nul 2>&1
echo Starting Qwen 3.6 35B-A3B (Vision + Coding) on RTX 5060 + 32GB RAM...
llama-server.exe ^
  -m ".\models\Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf" ^
  --mmproj ".\models\mmproj-Qwen_Qwen3.6-35B-A3B-bf16.gguf" ^
  --alias local-model,qwen3.6-35b-a3b ^
  --device CUDA0 ^
  -ngl 99 ^
  --cpu-moe ^
  --moe-cache-mib 512 ^
  --load-mode none ^
  --no-reasoning-preserve ^
  -fa on ^
  -ctk q8_0 ^
  -ctv q8_0 ^
  -c 32768 ^
  -b 2048 ^
  -ub 512 ^
  -np 1 ^
  -t 16 ^
  --temp 0.6 ^
  --top-p 0.95 ^
  --top-k 20 ^
  --min-p 0.00 ^
  --jinja ^
  --port 8080 ^
  --host 127.0.0.1
pause
goto MENU

:STOP_SERVER
taskkill /F /IM llama-server.exe >nul 2>&1
echo llama-server stopped.
timeout /t 2 >nul
goto MENU
```

3. Click **File -> Save As**.
4. Navigate to your `C:\llama-cpp` folder (right next to `llama-server.exe`).
5. Change **Save as type** from `Text Documents (*.txt)` to **All Files (*.*)**.
6. Name the file `start_llm.bat` and click **Save**.

---

## Step 4: Install OpenCode

OpenCode is the terminal coding assistant that reads your project files and writes code using your local AI server.

1. Make sure **Node.js** is installed on your computer (download the LTS version from `https://nodejs.org` if needed).
2. Open **Windows Terminal** or **PowerShell**.
3. Run this command to install OpenCode globally:
   ```bash
   npm install -g opencode-ai
   ```
4. Verify it installed by typing `opencode --version`.

---

## Step 5: Connect OpenCode to Your Local AI (`opencode.jsonc`)

Now tell OpenCode where to find your local AI models.

1. Open File Explorer and go to `C:\Users\YOUR_USERNAME\.config\opencode\` (create the `.config` and `opencode` folders if they do not exist yet).
2. Open **Notepad**, paste the exact text below, and save it as `opencode.jsonc` (make sure **Save as type** is set to **All Files (*.*)** so Windows does not add `.txt` at the end):

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "model": "llamacpp/qwen3.6-35b-a3b",
  "small_model": "llamacpp/qwen3.5-9b",
  "permission": {
    "subagent": "deny",
    "task": "deny",
    "question": "deny"
  },
  "compaction": {
    "auto": true,
    "buffer": 2048
  },
  "provider": {
    "llamacpp": {
      "name": "llama.cpp Local",
      "npm": "@ai-sdk/openai-compatible",
      "options": {
        "baseURL": "http://localhost:8080/v1",
        "apiKey": "sk-local-key"
      },
      "models": {
        "qwen3.5-9b": {
          "modelID": "qwen3.5-9b",
          "name": "Qwen 3.5 9B (Fast VRAM)",
          "attachment": false,
          "reasoning": true,
          "tool_call": true,
          "limit": {
            "context": 65536,
            "output": 8192
          }
        },
        "qwen3.6-35b-a3b": {
          "modelID": "qwen3.6-35b-a3b",
          "name": "Qwen 3.6 35B A3B (MoE + Vision)",
          "attachment": true,
          "reasoning": true,
          "tool_call": true,
          "limit": {
            "context": 65536,
            "output": 16384
          }
        }
      }
    }
  }
}
```

---

## Step 6: Test Everything

1. Go to `C:\llama-cpp` and double-click `start_llm.bat`.
2. Type `2` and press **Enter** to load the 35B coding model.
3. Wait about 15 to 20 seconds until the black window prints:
   `server is listening on http://127.0.0.1:8080`
4. Open a second terminal window inside any of your coding project folders and type:
   ```bash
   opencode
   ```
5. Inside OpenCode, type `/models`, select **Qwen 3.6 35B A3B (MoE + Vision)**, and ask a question about your project.
6. Keep `local-llm-opencode-cheatsheet.md` handy for daily keyboard shortcuts and tips.
