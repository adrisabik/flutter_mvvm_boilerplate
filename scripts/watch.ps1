# Flutter MVVM Boilerplate - Watch Mode (Windows PowerShell)
# Run these commands from the project root directory

Write-Host "👀 Starting code generation in watch mode..." -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop" -ForegroundColor Yellow
dart run build_runner watch --delete-conflicting-outputs
