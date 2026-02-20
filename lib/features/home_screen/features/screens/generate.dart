import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:stability_image_generation/stability_image_generation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Generate extends StatefulWidget {
  final String lessonId;
  final String lessonTitle;

  const Generate({
    super.key,
    required this.lessonId,
    required this.lessonTitle,
  });

  @override
  State<Generate> createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  final StabilityAI _ai = StabilityAI();
  final String apiKey = 'sk-K9FgcWkQuLmNmmIdFfUp5fh7yB1cWvUNedpixIzJdH9Odpf0';
  final ImageAIStyle style = ImageAIStyle.noStyle;

  List<String> prompts = [];
  List<Uint8List?> images = [];
  String? learningStyle;
  bool isLoading = true;
  bool isGenerating = false;

  @override
  void initState() {
    super.initState();
    fetchLearningStyleAndPrompts();
  }

  Future<void> fetchLearningStyleAndPrompts() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw Exception("User not logged in.");

      // Fetch learningStyle from users collection
      final userDoc = await FirebaseFirestore.instance.collection("users").doc(userId).get();
      learningStyle = userDoc.data()?['learningStyle'];

      // Fetch prompts from lesson
      final lessonDoc = await FirebaseFirestore.instance
          .collection("lessons")
          .doc(widget.lessonId)
          .get();
      final lessonData = lessonDoc.data() as Map<String, dynamic>;

      String promptField = learningStyle == "Kinesthetic" ? "kinPrompts" : "visualPrompts";
      prompts = List<String>.from(lessonData[promptField] ?? []);

      images = List.filled(prompts.length, null);
    } catch (e) {
      if (kDebugMode) print("Error fetching prompts or learning style: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> generateImages() async {
    setState(() {
      isGenerating = true;
      images = List.filled(prompts.length, null);
    });

    for (int i = 0; i < prompts.length; i++) {
      try {
        final img = await _ai.generateImage(
          apiKey: apiKey,
          imageAIStyle: style,
          prompt: prompts[i],
        );
        setState(() {
          images[i] = img;
        });
      } catch (e) {
        if (kDebugMode) print("Error generating image $i: $e");
      }
    }

    setState(() => isGenerating = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("${widget.lessonTitle} AI Visual Guide"),
        backgroundColor: Colors.green[700],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: isGenerating ? null : generateImages,
                    child: isGenerating
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Generate All Images"),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: prompts.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Step ${index + 1}: ${prompts[index]}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            images[index] != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.memory(images[index]!),
                                  )
                                : const Text("No image yet."),
                            const SizedBox(height: 20),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
