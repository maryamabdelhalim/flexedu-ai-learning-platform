import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final String lessonTitle;
  final List<Map<String, dynamic>> quiz;

  const QuizPage({super.key, required this.lessonTitle, required this.quiz});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentIndex = 0;
  List<String?> selectedAnswers = [];

  @override
  void initState() {
    selectedAnswers = List.filled(widget.quiz.length, null);
    super.initState();
  }

  void _submitQuiz() async {
    int correct = 0;
    for (int i = 0; i < widget.quiz.length; i++) {
      if (selectedAnswers[i] == widget.quiz[i]['correctAnswer']) {
        correct++;
      }
    }

    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("progress").doc(uid).set({
      widget.lessonTitle: correct,
    }, SetOptions(merge: true));

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Quiz Complete"),
        content: Text("You got $correct / ${widget.quiz.length} correct."),
        actions: [
          TextButton(
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.quiz[currentIndex];
    final options = List<String>.from(question['options']);

    return Scaffold(
      appBar: AppBar(title: Text("Quiz - ${widget.lessonTitle}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Question ${currentIndex + 1}/${widget.quiz.length}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(question['question'], style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ...options.map((option) => RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: selectedAnswers[currentIndex],
                  onChanged: (value) {
                    setState(() => selectedAnswers[currentIndex] = value);
                  },
                )),
            const Spacer(),
            ElevatedButton(
              onPressed: selectedAnswers[currentIndex] == null
                  ? null
                  : () {
                      if (currentIndex < widget.quiz.length - 1) {
                        setState(() => currentIndex++);
                      } else {
                        _submitQuiz();
                      }
                    },
              child: Text(currentIndex == widget.quiz.length - 1 ? "Submit" : "Next"),
            )
          ],
        ),
      ),
    );
  }
}
