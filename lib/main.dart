import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'services/audio_service.dart';

void main() {
  runApp(const LeichtErlernenApp());
}

class LeichtErlernenApp extends StatelessWidget {
  const LeichtErlernenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leicht Erlernen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3b3ec3),
          primary: const Color(0xFF3b3ec3),
          secondary: const Color(0xFFFFFFFF),
          tertiary: const Color(0xFFf3f2f5),
        ),
        useMaterial3: true,
      ),
      home: const LessonListScreen(),
    );
  }
}

class LessonListScreen extends StatelessWidget {
  const LessonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Title
              const Text(
                '| LEICHT-ERLERNEN |',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3b3ec3),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // Lesson buttons
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    final lessonNumber = index + 1;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LessonDetailScreen(lessonNumber: lessonNumber),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFFFFF),
                          foregroundColor: const Color(0xFF3b3ec3),
                          side: const BorderSide(
                            color: Color(0xFF3b3ec3),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                        ),
                        child: Text(
                          'Lektion $lessonNumber',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF3b3ec3),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LessonDetailScreen extends StatelessWidget {
  final int lessonNumber;

  const LessonDetailScreen({super.key, required this.lessonNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Back button and title
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF3b3ec3)),
                  ),
                  Expanded(
                    child: Text(
                      'Lektion $lessonNumber',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3b3ec3),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48), // Balance the back button
                ],
              ),
              const SizedBox(height: 40),
              
              // Audioplayer button
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                child: ElevatedButton(
                  onPressed: () {
                    _showAudioDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3b3ec3),
                    foregroundColor: const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Audioplayer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
              
              // eBook button
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfViewerScreen(lessonNumber: lessonNumber),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3b3ec3),
                    foregroundColor: const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  child: const Text(
                    'eBook',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAudioDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AudioContentScreen(lessonNumber: lessonNumber),
      ),
    );
  }
}

class AudioContentScreen extends StatelessWidget {
  final int lessonNumber;

  const AudioContentScreen({super.key, required this.lessonNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Back button and title
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF3b3ec3)),
                  ),
                  Expanded(
                    child: Text(
                      'Lektion $lessonNumber',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3b3ec3),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48), // Balance the back button
                ],
              ),
              const SizedBox(height: 40),
              
              // Tabellen/Wortlisten button
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TabellenAudioScreen(lessonNumber: lessonNumber),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFFFFF),
                    foregroundColor: const Color(0xFF3b3ec3),
                    side: const BorderSide(
                      color: Color(0xFF3b3ec3),
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Tabellen/Wortlisten',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3b3ec3),
                    ),
                  ),
                ),
              ),
              
              // Hörbeispiele button
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                child: ElevatedButton(
                  onPressed: () {
                    _showComingSoonDialog(context, 'Hörbeispiele');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFFFFF),
                    foregroundColor: const Color(0xFF3b3ec3),
                    side: const BorderSide(
                      color: Color(0xFF3b3ec3),
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Hörbeispiele',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3b3ec3),
                    ),
                  ),
                ),
              ),
              
              // Übungen button
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showComingSoonDialog(context, 'Übungen');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFFFFF),
                    foregroundColor: const Color(0xFF3b3ec3),
                    side: const BorderSide(
                      color: Color(0xFF3b3ec3),
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Übungen',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3b3ec3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$feature - Lektion $lessonNumber'),
        content: Text('$feature wird bald verfügbar sein.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class TabellenAudioScreen extends StatefulWidget {
  final int lessonNumber;

  const TabellenAudioScreen({super.key, required this.lessonNumber});

  @override
  State<TabellenAudioScreen> createState() => _TabellenAudioScreenState();
}

class _TabellenAudioScreenState extends State<TabellenAudioScreen> {
  List<String> audioFiles = [];
  bool isLoading = true;
  AudioPlayer audioPlayer = AudioPlayer();
  String? currentlyPlaying;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _loadAudioFiles();
  }

  Future<void> _loadAudioFiles() async {
    try {
      // Load real audio files from Tabellen folder using AudioService
      List<String> realAudioFiles = await AudioService.getTabellenAudioFiles(widget.lessonNumber);
      
      setState(() {
        audioFiles = realAudioFiles;
        isLoading = false;
      });
      
      print('✅ Loaded ${realAudioFiles.length} real audio files for Lektion ${widget.lessonNumber}');
      
    } catch (e) {
      print('❌ Error loading audio files: $e');
      setState(() {
        audioFiles = [];
        isLoading = false;
      });
    }
  }

  Future<void> _playAudio(String audioFile) async {
    try {
      if (currentlyPlaying == audioFile && isPlaying) {
        // Pause current audio
        await audioPlayer.pause();
        setState(() {
          isPlaying = false;
        });
      } else if (currentlyPlaying == audioFile && !isPlaying) {
        // Resume current audio
        await audioPlayer.resume();
        setState(() {
          isPlaying = true;
        });
      } else {
        // Play new audio
        await audioPlayer.stop();
        
        // Get the real asset path using AudioService
        String assetPath = AudioService.getAudioAssetPath(widget.lessonNumber, audioFile);
        
        // Check if the audio file exists
        bool fileExists = await AudioService.audioFileExists(widget.lessonNumber, audioFile);
        
        if (fileExists) {
          try {
            // Play the real audio file
            await audioPlayer.play(AssetSource(assetPath));
            
            print('🎵 Playing real audio: $assetPath');
            
            setState(() {
              currentlyPlaying = audioFile;
              isPlaying = true;
            });
            
            // Listen for completion
            audioPlayer.onPlayerComplete.listen((event) {
              setState(() {
                isPlaying = false;
              });
            });
            
          } catch (e) {
            print('❌ Error playing real audio file: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Fehler beim Abspielen: $e'),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          print('❌ Audio file not found: $assetPath');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Audio-Datei nicht gefunden: $audioFile'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      print('❌ Error in _playAudio: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fehler beim Abspielen: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Back button and title
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF3b3ec3)),
                  ),
                  Expanded(
                    child: Text(
                      'Lektion ${widget.lessonNumber} Tabellen',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3b3ec3),
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48), // Balance the back button
                ],
              ),
              const SizedBox(height: 40),
              
              // Audio files list
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF3b3ec3),
                        ),
                      )
                    : audioFiles.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 64,
                                  color: Color(0xFF3b3ec3),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Keine Audio-Dateien gefunden',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF3b3ec3),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Folder "Tabellen" existiert nicht',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: audioFiles.length,
                            itemBuilder: (context, index) {
                              final audioFile = audioFiles[index];
                              final isCurrentPlaying = currentlyPlaying == audioFile && isPlaying;
                              
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: ElevatedButton.icon(
                                  onPressed: () => _playAudio(audioFile),
                                  icon: Icon(
                                    isCurrentPlaying ? Icons.pause : Icons.play_arrow,
                                    color: const Color(0xFF3b3ec3),
                                  ),
                                  label: Expanded(
                                    child: Text(
                                      audioFile,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF3b3ec3),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFFFFF),
                                    foregroundColor: const Color(0xFF3b3ec3),
                                    side: const BorderSide(
                                      color: Color(0xFF3b3ec3),
                                      width: 1,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                    elevation: 0,
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final int lessonNumber;

  const PdfViewerScreen({super.key, required this.lessonNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lektion $lessonNumber - eBook'),
        backgroundColor: const Color(0xFF3b3ec3),
        foregroundColor: const Color(0xFFFFFFFF),
      ),
      body: SfPdfViewer.asset(
        'assets/App-data/Lektion_$lessonNumber/vt1_eBook_Lektion_$lessonNumber.pdf',
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          print('✅ PDF loaded: ${details.document.pages.count} pages');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('PDF geladen: ${details.document.pages.count} Seiten'),
              backgroundColor: const Color(0xFF3b3ec3),
            ),
          );
        },
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          print('❌ PDF failed: ${details.error}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('PDF Fehler: ${details.error}'),
              backgroundColor: Colors.red,
            ),
          );
        },
      ),
    );
  }
} 