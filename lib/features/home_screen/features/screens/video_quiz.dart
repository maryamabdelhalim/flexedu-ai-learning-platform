// ignore_for_file: unused_field

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_cubit.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;
  Timer? _watchTimer;
  Duration videoWatchTime = Duration.zero;
  late DateTime _activityStartTime;
  late DateTime _quizStartTime;

  final PageController _pageController = PageController();
  bool _startQuiz = false;

  final List<String> questions = [
    "What is the Sun?",
    "How far is the Sun from the Earth?",
    "How long does it take sunlight to reach Earth?",
    "What does the Sun give us?",
    "How hot is the surface of the Sun?",
    "How big is the Sun compared to Earth?",
    "What type of star is the Sun right now?",
    "How old is the Sun?",
    "What will happen to the Sun in a few billion years?",
    "Why is the Sun important to us?",
  ];

  final List<List<String>> options = [
    ["A planet", "A moon", "A star", "A cloud"],
    ["93 miles", "9,300 miles", "93 million miles", "9 billion miles"],
    ["8 seconds", "8 minutes", "8 hours", "8 days"],
    ["Ice", "Light, warmth, and energy", "Food and water", "Rocks and minerals"],
    ["About 100°F", "About 1,000°F", "About 10,000°F", "About 1,000,000°F"],
    ["3 times bigger", "327 times bigger", "3,270 times bigger", "327,000 times bigger"],
    ["A giant star", "A baby star", "A dwarf star", "A frozen star"],
    ["45 years", "4,500 years", "4.5 million years", "4.5 billion years"],
    ["It will disappear", "It will turn into a moon", "It will become a giant star", "It will freeze"],
    ["It helps us sleep", "It gives us toys", "It gives light, warmth, and energy", "It makes the Moon shine"],
  ];

  final List<String> correctAnswers = [
    "A star",
    "93 million miles",
    "8 minutes",
    "Light, warmth, and energy",
    "About 10,000°F",
    "327,000 times bigger",
    "A dwarf star",
    "4.5 billion years",
    "It will become a giant star",
    "It gives light, warmth, and energy",
  ];

  List<String?> selectedAnswers = List.generate(10, (_) => null);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _activityStartTime = DateTime.now();

    _controller = VideoPlayerController.asset('assets/audio/Visual.mp4')
      ..initialize().then((_) {
        setState(() {});
      });

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: false,
      looping: false,
    );

    _watchTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_controller.value.isPlaying) {
        setState(() {
          videoWatchTime += Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController?.dispose();
    _watchTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startQuizAndRecordTime() async {
    final activityTime = DateTime.now().difference(_activityStartTime).inSeconds;
    _quizStartTime = DateTime.now();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final uid = user.uid;

    await FirebaseFirestore.instance.collection('ai_inputs').doc(uid).set({
      'Visual_Activity_Time': activityTime,
    }, SetOptions(merge: true));

    setState(() => _startQuiz = true);
    _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void _goToNextPage() {
    if (_currentIndex < questions.length - 1) {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      _showResult();
    }
  }

  void _showResult() async {
    int correctCount = 0;
    for (int i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == correctAnswers[i]) correctCount++;
    }

    double percentage = (correctCount / questions.length) * 100;
    final quizDuration = DateTime.now().difference(_quizStartTime).inSeconds;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final uid = user.uid;

    await FirebaseFirestore.instance.collection('ai_inputs').doc(uid).set({
      'Visual_Score': correctCount,
      'Visual_Quiz_Time': quizDuration,
      'Visual_Avg_Q_Time': 0,
    }, SetOptions(merge: true));

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Quiz Results'),
        content: Text(
          'Correct Answers: $correctCount / ${questions.length}\n'
          'Score: ${percentage.toStringAsFixed(1)}%',
        ),
        actions: [
          TextButton(
            onPressed: () {
              HomeCubit.get(context).chooseCourseData(
                title: 'Activity 1',
                description: 'topic : Activity 1 Quiz',
                level: 'Beginner',
                progress: percentage.toStringAsFixed(1),
                trueAnswers: '${correctCount / questions.length}',
              );
              HomeCubit.get(context).chooseCourse();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  Widget _buildIntroPage() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          if (_controller.value.isInitialized)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Chewie(controller: _chewieController!),
            )
          else
            Center(child: CircularProgressIndicator()),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(12),
            child: DefaultButton(
              txt: 'Start the quiz',
              onPress: _startQuizAndRecordTime,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionPage(int index) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Question ${index + 1}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(questions[index], style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          ...List.generate(options[index].length, (i) {
            return RadioListTile<String>(
              title: Text(options[index][i]),
              value: options[index][i],
              groupValue: selectedAnswers[index],
              onChanged: (value) {
                setState(() {
                  selectedAnswers[index] = value;
                });
              },
            );
          }),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: selectedAnswers[index] != null
                  ? () {
                      setState(() => _currentIndex++);
                      _goToNextPage();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(index == questions.length - 1 ? 'Finish' : 'Next'),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Activity 1 Quiz')),
      body: PageView.builder(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: questions.length + 1,
        onPageChanged: (i) => setState(() => _currentIndex = i - 1),
        itemBuilder: (context, index) {
          if (index == 0) return _buildIntroPage();
          return _buildQuestionPage(index - 1);
        },
      ),
    );
  }
}
