import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:titis/tts/provider/tts_settings_provider.dart';

class TtsScreen extends StatefulWidget {
  const TtsScreen({super.key});

  @override
  State<TtsScreen> createState() => _TtsScreenState();
}

class _TtsScreenState extends State<TtsScreen> {
  late TtsSettingsProvider ttsSettings;
  FlutterTts flutterTts = FlutterTts();

  String language = "ko-KR";
  Map<String, String> voicewoman = {"name": "ko-kr-x-kob-local", "locale": "ko-KR"};
  Map<String, String> voiceman = {"name": "ko-kr-x-kod-local", "locale": "ko-KR"};
  String engine = "com.google.android.tts";
  double volume = 0.8;
  double pitch = 1.0;
  double rate = 0.5;

  String _disselectedText = '이 부분은 읽지 마세요.';

  @override
  void initState() {
    super.initState();
    ttsSettings = Provider.of<TtsSettingsProvider>(context, listen: false);
    initTts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ttsSettings.addListener(initTts);
  }

  @override
  void dispose() {
    ttsSettings.removeListener(initTts);
    super.dispose();
  }

  initTts() async {
    flutterTts.setLanguage(language);
    if (ttsSettings.voiceType == 'male') {
      flutterTts.setVoice(voiceman);
    } else if (ttsSettings.voiceType == 'female') {
      flutterTts.setVoice(voicewoman);
    }
    flutterTts.setEngine(engine);
    flutterTts.setVolume(volume);
    flutterTts.setPitch(pitch);
    flutterTts.setSpeechRate(rate);
  }

  Future _speak(String text) async {
    print('Reading selected text');
    print('readingRange: ${ttsSettings.readingRange}');
    print('Language: $language');
    print('Voice: ${ttsSettings.voiceType == 'male' ? voiceman['name'] : voicewoman['name']}');
    if (text.isNotEmpty) {
      final ttsSettings = Provider.of<TtsSettingsProvider>(context, listen: false);
      if (ttsSettings.readingRange == 'all') {
        flutterTts.speak(_disselectedText + ttsSettings.selectedText);
      } else if (ttsSettings.readingRange == 'selected') {
        flutterTts.speak(ttsSettings.selectedText);
      } else if (ttsSettings.readingRange == 'mute') {
        print('TTS is muted');
        // TTS 기능 동작하지 않음
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TtsSettingsProvider>(
      builder: (context, ttsSettings, _) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _disselectedText = value;
                    });
                  },
                ),
                TextField(
                  onChanged: (value) {
                    ttsSettings.setSelectedText(value);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (ttsSettings.readingRange != 'mute') {
                      _speak(ttsSettings.readingRange == 'all' ? _disselectedText + ttsSettings.selectedText : ttsSettings.selectedText);
                    }
                  },
                  child: const Text('내용 읽기'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}