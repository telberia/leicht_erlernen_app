import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AudioService {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static bool _isPlaying = false;
  static String _currentAudio = '';
  
  // Initialize audio player
  static Future<void> initialize() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.stop);
  }
  
  // Play audio from asset
  static Future<void> playAudio(String assetPath) async {
    try {
      if (_isPlaying && _currentAudio == assetPath) {
        // If same audio is playing, pause it
        await pauseAudio();
        return;
      }
      
      if (_isPlaying) {
        // Stop current audio
        await _audioPlayer.stop();
      }
      
      // Play new audio
      await _audioPlayer.play(AssetSource(assetPath));
      _isPlaying = true;
      _currentAudio = assetPath;
      
      // Listen for completion
      _audioPlayer.onPlayerComplete.listen((event) {
        _isPlaying = false;
        _currentAudio = '';
      });
      
    } catch (e) {
      print('Error playing audio: $e');
      _isPlaying = false;
      _currentAudio = '';
    }
  }
  
  // Pause audio
  static Future<void> pauseAudio() async {
    try {
      await _audioPlayer.pause();
      _isPlaying = false;
    } catch (e) {
      print('Error pausing audio: $e');
    }
  }
  
  // Stop audio
  static Future<void> stopAudio() async {
    try {
      await _audioPlayer.stop();
      _isPlaying = false;
      _currentAudio = '';
    } catch (e) {
      print('Error stopping audio: $e');
    }
  }
  
  // Check if audio is playing
  static bool get isPlaying => _isPlaying;
  
  // Get current audio path
  static String get currentAudio => _currentAudio;
  
  // Dispose audio player
  static Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
  
  // Get audio duration (placeholder - would need to implement)
  static Future<Duration?> getAudioDuration(String assetPath) async {
    try {
      // This is a simplified approach - in a real app you might want to
      // pre-load audio files to get their duration
      return null;
    } catch (e) {
      return null;
    }
  }
} 