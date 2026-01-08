# Flutter MVVM Boilerplate - Run Tests (Windows PowerShell)
# Run these commands from the project root directory

param(
    [Parameter()]
    [switch]$Coverage,

    [Parameter()]
    [string]$Path = ""
)

if ($Coverage) {
    Write-Host "[LOG] Running tests with coverage..." -ForegroundColor Cyan
    flutter test --coverage $Path
    Write-Host "[SUCCESS] Coverage report generated at coverage/lcov.info" -ForegroundColor Green
} else {
    Write-Host "[LOG] Running tests..." -ForegroundColor Cyan
    if ($Path) {
        flutter test $Path
    } else {
        flutter test
    }
}

Write-Host "[SUCCESS] Tests complete!" -ForegroundColor Green
