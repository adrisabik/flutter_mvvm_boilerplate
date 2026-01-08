# Flutter MVVM Boilerplate - Clean Project (Windows PowerShell)
# Run these commands from the project root directory

Write-Host "[LOG] Cleaning project..." -ForegroundColor Cyan

flutter clean
Write-Host "Deleted build artifacts"

flutter pub get
Write-Host "Reinstalled dependencies"

Write-Host "[LOG] Regenerating code..." -ForegroundColor Cyan
dart run build_runner build --delete-conflicting-outputs

Write-Host "[SUCCESS] Clean complete!" -ForegroundColor Green
