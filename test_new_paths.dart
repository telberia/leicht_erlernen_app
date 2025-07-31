import 'package:flutter/services.dart';

void main() async {
  print('🔍 Testing new asset paths...');
  
  // Test the corrected paths (without 'assets/' prefix)
  List<String> testPaths = [
    'App-data/Lektion 1/vt1_eBook_Lektion_1.pdf',
    'App-data/Lektion 1/vt1_eBook_Lektion 1.pdf',
    'App-data/Lektion 1/Lektion_1.pdf',
    'App-data/Lektion 1/Lektion 1.pdf',
  ];
  
  for (String path in testPaths) {
    print('\n📄 Testing path: $path');
    
    try {
      ByteData data = await rootBundle.load(path);
      print('✅ SUCCESS: Asset loaded! Size: ${data.lengthInBytes} bytes');
      break; // Found a working path
    } catch (e) {
      print('❌ FAILED: $e');
    }
  }
  
  // Test directory access
  List<String> testDirs = [
    'App-data/Lektion 1/Tabellen',
    'App-data/Lektion 1/Hörtexte',
    'App-data/Lektion 1/Übungsaudios',
  ];
  
  print('\n📁 Testing directory access:');
  for (String dir in testDirs) {
    try {
      // Try to load a dummy file to check if directory exists
      await rootBundle.load('$dir/.dummy');
      print('✅ Directory accessible: $dir');
    } catch (e) {
      if (e.toString().contains('404')) {
        print('❌ Directory not found: $dir');
      } else {
        print('⚠️ Directory exists but error: $dir - $e');
      }
    }
  }
  
  print('\n🏁 Test completed!');
} 