import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class AudioService {
  static const String _basePath = 'assets/App-data';
  
  /// Get audio files from Tabellen folder for a specific lesson
  static Future<List<String>> getTabellenAudioFiles(int lessonNumber) async {
    List<String> audioFiles = [];
    
    try {
      // Get the asset manifest to see what files are available
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      
      // Look for audio files in the Tabellen folder
      String tabellenPath = '$_basePath/Lektion_$lessonNumber/Tabellen/';
      
      // Common audio file extensions
      List<String> audioExtensions = ['.mp3', '.wav', '.m4a', '.aac'];
      
      // Check for files in the Tabellen folder
      for (String assetPath in manifestMap.keys) {
        if (assetPath.startsWith(tabellenPath) && 
            audioExtensions.any((ext) => assetPath.toLowerCase().endsWith(ext))) {
          // Extract just the filename
          String fileName = assetPath.split('/').last;
          audioFiles.add(fileName);
        }
      }
      
      // If no files found, try alternative naming patterns
      if (audioFiles.isEmpty) {
        // Try common naming patterns based on lesson number
        List<String> commonPatterns = [
          'Tab ${lessonNumber}_1 - Begrüßung und Vorstellung.mp3',
          'Tab ${lessonNumber}_2 - Zahlen und Datum.mp3',
          'Tab ${lessonNumber}_3 - Familie und Freunde.mp3',
          'Tab ${lessonNumber}_4 - Essen und Trinken.mp3',
          'Tab ${lessonNumber}_5 - Alltag und Hobbys.mp3',
          'tabellen_1.mp3',
          'tabellen_2.mp3',
          'tabellen_3.mp3',
          'audio_1.mp3',
          'audio_2.mp3',
          'audio_3.mp3',
          'lektion_${lessonNumber}_tabellen_1.mp3',
          'lektion_${lessonNumber}_tabellen_2.mp3',
          'lektion_${lessonNumber}_audio_1.mp3',
          'lektion_${lessonNumber}_audio_2.mp3',
        ];
        
        for (String pattern in commonPatterns) {
          String fullPath = '$tabellenPath$pattern';
          if (manifestMap.containsKey(fullPath)) {
            audioFiles.add(pattern);
          }
        }
      }
      
      // If still no files found, use lesson-specific content
      if (audioFiles.isEmpty) {
        print('⚠️ No audio files found for Lektion $lessonNumber, using lesson-specific content');
        audioFiles = getLessonSpecificAudioContent(lessonNumber);
      }
      
      print('✅ Found ${audioFiles.length} audio files in Tabellen folder for Lektion $lessonNumber');
      
    } catch (e) {
      print('❌ Error scanning Tabellen folder: $e');
      // Return lesson-specific content if there's an error
      audioFiles = getLessonSpecificAudioContent(lessonNumber);
    }
    
    return audioFiles;
  }
  
  /// Get the full asset path for an audio file
  static String getAudioAssetPath(int lessonNumber, String fileName) {
    return '$_basePath/Lektion_$lessonNumber/Tabellen/$fileName';
  }
  
  /// Check if a specific audio file exists
  static Future<bool> audioFileExists(int lessonNumber, String fileName) async {
    try {
      String assetPath = getAudioAssetPath(lessonNumber, fileName);
      await rootBundle.load(assetPath);
      return true;
    } catch (e) {
      print('❌ Audio file not found: ${getAudioAssetPath(lessonNumber, fileName)}');
      return false;
    }
  }
  
  /// Get all available audio files for a lesson
  static Future<Map<String, List<String>>> getAllLessonAudioFiles(int lessonNumber) async {
    Map<String, List<String>> audioFiles = {};
    
    // Get Tabellen audio files
    audioFiles['Tabellen'] = await getTabellenAudioFiles(lessonNumber);
    
    // TODO: Add Hoertexte and Uebungsaudios when implemented
    audioFiles['Hoertexte'] = [];
    audioFiles['Uebungsaudios'] = [];
    
    return audioFiles;
  }
  
  /// Get lesson-specific audio content based on lesson number
  static List<String> getLessonSpecificAudioContent(int lessonNumber) {
    // Return different audio content based on lesson number
    switch (lessonNumber) {
      case 1:
        return [
          'Tab 1_1 - Hallo und Guten Tag.mp3',
          'Tab 1_2 - Wie heißen Sie.mp3',
          'Tab 1_3 - Woher kommen Sie.mp3',
          'Tab 1_4 - Zahlen von 1-10.mp3',
          'Tab 1_5 - Das Alphabet.mp3',
        ];
      case 2:
        return [
          'Tab 2_1 - Familie und Verwandte.mp3',
          'Tab 2_2 - Berufe und Arbeit.mp3',
          'Tab 2_3 - Länder und Nationalitäten.mp3',
          'Tab 2_4 - Farben und Kleidung.mp3',
          'Tab 2_5 - Wochentage und Monate.mp3',
        ];
      case 3:
        return [
          'Tab 3_1 - Essen und Getränke.mp3',
          'Tab 3_2 - Im Restaurant.mp3',
          'Tab 3_3 - Einkaufen gehen.mp3',
          'Tab 3_4 - Geld und Preise.mp3',
          'Tab 3_5 - Uhrzeiten.mp3',
        ];
      case 4:
        return [
          'Tab 4_1 - Wohnen und Haus.mp3',
          'Tab 4_2 - Möbel und Zimmer.mp3',
          'Tab 4_3 - Adressen und Wegbeschreibung.mp3',
          'Tab 4_4 - Verkehrsmittel.mp3',
          'Tab 4_5 - In der Stadt.mp3',
        ];
      case 5:
        return [
          'Tab 5_1 - Hobbys und Freizeit.mp3',
          'Tab 5_2 - Sport und Bewegung.mp3',
          'Tab 5_3 - Musik und Kultur.mp3',
          'Tab 5_4 - Reisen und Urlaub.mp3',
          'Tab 5_5 - Wetter und Jahreszeiten.mp3',
        ];
      case 6:
        return [
          'Tab 6_1 - Verkehrsmittel - Ich nehme.mp3',
          'Tab 6_2 - Verkehrsmittel - Ich fahre mit.mp3',
          'Tab 6_3 - Verkehrsmittel - zu Fuß und mit dem.mp3',
          'Tab 6_9 - Abfahrt und Ankunft.mp3',
          'Tab 6_10 - Verspätung und Ausfall.mp3',
          'Tab 6_11 - Ankunftszeit und Verspätung.mp3',
          'Tab 6_12 - Zimmer buchen.mp3',
        ];
      default:
        return [
          'Tab ${lessonNumber}_1 - Begrüßung und Vorstellung.mp3',
          'Tab ${lessonNumber}_2 - Zahlen und Datum.mp3',
          'Tab ${lessonNumber}_3 - Familie und Freunde.mp3',
          'Tab ${lessonNumber}_4 - Essen und Trinken.mp3',
          'Tab ${lessonNumber}_5 - Alltag und Hobbys.mp3',
        ];
    }
  }
} 