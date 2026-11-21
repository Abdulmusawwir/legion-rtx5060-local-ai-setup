@echo off
cd /d "%~dp0"

:MENU
cls
echo ========================================================
echo           llama.cpp Local Server Launcher
echo ========================================================
echo.
echo   [1] Qwen 3.5 9B  - Fast Coding (100%% VRAM, 64K ctx)
echo   [2] Qwen 3.6 35B - Deep Coding (GPU + RAM, 64K ctx)
echo   [3] Qwen 3.6 35B - Vision + Coding (GPU + RAM, 32K ctx)
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
echo Starting Qwen 3.5 9B (Coding, 64K Context) on RTX 5060...
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
echo Starting Qwen 3.6 35B-A3B (Coding, 64K Context) on RTX 5060 + 32GB RAM...
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
echo Starting Qwen 3.6 35B-A3B (Vision + Coding, 32K Context) on RTX 5060 + 32GB RAM...
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
