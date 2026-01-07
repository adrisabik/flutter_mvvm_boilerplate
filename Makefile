.PHONY: gen watch clean pub

# Run build_runner to generate code
gen:
	flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes and regenerate
watch:
	flutter pub run build_runner watch --delete-conflicting-outputs

# Clean generated files
clean:
	flutter pub run build_runner clean
	flutter clean

# Get dependencies
pub:
	flutter pub get

# Analyze code
analyze:
	flutter analyze

# Run tests
test:
	flutter test

# Format code
format:
	dart format lib test

# Check formatting
format-check:
	dart format --set-exit-if-changed lib test

# Run all checks (format, analyze, test)
check: format-check analyze test
