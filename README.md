# Leicht Erlernen App

Ứng dụng học tiếng Đức với PDF viewer và audio player.

## 🚀 Chạy App

### 📱 Android (Ưu tiên):
```bash
flutter run -d android
```

### 📱 iOS (Ưu tiên):
```bash
flutter run -d ios
```

### 🌐 Web:
```bash
flutter clean
flutter pub get
flutter run -d chrome
```

## 📱 Tính năng

- ✅ Danh sách 20 bài học
- ✅ PDF viewer cho eBook
- ✅ Audio player với 3 options:
  - Tabellen/Wortlisten
  - Hörbeispiele  
  - Übungen
- ✅ Giao diện tiếng Đức
- ✅ Màu sắc: #3b3ec3 (xanh), #ffffff (trắng)
- ✅ Hỗ trợ Android, iOS và Web

## 📁 Cấu trúc

```
assets/App-data/
├── Lektion_1/
│   └── vt1_eBook_Lektion_1.pdf
├── Lektion_2/
│   └── vt1_eBook_Lektion_2.pdf
└── ...
```

## 🔧 Dependencies

- `syncfusion_flutter_pdfviewer: ^30.1.42`
- `audioplayers: ^6.5.0`
- `file_picker: ^6.1.1`
- `path_provider: ^2.1.1`
- `http: ^1.1.0`

## 🌐 Fix Web Issues

Nếu gặp lỗi web, chạy:
```bash
.\fix_web.ps1
```

**App hoạt động trên Android, iOS và Web!** 📱🌐 