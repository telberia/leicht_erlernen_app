import 'dart:io';

void main() async {
  print('🔍 Checking actual PDF file names...');
  
  Directory appDataDir = Directory('assets/App-data');
  
  if (!await appDataDir.exists()) {
    print('❌ assets/App-data directory not found');
    return;
  }
  
  List<FileSystemEntity> entities = await appDataDir.list().toList();
  
  for (FileSystemEntity entity in entities) {
    if (entity is Directory && entity.path.contains('Lektion')) {
      String lessonName = entity.path.split('/').last;
      print('\n📁 $lessonName:');
      
      try {
        List<FileSystemEntity> lessonFiles = await entity.list().toList();
        
        for (FileSystemEntity file in lessonFiles) {
          if (file is File && file.path.endsWith('.pdf')) {
            String fileName = file.path.split('/').last;
            print('  📄 $fileName');
          }
        }
      } catch (e) {
        print('  ❌ Error reading directory: $e');
      }
    }
  }
  
  print('\n🏁 Check completed!');
} 