#!/bin/bash
set -e

echo "[+] Pulling latest code from GitHub..."
git pull origin main

echo "[+] Building Docker image..."
docker compose build

echo "[+] Restarting container..."
docker compose up -d

echo "[+] Deployment complete."