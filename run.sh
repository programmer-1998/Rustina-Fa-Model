#!/usr/bin/env bash
# ==============================================================================
# Rustina V1 Fa - Instant Runner
# Developer: Sina Khanzadeh (https://sina-khanzadeh.ir)
# ==============================================================================
set -e

MODEL_FILE="Rustina-V1-Fa-Q4_K_M.gguf"
ENGINE_BIN="./rust-llama"
ENGINE_URL="https://github.com/RustinaCo/llama.rs/releases/latest/download/rust-llama-linux-x86_64"

echo "=========================================================="
echo "      🚀 Rustina V1 Fa (Persian Expert AI Model)          "
echo "=========================================================="

# 1. Check if model exists
if [ ! -f "$MODEL_FILE" ]; then
    echo "❌ Error: Model file '$MODEL_FILE' not found in this directory!"
    echo "📥 Please download it from Google Drive or GitHub Releases and place it here."
    echo "🔗 Download link: https://github.com/programmer-1998/Rustina-Fa-Model#download"
    exit 1
fi

# 2. Check or download rust-llama engine
if [ ! -f "$ENGINE_BIN" ]; then
    # Check if installed system-wide
    if command -v rust-llama >/dev/null 2>&1; then
        ENGINE_BIN="rust-llama"
    else
        echo "⚡ Downloading lightweight inference engine (rust-llama, ~1MB)..."
        if command -v curl >/dev/null 2>&1; then
            curl -L -o "$ENGINE_BIN" "$ENGINE_URL" || true
        elif command -v wget >/dev/null 2>&1; then
            wget -O "$ENGINE_BIN" "$ENGINE_URL" || true
        fi
        
        if [ -f "$ENGINE_BIN" ] && [ -s "$ENGINE_BIN" ]; then
            chmod +x "$ENGINE_BIN"
            echo "✅ Engine ready!"
        else
            echo "⚠️ Could not auto-download binary. If you have rust-llama built, place it here as './rust-llama'."
            exit 1
        fi
    fi
fi

echo "✨ Starting interactive Persian chat (Multi-turn memory enabled)..."
echo "💡 Commands inside chat: /clear (reset conversation), /save <info> (persistent memory), Ctrl-D (exit)"
echo "----------------------------------------------------------"

exec "$ENGINE_BIN" run "$MODEL_FILE" -i --temp 0.4 -n 128 "$@"
