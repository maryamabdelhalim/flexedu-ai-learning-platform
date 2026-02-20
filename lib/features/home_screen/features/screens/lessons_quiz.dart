import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexedu/core/const/const.dart';
import 'package:flutter/material.dart';

class LessonQuizScreen extends StatefulWidget {
  final String lessonId;
  final String lessonTitle;

  LessonQuizScreen({required this.lessonId, required this.lessonTitle});

  @override
  _LessonQuizScreenState createState() => _LessonQuizScreenState();
}

class _LessonQuizScreenState extends State<LessonQuizScreen> {
  List<Map<String, dynamic>> questions = [];
  int index = 0;
  int? selected;
  int correctCount = 0;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("lessons")
        .doc(widget.lessonId)
        .collection("quizzes")
        .get();

    setState(() {
      questions =
          snapshot.docs.map((e) => e.data() as Map<String, dynamic>).toList();
    });
  }

  Future<void> saveLessonResult({
    required String lessonId,
    required String userId,
    required int score,
    required int total,
  }) async {
    await FirebaseFirestore.instance.collection("progress").add({
      "userId": userId,
      "lessonTitle": widget.lessonTitle,
      "score": "$score/$total",
      "timestamp": FieldValue.serverTimestamp(),
    });
  }

  void next() {
    if (selected == questions[index]["correctIndex"]) correctCount++;

    if (index < questions.length - 1) {
      setState(() {
        index++;
        selected = null;
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Finished"),
          content: Text("Correct: $correctCount / ${questions.length}"),
          actions: [
            TextButton(
              onPressed: () {
                saveLessonResult(
                  lessonId: widget.lessonId,
                  userId: uid.toString(),
                  score: correctCount,
                  total: questions.length,
                );
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty)
      return Scaffold(body: Center(child: CircularProgressIndicator()));

    final q = questions[index];
    final opts = List<String>.from(q["options"]);

    return Scaffold(
      appBar: AppBar(title: Text(widget.lessonTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LinearProgressIndicator(value: (index + 1) / questions.length),
            SizedBox(height: 16),
            Text(
              q["question"],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ...List.generate(opts.length, (i) {
              return ListTile(
                title: Text(opts[i]),
                leading: Radio<int>(
                  value: i,
                  groupValue: selected,
                  onChanged: (val) => setState(() => selected = val),
                ),
              );
            }),
            Spacer(),
            ElevatedButton(
              onPressed: selected != null ? next : null,
              child: Text(index == questions.length - 1 ? "Finish" : "Next"),
            )
          ],
        ),
      ),
    );
  }
}
