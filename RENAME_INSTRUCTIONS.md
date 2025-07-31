# Hướng dẫn đổi tên thư mục để khắc phục lỗi

## Vấn đề
Ứng dụng gặp lỗi do sử dụng các ký tự đặc biệt (ö, ü) trong tên function và thư mục. Dart không cho phép sử dụng các ký tự này trong identifiers.

## Giải pháp

### Bước 1: Đổi tên thư mục trong assets

Bạn cần đổi tên các thư mục sau trong mỗi bài học:

```
Hörtexte → Hoertexte
Übungsaudios → Uebungsaudios
```

### Bước 2: Sử dụng script Python (Khuyến nghị)

1. Mở terminal/command prompt
2. Di chuyển đến thư mục assets/App-data:
   ```bash
   cd "Leicht Erlernen/leicht_erlernen/assets/App-data"
   ```

3. Chạy script Python:
   ```bash
   python ../../rename_folders.py
   ```

### Bước 3: Đổi tên thủ công (Nếu không có Python)

Nếu bạn không có Python, hãy đổi tên thủ công:

1. Mở File Explorer
2. Điều hướng đến `Leicht Erlernen/leicht_erlernen/assets/App-data`
3. Với mỗi bài học (Lektion 1-20):
   - Đổi tên thư mục `Hörtexte` thành `Hoertexte`
   - Đổi tên thư mục `Übungsaudios` thành `Uebungsaudios`

### Bước 4: Kiểm tra

Sau khi đổi tên, cấu trúc thư mục sẽ như sau:

```
assets/App-data/
├── Lektion 1/
│   ├── Tabellen/
│   ├── Hoertexte/          ← Đã đổi tên
│   ├── Uebungsaudios/      ← Đã đổi tên
│   └── vt1_eBook_Lektion_1.pdf
├── Lektion 2/
│   ├── Tabellen/
│   ├── Hoertexte/          ← Đã đổi tên
│   ├── Uebungsaudios/      ← Đã đổi tên
│   └── vt1_eBook_Lektion_2.pdf
└── ...
```

### Bước 5: Chạy ứng dụng

Sau khi đổi tên xong:

```bash
cd "Leicht Erlernen/leicht_erlernen"
flutter pub get
flutter run
```

## Lưu ý

- Tất cả các file code đã được cập nhật để sử dụng tên mới
- Ứng dụng sẽ tự động phát hiện các file audio có sẵn
- Nếu thư mục không tồn tại, ứng dụng sẽ hiển thị "Keine Audio-Dateien verfügbar"

## Troubleshooting

Nếu vẫn gặp lỗi:

1. Kiểm tra xem tất cả thư mục đã được đổi tên chưa
2. Chạy `flutter clean` và `flutter pub get`
3. Kiểm tra console để xem lỗi cụ thể 