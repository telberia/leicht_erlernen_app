import 'package:flutter/services.dart';

void main() async {
  print('🔍 Comprehensive Asset Loading Test');
  print('=====================================');
  
  // Test 1: Try to load the exact file that exists
  print('\n📄 Test 1: Exact file path');
  String exactPath = 'App-data/Lektion 1/vt1_eBook_Lektion_1.pdf';
  try {
    ByteData data = await rootBundle.load(exactPath);
    print('✅ SUCCESS: ${data.lengthInBytes} bytes');
  } catch (e) {
    print('❌ FAILED: $e');
  }
  
  // Test 2: Try with assets prefix
  print('\n📄 Test 2: With assets prefix');
  String withPrefix = 'assets/App-data/Lektion 1/vt1_eBook_Lektion_1.pdf';
  try {
    ByteData data = await rootBundle.load(withPrefix);
    print('✅ SUCCESS: ${data.lengthInBytes} bytes');
  } catch (e) {
    print('❌ FAILED: $e');
  }
  
  // Test 3: Try URL encoded
  print('\n📄 Test 3: URL encoded');
  String urlEncoded = 'App-data/Lektion%201/vt1_eBook_Lektion_1.pdf';
  try {
    ByteData data = await rootBundle.load(urlEncoded);
    print('✅ SUCCESS: ${data.lengthInBytes} bytes');
  } catch (e) {
    print('❌ FAILED: $e');
  }
  
  // Test 4: Try double encoded
  print('\n📄 Test 4: Double encoded');
  String doubleEncoded = 'App-data/Lektion%25201/vt1_eBook_Lektion_1.pdf';
  try {
    ByteData data = await rootBundle.load(doubleEncoded);
    print('✅ SUCCESS: ${data.lengthInBytes} bytes');
  } catch (e) {
    print('❌ FAILED: $e');
  }
  
  // Test 5: Try to list all assets
  print('\n📄 Test 5: List all assets');
  try {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    print('✅ AssetManifest.json loaded: ${manifestContent.length} characters');
    
    // Look for our PDF in the manifest
    if (manifestContent.contains('vt1_eBook_Lektion_1.pdf')) {
      print('✅ PDF found in manifest!');
    } else {
      print('❌ PDF not found in manifest');
    }
    
    // Print first 500 characters of manifest
    print('Manifest preview: ${manifestContent.substring(0, 500)}...');
  } catch (e) {
    print('❌ FAILED to load AssetManifest.json: $e');
  }
  
  print('\n🏁 Test completed!');
} 