# Flutter MVVM Boilerplate - Run App (Windows PowerShell)
# Run these commands from the project root directory

param(
    [Parameter()]
    [ValidateSet("dev", "staging", "prod")]
    [string]$Flavor = "dev"
)

Write-Host "🚀 Running app with $Flavor flavor..." -ForegroundColor Cyan
flutter run --dart-define=FLAVOR=$Flavor
