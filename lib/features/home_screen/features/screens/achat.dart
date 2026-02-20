import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flexedu/core/colors/colors.dart';

class AChat extends StatefulWidget {
  final String lessonId;
  final String lessonTitle;

  const AChat({super.key, required this.lessonId, required this.lessonTitle});

  @override
  State<AChat> createState() => _AChatState();
}

class _AChatState extends State<AChat> {
  String? responseText;
  bool isLoading = true;

  final FlutterTts _tts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isSpeaking = false;

  @override
  void initState() {
    super.initState();
    fetchAndSendPrompt();
  }

  Future<void> fetchAndSendPrompt() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection("lessons")
          .doc(widget.lessonId)
          .get();

      final prompt = doc.data()?['audPrompt'];
      if (prompt == null) {
        setState(() {
          responseText = "No audioPrompt found for this lesson.";
          isLoading = false;
        });
        return;
      }

      final parts = [Part.text(prompt)];
      final geminiResponse = await Gemini.instance.prompt(parts: parts);

      setState(() {
        responseText = geminiResponse?.output ?? "No response from Gemini.";
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        responseText = "Error: $e";
        isLoading = false;
      });
    }
  }

  Future<void> speakText() async {
    if (responseText == null) return;

    await _tts.setLanguage("en-US");
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.5);
    await _tts.speak(responseText!);

    setState(() {
      isSpeaking = true;
    });

    _tts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  Future<void> stopSpeech() async {
    await _tts.stop();
    setState(() => isSpeaking = false);
  }

  @override
  void dispose() {
    _tts.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auditory Assistant - ${widget.lessonTitle}"),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.greyColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          responseText ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: AppColors.blacColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: isSpeaking ? stopSpeech : speakText,
                    icon: Icon(isSpeaking ? Icons.stop : Icons.volume_up),
                    label: Text(isSpeaking ? "Stop Reading" : "Read Out Loud"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
