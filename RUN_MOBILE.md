# 🚀 Chạy App trên Mobile

## ✅ **Chỉ chạy trên Android/iOS - KHÔNG chạy Web**

### 📱 **Android:**
```bash
cd "Leicht Erlernen/leicht_erlernen_app"
flutter clean
flutter pub get
flutter run -d android
```

### 📱 **iOS:**
```bash
cd "Leicht Erlernen/leicht_erlernen_app"
flutter clean
flutter pub get
flutter run -d ios
```

## ❌ **KHÔNG chạy Web:**
```bash
# KHÔNG chạy lệnh này
flutter run -d chrome
```

## 🔧 **Nếu gặp lỗi:**

### **Lỗi Gradle:**
```bash
flutter clean
flutter pub get
flutter run -d android
```

### **Lỗi iOS:**
```bash
cd ios
pod install
cd ..
flutter run -d ios
```

## 📱 **App hoạt động:**
- ✅ Danh sách 20 bài học
- ✅ PDF viewer cho eBook
- ✅ Audio player với 3 options
- ✅ Giao diện tiếng Đức
- ✅ Màu sắc #3b3ec3

**Chỉ chạy trên mobile - không chạy web!** 📱 