import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_cubit.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flexedu/core/colors/colors.dart';

class WaterCycleQuizPage extends StatefulWidget {
  @override
  _WaterCycleQuizPageState createState() => _WaterCycleQuizPageState();
}

class _WaterCycleQuizPageState extends State<WaterCycleQuizPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  // ignore: unused_field
  bool _startQuiz = false;

  late DateTime _activityStartTime;
  late DateTime _quizStartTime;

  final List<String> questions = [
    "What is the Moon?",
    "What does the Moon move around?",
    "Why does the Moon shine?",
    "What are the shapes of the Moon called?",
    "How long does it take the Moon to go through all its phases?",
    "What does the Moon help cause on Earth?",
    "Can people breathe or grow food on the Moon?",
    "Who has walked on the Moon?",
    "What are craters on the Moon?",
    "What colors can the Moon look like at night?"
  ];

  final List<List<String>> options = [
    ["A star", "A planet", "A big rock that moves around Earth", "A cloud"],
    ["The Sun", "The Earth", "Mars", "The stars"],
    ["It has lights inside", "It glows in the dark", "It reflects light from the Sun", "It’s made of glass"],
    ["Shadows", "Light shows", "Moon phases", "Moon tricks"],
    ["One day", "One week", "One month", "One year"],
    ["Earthquakes", "Tides in the ocean", "Lightning", "Volcanoes"],
    ["Yes, easily", "Only animals can", "No, there is no air or water", "Only at night"],
    ["Dinosaurs", "Astronauts", "Firefighters", "Aliens"],
    ["Mountains", "Big holes made by rocks", "Moon caves", "Telescopes"],
    ["Red and green", "Blue and purple", "White, gray, or orange", "Pink and black"],
  ];

  final List<String> correctAnswers = [
    "A big rock that moves around Earth",
    "The Earth",
    "It reflects light from the Sun",
    "Moon phases",
    "One month",
    "Tides in the ocean",
    "No, there is no air or water",
    "Astronauts",
    "Big holes made by rocks",
    "White, gray, or orange",
  ];

  List<String?> selectedAnswers = List.generate(10, (_) => null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _activityStartTime = DateTime.now();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
  if (_currentIndex < questions.length - 1) {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  } else {
    _showResult();
  }
}


  void _startQuizAndRecordTime() {
    final activityTime = DateTime.now().difference(_activityStartTime).inSeconds;
    _quizStartTime = DateTime.now();

    setState(() => _startQuiz = true);

    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    _storeReadWriteActivityTime(activityTime);
  }

  Future<void> _storeReadWriteActivityTime(int activityTime) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User must be logged in.");
    final uid = user.uid;

    await FirebaseFirestore.instance.collection('ai_inputs').doc(uid).set({
      'Read/Write_Activity_Time': activityTime,
    }, SetOptions(merge: true));
  }

  void _showResult() async {
    int correctCount = 0;
    for (int i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == correctAnswers[i]) {
        correctCount++;
      }
    }
    double percentage = (correctCount / questions.length) * 100;

    final quizEndTime = DateTime.now();
    final quizDuration = quizEndTime.difference(_quizStartTime).inSeconds;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User must be logged in.");
    final uid = user.uid;

    await FirebaseFirestore.instance.collection('ai_inputs').doc(uid).set({
      'Read/Write_Score': correctCount,
      'Read/Write_Quiz_Time': quizDuration,
      'Read/Write_Avg_Q_Time': 0,
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
                title: 'Activity 2',
                description: 'topic : Activity 2 Quiz',
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              '''What Is the Moon?
The Moon is a big, round rock that moves around the Earth. It is our planet’s only natural satellite. That means it travels around the Earth in space, just like Earth travels around the Sun. The Moon doesn’t make its own light — it shines because it reflects light from the Sun.

The Moon looks different at different times. Sometimes it looks full and round. Other times, we see only part of it, like a half moon or a tiny sliver called a crescent. These shapes are called moon phases. The Moon takes about one month to go through all its phases.

The Moon affects the oceans too! It helps cause tides, which are the rising and falling of ocean water.

There is no air or water on the Moon. That means people can’t breathe or grow food there. But astronauts have visited the Moon in spaceships and walked on its surface!

At night, the Moon can look white, gray, or even orange. If you look closely with a telescope, you can see big holes called craters. These were made by rocks that hit the Moon a long time ago.

The Moon is amazing and fun to learn about!''',
              style: TextStyle(fontSize: 12, height: 1.5),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(12),
              child: DefaultButton(
                txt: 'Start',
                onPress: _startQuizAndRecordTime,
              ),
            )
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
      appBar: AppBar(title: Text('Activity 2 Quiz')),
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
