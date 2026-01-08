# Flutter MVVM Boilerplate - Analyze & Format (Windows PowerShell)
# Run these commands from the project root directory

Write-Host "🔍 Analyzing code..." -ForegroundColor Cyan
flutter analyze

Write-Host ""
Write-Host "✨ Formatting code..." -ForegroundColor Cyan
dart format lib test --set-exit-if-changed

Write-Host "✅ Analysis & formatting complete!" -ForegroundColor Green
