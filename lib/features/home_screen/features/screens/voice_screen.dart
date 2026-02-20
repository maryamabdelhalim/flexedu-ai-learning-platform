import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_cubit.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';
import 'package:flexedu/core/colors/colors.dart';

class AudioPage extends StatefulWidget {
  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  final AudioPlayer _player = AudioPlayer();
  Duration audioListenTime = Duration.zero;
  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;
  Timer? _listenTimer;
  late DateTime _quizStart;
  // ignore: unused_field
  bool _startQuiz = false;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    await _player.setAsset('assets/audio/Auditory.mp3');
    totalDuration = await _player.load() ?? Duration.zero;
    _listenTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (_player.playing) {
        audioListenTime += Duration(seconds: 1);
        currentPosition = await _player.position;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    _listenTimer?.cancel();
    super.dispose();
  }

  void _startQuizFlow() {
    final activityTime = audioListenTime.inSeconds;
    _quizStart = DateTime.now();
    _player.pause();

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) return;
    final uid = user.uid;

    FirebaseFirestore.instance.collection("ai_inputs").doc(uid).set({
      "Auditory_Activity_Time": activityTime,
    }, SetOptions(merge: true));

    setState(() => _startQuiz = true);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AudioQuizScreen(startTime: _quizStart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Activity 3 Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Slider(
              value: currentPosition.inSeconds.toDouble(),
              max: totalDuration.inSeconds.toDouble(),
              onChanged: (value) {
                _player.seek(Duration(seconds: value.toInt()));
              },
            ),
            IconButton(
              icon: Icon(_player.playing ? Icons.pause : Icons.play_arrow),
              iconSize: 48,
              onPressed: () {
                setState(() {
                  _player.playing ? _player.pause() : _player.play();
                });
              },
            ),
            Spacer(),
            DefaultButton(txt: 'Start the quiz', onPress: _startQuizFlow),
          ],
        ),
      ),
    );
  }
}

class AudioQuizScreen extends StatefulWidget {
  final DateTime startTime;
  const AudioQuizScreen({required this.startTime});

  @override
  _AudioQuizScreenState createState() => _AudioQuizScreenState();
}

class _AudioQuizScreenState extends State<AudioQuizScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  List<String?> selectedAnswers = List.generate(10, (_) => null);

  final List<String> questions = [
    "What is sound?",
    "What does sound need to travel through?",
    "What happens when you hit a gong?",
    "What do vibrations do to other molecules?",
    "Can sound travel in a vacuum (like space)?",
    "What is \"frequency\" in sound?",
    "If there are more sound waves, what happens to the frequency?",
    "What is the range of sound that humans can hear?",
    "What does a higher frequency sound like?",
    "What do we use to measure how loud sound is?"
  ];

  final List<List<String>> options = [
    ["A color", "A kind of food", "A wave or vibration", "A type of light"],
    ["Stars", "Vacuum", "Matter like solids, liquids, and gases", "Magic"],
    ["Nothing", "It floats", "It causes vibrations", "It turns cold"],
    ["Freeze them", "Make them disappear", "Make them vibrate too", "Paint them"],
    ["Yes", "No"],
    ["How often you eat", "How bright the sound is", "How many sound waves pass a place in a time", "How cold something feels"],
    ["It goes down", "It stays the same", "It gets higher", "It disappears"],
    ["1 to 1,000 Hz", "20 to 20,000 Hz", "100 to 10,000 Hz", "All sounds"],
    ["Lower pitch", "Higher pitch", "No sound", "Slower music"],
    ["Kilometers", "Liters", "Decibels", "Thermometers"]
  ];

  final List<String> correctAnswers = [
    "A wave or vibration",
    "Matter like solids, liquids, and gases",
    "It causes vibrations",
    "Make them vibrate too",
    "No",
    "How many sound waves pass a place in a time",
    "It gets higher",
    "20 to 20,000 Hz",
    "Higher pitch",
    "Decibels"
  ];

  void _goToNextPage() {
    if (_currentIndex < questions.length - 1) {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      _submitResults();
    }
  }

  void _submitResults() async {
    int correctCount = 0;
    for (int i = 0; i < correctAnswers.length; i++) {
      if (selectedAnswers[i] == correctAnswers[i]) {
        correctCount++;
      }
    }

    double percentage = (correctCount / correctAnswers.length) * 100;
    final quizEnd = DateTime.now();
    final quizDuration = quizEnd.difference(widget.startTime).inSeconds;

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('ai_inputs').doc(uid).set({
        'Auditory_Score': correctCount,
        'Auditory_Quiz_Time': quizDuration,
        'Auditory_Avg_Q_Time': 0,
      }, SetOptions(merge: true));
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Quiz Results'),
        content: Text(
          'Correct Answers: $correctCount / ${correctAnswers.length}\n'
          'Score: ${percentage.toStringAsFixed(1)}%',
        ),
        actions: [
          TextButton(
            onPressed: () {
              HomeCubit.get(context).chooseCourseData(
                title: 'Activity 3',
                description: 'topic : Activity 3 Quiz',
                level: 'Beginner',
                progress: percentage.toStringAsFixed(1),
                trueAnswers: '${correctCount / correctAnswers.length}',
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
          ...options[index].map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: selectedAnswers[index],
              onChanged: (value) => setState(() => selectedAnswers[index] = value),
            );
          }).toList(),
          SizedBox(height: 20),
          Align(
  alignment: Alignment.centerRight,
  child: ElevatedButton(
    onPressed: selectedAnswers[index] != null ? _goToNextPage : null,
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.mainColor,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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
      appBar: AppBar(title: Text('Audio Quiz')),
      body: PageView.builder(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: questions.length,
        itemBuilder: (context, index) => _buildQuestionPage(index),
        onPageChanged: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}
