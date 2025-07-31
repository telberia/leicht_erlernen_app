import 'dart:io';
import 'package:flutter/services.dart';

void main() async {
  // Test PDF loading for lesson 1
  String pdfPath = 'assets/App-data/Lektion 1/vt1_eBook_Lektion_1.pdf';
  
  print('Testing PDF path: $pdfPath');
  
  try {
    // Try to load the asset
    ByteData data = await rootBundle.load(pdfPath);
    print('✅ PDF loaded successfully! Size: ${data.lengthInBytes} bytes');
    
    // Check if file exists in file system
    File file = File(pdfPath);
    if (await file.exists()) {
      print('✅ File exists in file system');
    } else {
      print('❌ File does not exist in file system');
    }
    
  } catch (e) {
    print('❌ Error loading PDF: $e');
    
    // Try alternative paths
    List<String> alternativePaths = [
      'assets/App-data/Lektion 1/vt1_eBook_Lektion 1.pdf',
      'assets/App-data/Lektion 1/Lektion_1.pdf',
      'assets/App-data/Lektion 1/Lektion 1.pdf',
    ];
    
    for (String path in alternativePaths) {
      try {
        await rootBundle.load(path);
        print('✅ Alternative path works: $path');
        break;
      } catch (e) {
        print('❌ Alternative path failed: $path - $e');
      }
    }
  }
} 