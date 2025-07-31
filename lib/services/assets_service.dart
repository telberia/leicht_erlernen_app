import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AssetsService {
  // Fix: Use the correct path that matches AssetManifest.json
  static const String _basePath = 'assets/App-data';
  
  // Get PDF path for a lesson with multiple naming patterns and encoding
  static List<String> getPdfPaths(int lessonNumber) {
    List<String> paths = [];
    
    if (kIsWeb) {
      // For web, try URL encoded paths first
      List<String> webFormats = [
        '$_basePath/Lektion_$lessonNumber/vt1_eBook_Lektion_$lessonNumber.pdf',
        '$_basePath/Lektion%20$lessonNumber/vt1_eBook_Lektion_$lessonNumber.pdf',
        '$_basePath/Lektion%2520$lessonNumber/vt1_eBook_Lektion_$lessonNumber.pdf',
      ];
      paths.addAll(webFormats);
    }
    
    // Try different path formats with consistent underscore naming
    List<String> baseFormats = [
      // Primary pattern: Lektion_X/vt1_eBook_Lektion_X.pdf (consistent underscores)
      '$_basePath/Lektion_$lessonNumber/vt1_eBook_Lektion_$lessonNumber.pdf',
      
      // Fallback patterns (in case some files have different names)
      '$_basePath/Lektion_$lessonNumber/Lektion_$lessonNumber.pdf',
      '$_basePath/Lektion_$lessonNumber/Lektion $lessonNumber.pdf',
    ];
    
    // Add URL encoded versions for web compatibility
    List<String> encodedFormats = [
      '$_basePath/Lektion%20$lessonNumber/vt1_eBook_Lektion_$lessonNumber.pdf',
      '$_basePath/Lektion%20$lessonNumber/Lektion_$lessonNumber.pdf',
    ];
    
    // Add double-encoded versions (what we see in the error logs)
    List<String> doubleEncodedFormats = [
      '$_basePath/Lektion%2520$lessonNumber/vt1_eBook_Lektion_$lessonNumber.pdf',
      '$_basePath/Lektion%2520$lessonNumber/Lektion_$lessonNumber.pdf',
    ];
    
    paths.addAll(baseFormats);
    paths.addAll(encodedFormats);
    paths.addAll(doubleEncodedFormats);
    
    return paths;
  }
  
  // Get the first available PDF path
  static Future<String?> getAvailablePdfPath(int lessonNumber) async {
    List<String> pdfPaths = getPdfPaths(lessonNumber);
    
    for (String path in pdfPaths) {
      bool exists = await assetExists(path);
      print('🔍 Checking: $path -> ${exists ? "✅" : "❌"}');
      if (exists) {
        print('✅ Found PDF at: $path');
        return path;
      }
    }
    
    print('❌ No PDF found for Lektion $lessonNumber');
    return null;
  }
  
  // Get audio files for a lesson - try both old and new folder names
  static List<String> getTabellenAudios(int lessonNumber) {
    return [
      '$_basePath/Lektion_$lessonNumber/Tabellen/Tab ${lessonNumber}_1 - Grußformeln und Befinden - informell.mp3',
      '$_basePath/Lektion_$lessonNumber/Tabellen/Tab ${lessonNumber}_2 - Grußformeln und Befinden - formell.mp3',
      '$_basePath/Lektion_$lessonNumber/Tabellen/Tab ${lessonNumber}_3 - Vorstellung - informell.mp3',
      '$_basePath/Lektion_$lessonNumber/Tabellen/Tab ${lessonNumber}_4 - Vorstellung - formell.mp3',
      '$_basePath/Lektion_$lessonNumber/Tabellen/Tab ${lessonNumber}_5 - Vorstellung - Alternative.mp3',
    ];
  }
  
  // Try both old and new folder names for Hörtexte
  static List<String> getHoertexteAudios(int lessonNumber) {
    List<String> paths = [];
    
    // Try new folder name first
    for (int i = 1; i <= 5; i++) {
      paths.add('$_basePath/Lektion_$lessonNumber/Hoertexte/audio_${lessonNumber}_$i.mp3');
    }
    
    // Try old folder name as fallback
    for (int i = 1; i <= 5; i++) {
      paths.add('$_basePath/Lektion_$lessonNumber/Hörtexte/audio_${lessonNumber}_$i.mp3');
    }
    
    return paths;
  }
  
  // Try both old and new folder names for Übungsaudios
  static List<String> getUebungsAudios(int lessonNumber) {
    List<String> paths = [];
    
    // Try new folder name first
    for (int i = 1; i <= 3; i++) {
      paths.add('$_basePath/Lektion_$lessonNumber/Uebungsaudios/uebung_${lessonNumber}_$i.mp3');
    }
    
    // Try old folder name as fallback
    for (int i = 1; i <= 3; i++) {
      paths.add('$_basePath/Lektion_$lessonNumber/Übungsaudios/uebung_${lessonNumber}_$i.mp3');
    }
    
    return paths;
  }
  
  // Check if asset exists
  static Future<bool> assetExists(String path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Get available audio files for a lesson
  static Future<List<String>> getAvailableAudios(int lessonNumber, String type) async {
    List<String> audioPaths = [];
    
    switch (type) {
      case 'Tabellen':
        audioPaths = getTabellenAudios(lessonNumber);
        break;
      case 'Hoertexte':
        audioPaths = getHoertexteAudios(lessonNumber);
        break;
      case 'Uebungen':
        audioPaths = getUebungsAudios(lessonNumber);
        break;
    }
    
    List<String> availableAudios = [];
    for (String path in audioPaths) {
      if (await assetExists(path)) {
        availableAudios.add(path);
      }
    }
    
    return availableAudios;
  }
  
  // Get lesson title based on number
  static String getLessonTitle(int lessonNumber) {
    switch (lessonNumber) {
      case 1:
        return 'Grundlagen - Begrüßungen und Vorstellung';
      case 2:
        return 'Familie und Freunde';
      case 3:
        return 'Farben und Zahlen';
      case 4:
        return 'Tiere und Natur';
      case 5:
        return 'Essen und Trinken';
      case 6:
        return 'Warnhinweise und Aufforderungen';
      case 7:
        return 'Berufe und Arbeit';
      case 8:
        return 'Wohnen und Haushalt';
      case 9:
        return 'Transport und Verkehr';
      case 10:
        return 'Einkaufen und Geschäfte';
      case 11:
        return 'Zeit und Kalender';
      case 12:
        return 'Wetter und Jahreszeiten';
      case 13:
        return 'Hobbys und Freizeit';
      case 14:
        return 'Gesundheit und Körper';
      case 15:
        return 'Reisen und Urlaub';
      case 16:
        return 'Technologie und Medien';
      case 17:
        return 'Kultur und Traditionen';
      case 18:
        return 'Umwelt und Nachhaltigkeit';
      case 19:
        return 'Bildung und Lernen';
      case 20:
        return 'Fortgeschrittene Kommunikation';
      default:
        return 'Lektion $lessonNumber';
    }
  }
  
  // Debug method to check what directories exist for a lesson
  static Future<Map<String, bool>> checkLessonDirectories(int lessonNumber) async {
    Map<String, bool> results = {};
    
    List<String> directories = [
      'Tabellen',
      'Hörtexte',
      'Hoertexte',
      'Übungsaudios',
      'Uebungsaudios',
    ];
    
    for (String dir in directories) {
      String path = '$_basePath/Lektion_$lessonNumber/$dir';
      results[dir] = await assetExists(path);
    }
    
    return results;
  }
  
  // Debug method to check PDF files specifically
  static Future<Map<String, bool>> checkPdfFiles(int lessonNumber) async {
    Map<String, bool> results = {};
    
    List<String> pdfPaths = getPdfPaths(lessonNumber);
    
    for (String path in pdfPaths) {
      results[path] = await assetExists(path);
    }
    
    return results;
  }
  
  // Direct test method for a specific file
  static Future<bool> testSpecificFile(String path) async {
    try {
      await rootBundle.load(path);
      print('✅ File exists: $path');
      return true;
    } catch (e) {
      print('❌ File not found: $path - $e');
      return false;
    }
  }
  
  // Test all possible variations for a lesson
  static Future<void> testAllVariations(int lessonNumber) async {
    print('🔍 Testing all variations for Lektion $lessonNumber...');
    
    // Test the exact file that exists
    String exactPath = '$_basePath/Lektion_$lessonNumber/vt1_eBook_Lektion_$lessonNumber.pdf';
    await testSpecificFile(exactPath);
    
    // Test with assets prefix
    String withAssetsPrefix = 'assets/App-data/Lektion_$lessonNumber/vt1_eBook_Lektion_$lessonNumber.pdf';
    await testSpecificFile(withAssetsPrefix);
    
    // Test URL encoded versions
    String urlEncoded = '$_basePath/Lektion%20$lessonNumber/vt1_eBook_Lektion_$lessonNumber.pdf';
    await testSpecificFile(urlEncoded);
    
    String doubleEncoded = '$_basePath/Lektion%2520$lessonNumber/vt1_eBook_Lektion_$lessonNumber.pdf';
    await testSpecificFile(doubleEncoded);
  }
} 