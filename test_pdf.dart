import 'dart:io';
import 'package:flutter/services.dart';

void main() async {
  print('🔍 Testing PDF loading for Lektion 1...');
  
  // Test different PDF paths
  List<String> testPaths = [
    'assets/App-data/Lektion 1/vt1_eBook_Lektion_1.pdf',
    'assets/App-data/Lektion 1/vt1_eBook_Lektion 1.pdf',
    'assets/App-data/Lektion 1/Lektion_1.pdf',
    'assets/App-data/Lektion 1/Lektion 1.pdf',
  ];
  
  for (String path in testPaths) {
    print('\n📄 Testing path: $path');
    
    try {
      // Try to load the asset
      ByteData data = await rootBundle.load(path);
      print('✅ SUCCESS: PDF loaded! Size: ${data.lengthInBytes} bytes');
      
      // Check if file exists in file system
      File file = File(path);
      if (await file.exists()) {
        print('✅ File exists in file system');
        int fileSize = await file.length();
        print('✅ File size: $fileSize bytes');
      } else {
        print('⚠️ File does not exist in file system (but asset loads)');
      }
      
      break; // Found a working path
      
    } catch (e) {
      print('❌ FAILED: $e');
    }
  }
  
  print('\n🔍 Testing asset bundle...');
  
  // Test if we can list assets
  try {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    print('✅ AssetManifest.json loaded');
    
    // Check if our PDF is in the manifest
    if (manifestContent.contains('vt1_eBook_Lektion_1.pdf')) {
      print('✅ PDF found in AssetManifest.json');
    } else {
      print('❌ PDF NOT found in AssetManifest.json');
    }
    
  } catch (e) {
    print('❌ Error loading AssetManifest.json: $e');
  }
  
  print('\n🏁 Test completed!');
} 