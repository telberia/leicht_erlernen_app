import 'dart:io';

void main() async {
  print('🔍 Generating PDF asset entries for pubspec.yaml...');
  
  String assetsPath = 'assets/App-data';
  Directory assetsDir = Directory(assetsPath);
  
  if (!await assetsDir.exists()) {
    print('❌ Assets directory not found: $assetsPath');
    return;
  }
  
  List<String> pubspecEntries = ['- assets/App-data/'];
  
  // Check each lesson directory
  for (int i = 1; i <= 20; i++) {
    String lessonPath = '$assetsPath/Lektion $i';
    Directory lessonDir = Directory(lessonPath);
    
    if (await lessonDir.exists()) {
      print('📁 Processing Lektion $i...');
      pubspecEntries.add('- assets/App-data/Lektion $i/');
      
      // Check for PDF files
      List<FileSystemEntity> files = await lessonDir.list().toList();
      
      for (FileSystemEntity entity in files) {
        if (entity is File) {
          String fileName = entity.path.split(Platform.pathSeparator).last;
          if (fileName.endsWith('.pdf')) {
            print('  📄 Found PDF: $fileName');
            pubspecEntries.add('- assets/App-data/Lektion $i/$fileName');
          }
        } else if (entity is Directory) {
          String dirName = entity.path.split(Platform.pathSeparator).last;
          print('  📂 Found directory: $dirName');
          pubspecEntries.add('- assets/App-data/Lektion $i/$dirName/');
          
          // Check for audio files in subdirectories
          try {
            List<FileSystemEntity> subFiles = await entity.list().toList();
            for (FileSystemEntity subEntity in subFiles) {
              if (subEntity is File) {
                String subFileName = subEntity.path.split(Platform.pathSeparator).last;
                if (subFileName.endsWith('.mp3')) {
                  print('    🎵 Found audio: $subFileName');
                  pubspecEntries.add('- assets/App-data/Lektion $i/$dirName/$subFileName');
                }
              }
            }
          } catch (e) {
            print('    ⚠️ Error reading subdirectory $dirName: $e');
          }
        }
      }
    } else {
      print('❌ Lektion $i not found');
    }
  }
  
  print('\n📋 Generated pubspec.yaml entries:');
  print('flutter:');
  print('  uses-material-design: true');
  print('  ');
  print('  assets:');
  for (String entry in pubspecEntries) {
    print('    $entry');
  }
  
  print('\n✅ Asset generation completed!');
  print('📝 Copy the above entries to your pubspec.yaml file');
} 