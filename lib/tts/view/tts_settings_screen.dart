import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:titis/tts/provider/tts_settings_provider.dart';

class TtsSettingsScreen extends StatelessWidget {
  final Map<String, String> readingRangeLabels = {
    'all': '모두 읽기',
    'selected': '선택 영역만 읽기',
    'mute': '음소거',
  };

  final Map<String, String> voiceTypeLabels = {
    'male': '남성',
    'female': '여성',
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<TtsSettingsProvider>(
      builder: (context, ttsSettings, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('TTS Settings'),
          ),
          body: Column(
            children: [
              Text('읽기 범위'),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: readingRangeLabels.entries.map((entry) {
                  return InkWell(
                    onTap: () {
                      ttsSettings.setReadingRange(entry.key);
                      print(ttsSettings.readingRange);
                    },
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontWeight: ttsSettings.readingRange == entry.key
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text('음성 종류'),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: voiceTypeLabels.entries.map((entry) {
                  return InkWell(
                    onTap: () {
                      ttsSettings.setVoiceType(entry.key);
                      print('Voice Type: ${ttsSettings.voiceType}');
                    },
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontWeight: ttsSettings.voiceType == entry.key
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text('선택 텍스트'),
              TextField(
                onChanged: (value) {
                  ttsSettings.setSelectedText(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}