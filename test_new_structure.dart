import 'package:flutter/services.dart';

void main() async {
  print('🔍 Testing new directory structure...');
  print('=====================================');
  
  // Test the new consistent path
  print('\n📄 Test 1: New consistent path');
  String newPath = 'App-data/Lektion_1/vt1_eBook_Lektion_1.pdf';
  try {
    ByteData data = await rootBundle.load(newPath);
    print('✅ SUCCESS: ${data.lengthInBytes} bytes');
  } catch (e) {
    print('❌ FAILED: $e');
  }
  
  // Test with assets prefix
  print('\n📄 Test 2: With assets prefix');
  String withPrefix = 'assets/App-data/Lektion_1/vt1_eBook_Lektion_1.pdf';
  try {
    ByteData data = await rootBundle.load(withPrefix);
    print('✅ SUCCESS: ${data.lengthInBytes} bytes');
  } catch (e) {
    print('❌ FAILED: $e');
  }
  
  // Test multiple lessons
  print('\n📄 Test 3: Multiple lessons');
  for (int i = 1; i <= 5; i++) {
    String lessonPath = 'App-data/Lektion_$i/vt1_eBook_Lektion_$i.pdf';
    try {
      ByteData data = await rootBundle.load(lessonPath);
      print('✅ Lektion $i: ${data.lengthInBytes} bytes');
    } catch (e) {
      print('❌ Lektion $i: $e');
    }
  }
  
  // Test AssetManifest.json
  print('\n📄 Test 4: AssetManifest.json');
  try {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    print('✅ AssetManifest.json loaded: ${manifestContent.length} characters');
    
    // Look for our new paths
    if (manifestContent.contains('Lektion_1/vt1_eBook_Lektion_1.pdf')) {
      print('✅ New path found in manifest!');
    } else {
      print('❌ New path not found in manifest');
    }
    
    // Count App-data entries
    int appDataCount = 'App-data'.allMatches(manifestContent).length;
    print('📊 Found $appDataCount App-data entries in manifest');
    
  } catch (e) {
    print('❌ FAILED to load AssetManifest.json: $e');
  }
  
  print('\n🏁 Test completed!');
} 