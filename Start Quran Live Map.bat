@echo off
title Quran Live Map
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "serve.ps1"
