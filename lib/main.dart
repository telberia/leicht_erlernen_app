import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
              // Title
              Text(
                'Lektion $lessonNumber',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3b3ec3),
                ),
                textAlign: TextAlign.center,
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
              // Title
              Text(
                'Lektion $lessonNumber',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3b3ec3),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // Tabellen/Wortlisten button
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                child: ElevatedButton(
                  onPressed: () {
                    _showComingSoonDialog(context, 'Tabellen/Wortlisten');
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