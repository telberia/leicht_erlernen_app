import 'package:flutter/services.dart';

void main() async {
  print('🔍 Testing PDF loading with correct paths...');
  
  // Test the exact path that should work
  String correctPath = 'assets/App-data/Lektion_1/vt1_eBook_Lektion_1.pdf';
  
  try {
    await rootBundle.load(correctPath);
    print('✅ SUCCESS: PDF loaded with path: $correctPath');
  } catch (e) {
    print('❌ FAILED: Could not load PDF with path: $correctPath');
    print('Error: $e');
  }
  
  // Test alternative paths
  List<String> testPaths = [
    'assets/App-data/Lektion_1/vt1_eBook_Lektion_1.pdf',
    'App-data/Lektion_1/vt1_eBook_Lektion_1.pdf',
    'assets/App-data/Lektion_1/Lektion_1.pdf',
  ];
  
  for (String path in testPaths) {
    try {
      await rootBundle.load(path);
      print('✅ Path works: $path');
    } catch (e) {
      print('❌ Path failed: $path - $e');
    }
  }
} 