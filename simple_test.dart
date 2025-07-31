import 'package:flutter/services.dart';

void main() async {
  print('🔍 Simple PDF test...');
  
  // Test the exact path that exists
  String testPath = 'App-data/Lektion 1/vt1_eBook_Lektion_1.pdf';
  
  print('Testing: $testPath');
  
  try {
    ByteData data = await rootBundle.load(testPath);
    print('✅ SUCCESS! File size: ${data.lengthInBytes} bytes');
  } catch (e) {
    print('❌ FAILED: $e');
  }
  
  // Test with assets prefix
  String testPath2 = 'assets/App-data/Lektion 1/vt1_eBook_Lektion_1.pdf';
  
  print('\nTesting: $testPath2');
  
  try {
    ByteData data = await rootBundle.load(testPath2);
    print('✅ SUCCESS! File size: ${data.lengthInBytes} bytes');
  } catch (e) {
    print('❌ FAILED: $e');
  }
} 