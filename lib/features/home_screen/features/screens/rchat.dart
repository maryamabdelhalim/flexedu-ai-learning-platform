import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flexedu/core/colors/colors.dart';

class RChat extends StatefulWidget {
  final String lessonId;
  final String lessonTitle;

  const RChat({super.key, required this.lessonId, required this.lessonTitle});

  @override
  State<RChat> createState() => _RChatState();
}

class _RChatState extends State<RChat> {
  String? responseText;
  bool isLoading = true;

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

      final prompt = doc.data()?['readPrompt'];
      if (prompt == null) {
        setState(() {
          responseText = "No prompt found for this lesson.";
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
        responseText = "Error fetching or processing: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.lessonTitle} (Read/Write AI)'),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
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
    );
  }
}
