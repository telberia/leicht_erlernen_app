import 'package:flutter/material.dart';
import '../services/assets_service.dart';
import '../services/audio_service.dart';

class LessonContentScreen extends StatefulWidget {
  final int lessonNumber;

  const LessonContentScreen({
    super.key,
    required this.lessonNumber,
  });

  @override
  State<LessonContentScreen> createState() => _LessonContentScreenState();
}

class _LessonContentScreenState extends State<LessonContentScreen> {
  Map<String, List<String>> _availableAudios = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAvailableAudios();
    AudioService.initialize();
  }

  Future<void> _loadAvailableAudios() async {
    Map<String, List<String>> audios = {};
    
    // Load available audios for each category
    audios['Tabellen'] = await AssetsService.getAvailableAudios(widget.lessonNumber, 'Tabellen');
    audios['Hoertexte'] = await AssetsService.getAvailableAudios(widget.lessonNumber, 'Hoertexte');
    audios['Uebungen'] = await AssetsService.getAvailableAudios(widget.lessonNumber, 'Uebungen');
    
    setState(() {
      _availableAudios = audios;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Back button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.blue),
                ),
              ),
              
              // Title
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 40),
                child: Column(
                  children: [
                    Text(
                      'Lektion ${widget.lessonNumber}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AssetsService.getLessonTitle(widget.lessonNumber),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              // Content
              if (_isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                Expanded(
                  child: ListView(
                    children: [
                      _buildAudioSection('Tabellen/Wortlisten', Icons.table_chart, 'Tabellen'),
                      const SizedBox(height: 20),
                      _buildAudioSection('Hörbeispiele', Icons.headphones, 'Hoertexte'),
                      const SizedBox(height: 20),
                      _buildAudioSection('Übungen', Icons.quiz, 'Uebungen'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAudioSection(String title, IconData icon, String audioType) {
    List<String> audios = _availableAudios[audioType] ?? [];
    
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.blue, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          
          // Audio list
          if (audios.isEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Keine Audio-Dateien verfügbar',
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: audios.length,
              itemBuilder: (context, index) {
                String audioPath = audios[index];
                String audioName = _getAudioDisplayName(audioPath);
                
                return _buildAudioItem(audioPath, audioName, index + 1);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildAudioItem(String audioPath, String audioName, int number) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ElevatedButton(
        onPressed: () => _playAudio(audioPath),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          side: const BorderSide(color: Colors.blue, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                audioName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              AudioService.isPlaying && AudioService.currentAudio == audioPath
                  ? Icons.pause
                  : Icons.play_arrow,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  String _getAudioDisplayName(String audioPath) {
    // Extract meaningful name from audio path
    String fileName = audioPath.split('/').last;
    fileName = fileName.replaceAll('.mp3', '');
    
    // Clean up the name
    if (fileName.contains('Tab')) {
      return fileName.replaceAll('Tab ${widget.lessonNumber}_', 'Tabelle ');
    } else if (fileName.contains('audio')) {
      return fileName.replaceAll('audio_${widget.lessonNumber}_', 'Hörtext ');
    } else if (fileName.contains('uebung')) {
      return fileName.replaceAll('uebung_${widget.lessonNumber}_', 'Übung ');
    }
    
    return fileName;
  }

  void _playAudio(String audioPath) {
    AudioService.playAudio(audioPath);
    setState(() {
      // Trigger rebuild to update play/pause icons
    });
  }

  @override
  void dispose() {
    AudioService.stopAudio();
    super.dispose();
  }
} 