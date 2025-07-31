import 'dart:io';

void main() async {
  print('🔍 Checking assets directory structure...');
  
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
      print('📁 Found Lektion $i');
      pubspecEntries.add('- assets/App-data/Lektion $i/');
      
      // Check subdirectories
      List<FileSystemEntity> subdirs = await lessonDir.list().toList();
      
      for (FileSystemEntity entity in subdirs) {
        if (entity is Directory) {
          String dirName = entity.path.split(Platform.pathSeparator).last;
          print('  📂 Found subdirectory: $dirName');
          pubspecEntries.add('- assets/App-data/Lektion $i/$dirName/');
        } else if (entity is File) {
          String fileName = entity.path.split(Platform.pathSeparator).last;
          if (fileName.endsWith('.pdf')) {
            print('  📄 Found PDF: $fileName');
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
  
  print('\n✅ Asset structure check completed!');
} 