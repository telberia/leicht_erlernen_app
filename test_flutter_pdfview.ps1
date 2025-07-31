# Test with flutter_pdfview
Write-Host "📄 Testing with flutter_pdfview..." -ForegroundColor Green

# Clean and get dependencies
Write-Host "🧹 Cleaning..." -ForegroundColor Yellow
flutter clean

Write-Host "📦 Getting dependencies..." -ForegroundColor Yellow
flutter pub get

# Run on Chrome
Write-Host "🚀 Starting app with flutter_pdfview..." -ForegroundColor Green
flutter run -d chrome

Write-Host "✅ App should work with flutter_pdfview!" -ForegroundColor Green 