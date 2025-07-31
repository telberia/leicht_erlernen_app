import 'package:flutter/services.dart';

void main() async {
  print('🔍 Testing web asset paths...');
  
  // Test different path formats
  List<String> testPaths = [
    'App-data/Lektion 1/vt1_eBook_Lektion_1.pdf',
    'App-data/Lektion%201/vt1_eBook_Lektion_1.pdf',
    'App-data/Lektion%25201/vt1_eBook_Lektion_1.pdf',
    'assets/App-data/Lektion 1/vt1_eBook_Lektion_1.pdf',
    'assets/App-data/Lektion%201/vt1_eBook_Lektion_1.pdf',
  ];
  
  for (String path in testPaths) {
    print('\n📄 Testing path: $path');
    
    try {
      ByteData data = await rootBundle.load(path);
      print('✅ SUCCESS: Asset loaded! Size: ${data.lengthInBytes} bytes');
      print('✅ Path works: $path');
      break; // Found a working path
    } catch (e) {
      print('❌ FAILED: $e');
    }
  }
  
  // Test with different encoding patterns
  print('\n🔍 Testing URL encoding patterns:');
  
  List<String> encodingTests = [
    'App-data/Lektion 1/vt1_eBook_Lektion_1.pdf',
    'App-data/Lektion%201/vt1_eBook_Lektion_1.pdf',
    'App-data/Lektion%25201/vt1_eBook_Lektion_1.pdf',
    'App-data/Lektion%25201/vt1_eBook_Lektion%25201.pdf',
  ];
  
  for (String path in encodingTests) {
    try {
      await rootBundle.load(path);
      print('✅ Works: $path');
    } catch (e) {
      print('❌ Fails: $path - $e');
    }
  }
  
  print('\n🏁 Web path test completed!');
} 