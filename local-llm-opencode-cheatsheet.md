# Daily Local LLM + OpenCode Cheat Sheet

Quick reference for running local AI coding models on your Lenovo Legion laptop (8GB RTX 5060 + 32GB RAM).

---

## 1. Before You Start

- **Charger & Power Mode (`Fn + Q`):** Keep the laptop plugged in and set Lenovo Legion Toolkit to **Balanced** or **Performance**. Never use Quiet mode while coding with local AI.
- **Free Up Memory:** Before starting a **35B** model, close heavy browser tabs or extra apps so Windows has enough free system memory.

---

## 2. Server Menu (`start_llm.bat`)

Double-click `start_llm.bat` and pick a number. Wait until the window prints `listening on http://127.0.0.1:8080` before sending messages in OpenCode.

| Option | Model | Speed | Memory Size | Best Use Case |
| :--- | :--- | :--- | :--- | :--- |
| **1** | **Qwen 3.5 9B** (Coding) | Very Fast (~53 words/sec) | 64K | Quick edits, single files, heavy multitasking |
| **2** | **Qwen 3.6 35B** (Coding) | Steady (~24 words/sec) | 64K | Complex bugs, multi-file edits, architecture |
| **3** | **Qwen 3.6 35B** (Vision) | Steady (~24 words/sec) | 32K | Pasting UI screenshots or terminal error images |
| **4** | **Stop Server** | Stops AI | Frees all RAM | Run this when finished coding or before gaming |

---

## 3. Essential OpenCode Shortcuts

- **`Tab` (Switch Plan vs. Build Mode):**
  - **Plan Mode (Safe / Read-Only):** The AI can read files and suggest code, but cannot modify anything on your disk.
  - **Build Mode (Edit Files):** The AI can edit your code and run tests.
- **`/models`:** Type this in the chat box to switch OpenCode between `Qwen 3.5 9B` and `Qwen 3.6 35B A3B` after changing options in `start_llm.bat`.
- **`+` or `Ctrl + N` (New Chat):** Always start a fresh chat when moving to a new task so the AI starts with an empty memory bar.
- **`@filename`:** Type `@` followed by a file name (for example, `@app/page.tsx`) so the AI reads only that file instead of scanning your whole folder.

---

## 4. Quick Fixes for Common Issues

| Problem | Why It Happens | Easy Fix |
| :--- | :--- | :--- |
| **`ETIMEDOUT` error in OpenCode** | The 35B model is still loading into memory | Wait 15 to 20 seconds until `llama-server` says `listening on http://127.0.0.1:8080`, then retry |
| **OpenCode keeps saying `Compacted`** | The chat history got too long | Start a fresh chat (`+`) and use `@filename` instead of asking it to scan every folder |
| **Replies suddenly crawl (<5 words/sec)** | Graphics card memory overflowed | Press `4` in `start_llm.bat` to stop the server, close heavy apps, and start again |
| **AI refuses to edit files** | OpenCode is still in `Plan` mode | Press `Tab` so the bottom-left badge says `Build` |
