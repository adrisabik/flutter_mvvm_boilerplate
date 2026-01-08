# Flutter MVVM Boilerplate - Build Scripts (Windows PowerShell)
# Run these commands from the project root directory

# Generate code (freezed, json_serializable, injectable)
Write-Host "🔧 Generating code..." -ForegroundColor Cyan
dart run build_runner build --delete-conflicting-outputs
Write-Host "✅ Code generation complete!" -ForegroundColor Green
