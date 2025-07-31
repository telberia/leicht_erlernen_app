# PDF Loading Troubleshooting Guide

## 🔍 Vấn đề: "PDF load failed: Error" hoặc "unable to find directory entry in pubspec.yaml"

### Nguyên nhân có thể:

1. **Assets không được khai báo đúng trong pubspec.yaml**
2. **Tên file PDF không khớp với code**
3. **Thư mục assets chưa được đổi tên**
4. **Flutter cache cần được clear**
5. **Thư mục không tồn tại trong cấu trúc thực tế**
6. **Đường dẫn assets bị trùng lặp (assets/assets/...)**
7. **URL encoding issues trong Flutter Web**

### 🔧 Các bước khắc phục:

#### Bước 1: Kiểm tra cấu trúc thư mục
```
assets/App-data/
├── Lektion 1/
│   ├── Tabellen/
│   ├── Hörtexte/          ← Cần đổi thành Hoertexte
│   ├── Übungsaudios/      ← Cần đổi thành Uebungsaudios
│   └── vt1_eBook_Lektion_1.pdf
└── ...
```

#### Bước 2: Đổi tên thư mục (nếu chưa làm)
Chạy script PowerShell:
```powershell
powershell -ExecutionPolicy Bypass -File rename_folders.ps1
```

Hoặc đổi tên thủ công:
- `Hörtexte` → `Hoertexte`
- `Übungsaudios` → `Uebungsaudios`

#### Bước 3: Clear Flutter cache
```bash
flutter clean
flutter pub get
```

#### Bước 4: Kiểm tra pubspec.yaml (ĐÃ ĐƯỢC SỬA)
pubspec.yaml hiện tại chỉ khai báo thư mục gốc:
```yaml
flutter:
  assets:
    - assets/App-data/
```

**Lưu ý quan trọng**: Không khai báo chi tiết từng file để tránh lỗi đường dẫn trùng lặp.

#### Bước 5: Kiểm tra đường dẫn trong code
AssetsService sử dụng đường dẫn không có prefix 'assets/':
```dart
static const String _basePath = 'App-data'; // Không phải 'assets/App-data'
```

#### Bước 6: Xử lý URL encoding cho Flutter Web
AssetsService đã được cập nhật để xử lý URL encoding:
```dart
// Tự động thử các format encoding khác nhau cho web
'App-data/Lektion 1/vt1_eBook_Lektion_1.pdf'
'App-data/Lektion%201/vt1_eBook_Lektion_1.pdf'
'App-data/Lektion%25201/vt1_eBook_Lektion_1.pdf'
```

#### Bước 7: Test PDF loading
Chạy test script:
```bash
dart test_web_paths.dart
```

#### Bước 8: Debug trong app
1. Mở app
2. Chọn một bài học
3. Click "eBook"
4. Click icon bug (🐛) để xem debug info

### 📋 Checklist khắc phục:

- [ ] Thư mục đã được đổi tên (Hörtexte → Hoertexte, Übungsaudios → Uebungsaudios)
- [ ] pubspec.yaml chỉ khai báo `- assets/App-data/`
- [ ] AssetsService sử dụng `App-data` thay vì `assets/App-data`
- [ ] Đã chạy `flutter clean` và `flutter pub get`
- [ ] PDF file tồn tại trong thư mục assets
- [ ] Tên file PDF khớp với pattern: `vt1_eBook_Lektion_X.pdf`
- [ ] URL encoding được xử lý cho Flutter Web

### 🐛 Debug Information

App có tính năng debug built-in:
1. Click icon bug (🐛) trong AppBar
2. Xem debug log để biết:
   - Các đường dẫn PDF được kiểm tra (bao gồm URL encoding)
   - Trạng thái từng file PDF (✅/❌)
   - Trạng thái các thư mục (✅/❌)
   - Lỗi cụ thể nếu có
   - Trạng thái loading

### 📞 Nếu vẫn gặp lỗi:

1. **Kiểm tra console output** khi chạy app
2. **Xem debug info** trong app (icon 🐛)
3. **Kiểm tra file size** của PDF (quá lớn có thể gây lỗi)
4. **Thử với PDF khác** để xác định vấn đề
5. **Chạy test_web_paths.dart** để kiểm tra URL encoding

### 🔄 Fallback Content

Nếu PDF không load được, app sẽ hiển thị:
- Error message với retry button
- Fallback content cho bài học
- Debug information để troubleshoot

### ✅ Đã sửa:

- **Simplified pubspec.yaml**: Chỉ khai báo thư mục gốc
- **Fixed asset paths**: Loại bỏ prefix 'assets/' trong code
- **Enhanced debug info**: Hiển thị trạng thái từng file PDF
- **Better error handling**: Xử lý thư mục không tồn tại
- **Directory checking**: Kiểm tra cấu trúc thực tế
- **PDF file checking**: Kiểm tra từng file PDF cụ thể
- **URL encoding support**: Xử lý encoding issues trong Flutter Web

### 📄 PDF File Patterns:

App tìm PDF theo thứ tự:
1. `App-data/Lektion X/vt1_eBook_Lektion_X.pdf` (với underscore)
2. `App-data/Lektion X/vt1_eBook_Lektion X.pdf` (với space)
3. `App-data/Lektion X/Lektion_X.pdf` (ngắn gọn với underscore)
4. `App-data/Lektion X/Lektion X.pdf` (ngắn gọn với space)

**Plus URL encoded versions for web:**
5. `App-data/Lektion%20X/vt1_eBook_Lektion_X.pdf`
6. `App-data/Lektion%2520X/vt1_eBook_Lektion_X.pdf`

### 🚨 Lỗi thường gặp:

**Lỗi "assets/assets/App-data/..."**: 
- Nguyên nhân: Flutter tự động thêm 'assets/' vào đường dẫn
- Giải pháp: Sử dụng `App-data/` thay vì `assets/App-data/` trong code

**Lỗi URL encoding trong Flutter Web**:
- Nguyên nhân: Flutter Web encode spaces thành %20 hoặc %2520
- Giải pháp: AssetsService tự động thử các format encoding khác nhau 