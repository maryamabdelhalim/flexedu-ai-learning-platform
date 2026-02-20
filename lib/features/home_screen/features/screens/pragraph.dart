import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_cubit.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flexedu/core/colors/colors.dart';

class ParagraphPage extends StatefulWidget {
  const ParagraphPage({super.key});

  @override
  State<ParagraphPage> createState() => _ParagraphPageState();
}

class _ParagraphPageState extends State<ParagraphPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  late DateTime _activityStartTime;
  late DateTime _quizStartTime;
  // ignore: unused_field
  bool _startQuiz = false;

  final List<String> questions = [
    "What is the first step of the water cycle?",
    "What makes water evaporate?",
    "Where does condensation happen?",
    "What do you become during condensation?",
    "What happens when a cloud gets too full?",
    "What is it called when water falls from the sky?",
    "Where does water go after it falls to Earth?",
    "What is the last step of the cycle before it starts again?",
    "What do you act like in the kinesthetic activity?",
    "Why is the water cycle important?",
  ];

  final List<List<String>> options = [
    ["Condensation", "Precipitation", "Evaporation", "Collection"],
    ["Cold air", "Darkness", "The Sun’s heat", "Moonlight"],
    ["Underground", "In the clouds", "On the ground", "In your house"],
    ["A snowflake", "A puddle", "A cloud droplet", "A tree"],
    ["It grows bigger", "It turns red", "It disappears", "It rains or snows"],
    ["Condensation", "Freezing", "Precipitation", "Collection"],
    ["Into space", "To your shoes", "Into rivers, lakes, and oceans", "It stays in the sky"],
    ["Condensation", "Evaporation", "Collection", "Wind"],
    ["A tree", "A rainbow", "A water droplet", "A fish"],
    ["It keeps the sky full", "It gives us water to drink and helps plants grow", "It makes us sleepy", "It changes the seasons"],
  ];

  final List<String> correctAnswers = [
    "Evaporation",
    "The Sun’s heat",
    "In the clouds",
    "A cloud droplet",
    "It rains or snows",
    "Precipitation",
    "Into rivers, lakes, and oceans",
    "Collection",
    "A water droplet",
    "It gives us water to drink and helps plants grow",
  ];

  List<String?> selectedAnswers = List.generate(10, (_) => null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _activityStartTime = DateTime.now();
    });
  }

  void _startQuizAndRecordTime() {
    final activityTime = DateTime.now().difference(_activityStartTime).inSeconds;
    _quizStartTime = DateTime.now();

    setState(() => _startQuiz = true);

    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    _storeActivityTime(activityTime);
  }

  Future<void> _storeActivityTime(int activityTime) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final uid = user.uid;

    try {
      await FirebaseFirestore.instance.collection('ai_inputs').doc(uid).set({
        'Kinesthetic_Activity_Time': activityTime,
      }, SetOptions(merge: true));
    } catch (e) {
      print('Firestore error: $e');
    }
  }

  void _goToNextPage() {
    if (_currentIndex < questions.length) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _showResult();
    }
  }

  void _showResult() async {
    int correctCount = 0;
    for (int i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == correctAnswers[i]) {
        correctCount++;
      }
    }

    double percentage = (correctCount / questions.length) * 100;
    final quizDuration = DateTime.now().difference(_quizStartTime).inSeconds;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final uid = user.uid;

    try {
      await FirebaseFirestore.instance.collection('ai_inputs').doc(uid).set({
        'Kinesthetic_Score': correctCount,
        'Kinesthetic_Quiz_Time': quizDuration,
        'Kinesthetic_Avg_Q_Time': 0,
      }, SetOptions(merge: true));
    } catch (e) {
      print('Firestore error: $e');
    }

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
                title: 'Activity 4',
                description: 'topic : Activity 4 Quiz',
                level: 'Beginner',
                progress: percentage.toStringAsFixed(1),
                trueAnswers: '${correctCount / questions.length}',
              );
              HomeCubit.get(context).chooseCourse();
              Navigator.of(context).popUntil((r) => r.isFirst);
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              '''Hi there, little droplet! You're about to go on an amazing journey through the water cycle. Let’s move together!

You're in a warm lake, splashing around. The sun is shining bright. Feel it? It’s getting hot!
Now slowly rise up, rise high into the sky. Wave your arms like steam, stretch tall on your toes.
This is called evaporation — when water gets warm and turns into vapor!

Now you're up in the sky. It’s cool up here!
Curl into a little ball — you’re becoming a tiny cloud droplet!
Lots of other droplets are joining you. This is called condensation — when water vapor turns into clouds.

You’re getting heavier now. The cloud is full. Get ready!
Jump or fall gently — you’re rain, snow, or hail now!
This is called precipitation — when water falls back to Earth.

You’ve landed back on Earth — maybe in a river, ocean, or puddle.
Swim or crawl around on the ground. This is collection.
All the water gathers here before it evaporates again.''',
              style: TextStyle(fontSize: 12, height: 1.5),
            ),
            SizedBox(height: 30),
            DefaultButton(
              txt: 'Start',
              onPress: _startQuizAndRecordTime,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionPage(int index) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${index + 1}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            questions[index],
            style: TextStyle(fontSize: 18),
          ),
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
                  ? _goToNextPage
                  : null,
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
      appBar: AppBar(title: Text('Activity 4 Quiz')),
      body: PageView.builder(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: questions.length + 1,
        onPageChanged: (i) => setState(() => _currentIndex = i),
        itemBuilder: (context, index) {
          if (index == 0) return _buildIntroPage();
          return _buildQuestionPage(index - 1);
        },
      ),
    );
  }
}
