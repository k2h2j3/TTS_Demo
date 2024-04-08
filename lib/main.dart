import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:titis/tts/provider/tts_settings_provider.dart';
import 'package:titis/tts/view/tts_screen.dart';
import 'package:titis/tts/view/tts_settings_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TtsSettingsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TTS App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TTS App'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('TTS Settings'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TtsSettingsScreen()),
                );
              },
            ),
            ElevatedButton(
              child: Text('TTS Screen'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TtsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}




