# Flutter MVVM Boilerplate - Build Script (Windows PowerShell)
# Run these commands from the project root directory

param(
    [Parameter()]
    [ValidateSet("dev", "staging", "prod")]
    [string]$Flavor = "prod",

    [Parameter()]
    [ValidateSet("apk", "appbundle", "ios", "web")]
    [string]$Target = "apk"
)

Write-Host "[LOG] Building $Target with $Flavor flavor..." -ForegroundColor Cyan

switch ($Target) {
    "apk" {
        flutter build apk --release --dart-define=FLAVOR=$Flavor
    }
    "appbundle" {
        flutter build appbundle --release --dart-define=FLAVOR=$Flavor
    }
    "ios" {
        flutter build ios --release --dart-define=FLAVOR=$Flavor
    }
    "web" {
        flutter build web --release --dart-define=FLAVOR=$Flavor
    }
}

Write-Host "[SUCCESS] Build complete!" -ForegroundColor Green
