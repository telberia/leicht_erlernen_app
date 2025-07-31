# 🌐 Fix Web Compatibility

## ❌ **Lỗi thường gặp:**
```
Bad state: Could not find summary for library "library org-dartlang-app:/web_plugin_registrant.dart"
```

## ✅ **Giải pháp:**

### **Bước 1: Clean và rebuild**
```bash
flutter clean
flutter pub get
```

### **Bước 2: Build web**
```bash
flutter build web --web-renderer html
```

### **Bước 3: Chạy web**
```bash
flutter run -d chrome
```

## 🔧 **Nếu vẫn lỗi:**

### **Kiểm tra Flutter version:**
```bash
flutter --version
```

### **Update Flutter:**
```bash
flutter upgrade
```

### **Check web support:**
```bash
flutter doctor
```

## 📱 **Ưu tiên Mobile:**

### **Android:**
```bash
flutter run -d android
```

### **iOS:**
```bash
flutter run -d ios
```

## 🌐 **Web chỉ để test:**

- ✅ **Mobile**: Hoạt động tốt nhất
- ✅ **Web**: Chỉ để test giao diện
- ✅ **PDF**: Hoạt động tốt trên mobile
- ✅ **Audio**: Hoạt động tốt trên mobile

**Ưu tiên chạy trên mobile!** 📱 