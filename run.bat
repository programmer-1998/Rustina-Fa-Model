@echo off
REM ==============================================================================
REM Rustina V1 Fa - Instant Runner for Windows
REM Developer: Sina Khanzadeh (https://sina-khanzadeh.ir)
REM ==============================================================================

set MODEL_FILE=Rustina-V1-Fa-Q4_K_M.gguf
set ENGINE_BIN=rust-llama.exe

echo ==========================================================
echo       [Rustina V1 Fa] Persian Expert AI Model             
echo ==========================================================

if not exist "%MODEL_FILE%" (
    echo [ERROR] Model file '%MODEL_FILE%' not found!
    echo Please download it from Google Drive / Releases and put it in this folder.
    echo Link: https://github.com/programmer-1998/Rustina-Fa-Model
    pause
    exit /b 1
)

if not exist "%ENGINE_BIN%" (
    echo [INFO] Downloading lightweight rust-llama.exe engine...
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/RustinaCo/llama.rs/releases/latest/download/rust-llama-windows-x86_64.exe' -OutFile '%ENGINE_BIN%'"
)

echo Starting Persian AI interactive session...
echo Type /clear to reset history, Ctrl+C to exit.
echo ----------------------------------------------------------

"%ENGINE_BIN%" run "%MODEL_FILE%" -i --temp 0.4 -n 128 %*
pause
