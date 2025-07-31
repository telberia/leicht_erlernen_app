# Fix PDF Loading Issue - Leicht Erlernen App
Write-Host "🔧 Fixing PDF loading issue..." -ForegroundColor Green

# Clean everything
Write-Host "🧹 Cleaning project..." -ForegroundColor Yellow
flutter clean

# Get dependencies
Write-Host "📦 Getting dependencies..." -ForegroundColor Yellow
flutter pub get

# Build web to ensure assets are bundled
Write-Host "🌐 Building web assets..." -ForegroundColor Yellow
flutter build web --web-renderer html

# Run on Chrome
Write-Host "🚀 Starting app on Chrome..." -ForegroundColor Green
flutter run -d chrome

Write-Host "✅ Done! Check if PDF loads now." -ForegroundColor Green 