#!/bin/bash
cd "$(dirname "$0")"
echo "============================================"
echo "  BotTrader (Trend + Daily) - instalacija (macOS)"
echo "============================================"
if ! command -v python3 >/dev/null 2>&1; then
    echo "[GRESKA] Instaliraj Python3 od https://www.python.org/downloads/macos/"
    exit 1
fi
echo "[1/2] Python3 e OK"
echo "[2/2] Instaliram paketi..."
python3 -m pip install --quiet --upgrade pip 2>/dev/null || true
python3 -m pip install --quiet --user requests telethon qrcode || pip3 install --quiet requests telethon qrcode
echo
echo "============================================"
echo "  Gotovo! Sega pokreni: 2-start-macos.command"
echo "============================================"
