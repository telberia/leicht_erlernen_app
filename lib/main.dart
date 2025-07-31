import 'package:flutter/material.dart';
import 'screens/lesson_list_screen.dart';
import 'services/audio_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioService.initialize();
  runApp(const LeichtErlernenApp());
}

class LeichtErlernenApp extends StatelessWidget {
  const LeichtErlernenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leicht Erlernen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const LessonListScreen(),
    );
  }
} 