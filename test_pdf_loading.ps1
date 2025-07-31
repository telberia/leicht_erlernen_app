# Test PDF Loading - Leicht Erlernen App
Write-Host "🧪 Testing PDF loading..." -ForegroundColor Green

# Check if PDF file exists
$pdfPath = "assets/App-data/Lektion_1/vt1_eBook_Lektion_1.pdf"
if (Test-Path $pdfPath) {
    Write-Host "✅ PDF file exists: $pdfPath" -ForegroundColor Green
    $fileSize = (Get-Item $pdfPath).Length
    Write-Host "📄 File size: $([math]::Round($fileSize/1MB, 2)) MB" -ForegroundColor Yellow
} else {
    Write-Host "❌ PDF file NOT found: $pdfPath" -ForegroundColor Red
    exit 1
}

# Clean and rebuild
Write-Host "🧹 Cleaning project..." -ForegroundColor Yellow
flutter clean

Write-Host "📦 Getting dependencies..." -ForegroundColor Yellow
flutter pub get

# Build for web specifically
Write-Host "🌐 Building web assets..." -ForegroundColor Yellow
flutter build web --web-renderer html --release

# Check if build was successful
if (Test-Path "build/web") {
    Write-Host "✅ Web build successful" -ForegroundColor Green
    
    # Check if assets are in build
    $buildAssetsPath = "build/web/assets/App-data/Lektion_1/vt1_eBook_Lektion_1.pdf"
    if (Test-Path $buildAssetsPath) {
        Write-Host "✅ PDF found in build: $buildAssetsPath" -ForegroundColor Green
    } else {
        Write-Host "❌ PDF NOT found in build: $buildAssetsPath" -ForegroundColor Red
    }
} else {
    Write-Host "❌ Web build failed" -ForegroundColor Red
}

Write-Host "🚀 Starting test app..." -ForegroundColor Green
flutter run -d chrome --web-port 8080

Write-Host "✅ Test complete! Check browser at http://localhost:8080" -ForegroundColor Green 