# Fix Web Compatibility
Write-Host "🌐 Fixing Web Compatibility..." -ForegroundColor Green

# Clean everything
Write-Host "🧹 Cleaning project..." -ForegroundColor Yellow
flutter clean

# Get dependencies
Write-Host "📦 Getting dependencies..." -ForegroundColor Yellow
flutter pub get

# Build web to check compatibility
Write-Host "🌐 Building web..." -ForegroundColor Yellow
flutter build web --web-renderer html

# Run on Chrome
Write-Host "🚀 Starting app on Chrome..." -ForegroundColor Green
flutter run -d chrome

Write-Host "✅ Web should work now!" -ForegroundColor Green 