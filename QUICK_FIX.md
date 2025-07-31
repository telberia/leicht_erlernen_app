# 🚀 Quick Fix for PDF Loading

## Vấn đề:
- AssetManifest.json không tồn tại
- PDF không load được trên Web

## Giải pháp nhanh:

### 1. Chạy script fix:
```powershell
.\fix_pdf.ps1
```

### 2. Hoặc chạy từng lệnh:
```bash
flutter clean
flutter pub get
flutter build web --web-renderer html
flutter run -d chrome
```

### 3. Kiểm tra assets:
Đảm bảo file PDF tồn tại tại:
```
assets/App-data/Lektion_1/vt1_eBook_Lektion_1.pdf
```

### 4. Nếu vẫn lỗi:
- Kiểm tra console logs
- Đảm bảo PDF files có trong thư mục assets
- Thử chạy trên Android/iOS thay vì Web

## Kết quả mong đợi:
- PDF load thành công
- Không còn lỗi AssetManifest
- App hoạt động trên Web, iOS, Android 