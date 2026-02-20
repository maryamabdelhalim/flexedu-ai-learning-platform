import 'package:flexedu/features/home_screen/features/cubit/home_cubit.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class WaterCycleQuiz extends StatefulWidget {
  @override
  _WaterCycleQuizState createState() => _WaterCycleQuizState();
}

class _WaterCycleQuizState extends State<WaterCycleQuiz> {
  final PageController _pageController = PageController();
  final AudioPlayer _audioPlayer = AudioPlayer();

  int _currentIndex = 0;
  int _correctAnswers = 0;
  List<String?> _selectedAnswers = List.filled(5, null);

  final List<Map<String, dynamic>> _questions = [
    {
      "question": "What is the first step of the water cycle?",
      "options": ["Precipitation", "Condensation", "Evaporation", "Collection"],
      "correct": "Evaporation",
      "audio": "auditory/water1.mp3"
    },
    {
      "question": "What happens when water vapor cools down?",
      "options": ["It disappears", "It forms clouds", "It rains immediately", "It becomes ice"],
      "correct": "It forms clouds",
      "audio": "auditory/water2.mp3"
    },
    {
      "question": "What causes water to evaporate?",
      "options": ["Cold air", "Moonlight", "The Sun", "Wind"],
      "correct": "The Sun",
      "audio": "auditory/water3.mp3"
    },
    {
      "question": "What is the last step of the water cycle?",
      "options": ["Evaporation", "Collection", "Condensation", "Precipitation"],
      "correct": "Collection",
      "audio": "auditory/water4.mp3"
    },
    {
      "question": "Where does water collect at the end?",
      "options": ["Trees", "Sky", "Soil and oceans", "Mountains"],
      "correct": "Soil and oceans",
      "audio": "auditory/water5.mp3"
    }
  ];

  @override
  void initState() {
    super.initState();
    _playIntro();
  }

  void _playIntro() async {
    await _audioPlayer.play(AssetSource('audio/The Water Cycle! Science For Kids.mp3'));
  }

  void _playQuestionAudio(int index) async {
    await _audioPlayer.play(AssetSource(_questions[index]['audio']));
  }

  void _nextPage() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      _playQuestionAudio(_currentIndex);
    } else {
      _calculateResults();
    }
  }

  void _calculateResults() {
    _correctAnswers = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i]['correct']) {
        _correctAnswers++;
      }
    }
    double percent = (_correctAnswers / _questions.length) * 100;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Quiz Results"),
        content: Text("Correct Answers: $_correctAnswers / ${_questions.length}\nScore: ${percent.toStringAsFixed(1)}%"),
        actions: [
          TextButton(
            onPressed: () {
             HomeCubit.get(context).chooseCourseData(
                // isSubcripe: false,
                title: 'Water Cycle Quiz',
                description: 'topic : Water Cycle',
                level: 'Beginner',
                 progress:percent.toStringAsFixed(1),
                 trueAnswers: '${_correctAnswers / _questions.length}',

              );
                HomeCubit.get(context).chooseCourse();
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          )
        ],
      )
    );
  }

  Widget _buildIntroPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome to the Water Cycle Quiz!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(12),
          child: DefaultButton(txt: 'Start ', onPress: (){
             _playQuestionAudio(0);
                _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
             
          }),
        )
        ],
      ),
    );
  }

  Widget _buildQuestionPage(int index) {
    final q = _questions[index];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Question ${index + 1}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(q['question'], style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          ...q['options'].map<Widget>((option) => RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: _selectedAnswers[index],
            onChanged: (val) {
              setState(() => _selectedAnswers[index] = val);
            },
          )),
          Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _selectedAnswers[index] != null ? _nextPage : null,
              child: Text(index == _questions.length - 1 ? "Finish" : "Next")
            )
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Water Cycle Quiz")),
      body: PageView.builder(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _questions.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) return _buildIntroPage();
          return _buildQuestionPage(index - 1);
        },
      ),
    );
  }
}
