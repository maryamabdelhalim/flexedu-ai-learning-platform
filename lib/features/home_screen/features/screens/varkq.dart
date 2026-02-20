// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';
import 'package:flexedu/core/colors/colors.dart';

class VarkQPage extends StatefulWidget {
  const VarkQPage({super.key});

  @override
  State<VarkQPage> createState() => _VarkQPageState();
}

class _VarkQPageState extends State<VarkQPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _quizStarted = false;
  late DateTime _quizStartTime;

  final Map<String, int> varkScores = {'V': 0, 'A': 0, 'R': 0, 'K': 0};

  final List<String> questions = [
    "I need to find the way to a shop that a friend has recommended. I would:",
    "A website has a video showing how to make a special graph or chart. I would learn most from:",
    "I want to find out more about a tour that I am going on. I would:",
    "When choosing a career or area of study, these are important for me:",
    "When I am learning I:",
    "I want to save more money and to decide between a range of options. I would:",
    "I want to learn how to play a new board game or card game. I would:",
    "I have a problem with my heart. I would prefer that the doctor:",
    "I want to learn to do something new on a computer. I would:",
    "When learning from the Internet I like:",
    "I want to learn about a new project. I would ask for:",
    "I want to learn how to take better photos. I would:",
    "I prefer a presenter or a teacher who uses:",
    "I have finished a competition or test and I would like some feedback. I would like to have feedback:",
    "I want to find out about a house or an apartment. Before visiting it I would want:",
    "I want to assemble a wooden table that came in parts (kitset). I would learn best from:"
  ];

  final List<List<Map<String, String>>> options = [
    [
      {'text': 'find out where the shop is in relation to somewhere I know.', 'cat': 'K'},
      {'text': 'ask my friend to tell me the directions.', 'cat': 'A'},
      {'text': 'write down the street directions I need to remember.', 'cat': 'R'},
      {'text': 'use a map.', 'cat': 'V'}
    ],
    [
      {'text': 'seeing the diagrams.', 'cat': 'V'},
      {'text': 'listening.', 'cat': 'A'},
      {'text': 'reading the words.', 'cat': 'R'},
      {'text': 'watching the actions.', 'cat': 'K'}
    ],
    [
      {'text': 'look at details about the highlights and activities.', 'cat': 'K'},
      {'text': 'use a map and see where the places are.', 'cat': 'V'},
      {'text': 'read about the tour on the itinerary.', 'cat': 'R'},
      {'text': 'talk with the person who planned the tour.', 'cat': 'A'}
    ],
    [
      {'text': 'Applying my knowledge in real situations.', 'cat': 'K'},
      {'text': 'Communicating with others through discussion.', 'cat': 'A'},
      {'text': 'Working with designs, maps or charts.', 'cat': 'V'},
      {'text': 'Using words well in written communications.', 'cat': 'R'}
    ],
    [
      {'text': 'like to talk things through.', 'cat': 'A'},
      {'text': 'see patterns in things.', 'cat': 'V'},
      {'text': 'use examples and applications.', 'cat': 'K'},
      {'text': 'read books, articles and handouts.', 'cat': 'R'}
    ],
    [
      {'text': 'consider examples of each option using my financial info.', 'cat': 'K'},
      {'text': 'read a print brochure.', 'cat': 'R'},
      {'text': 'use graphs showing options.', 'cat': 'V'},
      {'text': 'talk with an expert.', 'cat': 'A'}
    ],
    [
      {'text': 'watch others play before joining.', 'cat': 'K'},
      {'text': 'listen to someone explain.', 'cat': 'A'},
      {'text': 'use diagrams that explain the stages.', 'cat': 'V'},
      {'text': 'read the instructions.', 'cat': 'R'}
    ],
    [
      {'text': 'gave me something to read.', 'cat': 'R'},
      {'text': 'used a plastic model.', 'cat': 'K'},
      {'text': 'described it.', 'cat': 'A'},
      {'text': 'showed me a diagram.', 'cat': 'V'}
    ],
    [
      {'text': 'read the instructions.', 'cat': 'R'},
      {'text': 'talk with people.', 'cat': 'A'},
      {'text': 'start using it and learn by trial.', 'cat': 'K'},
      {'text': 'follow diagrams.', 'cat': 'V'}
    ],
    [
      {'text': 'videos showing how to do or make things.', 'cat': 'K'},
      {'text': 'interesting visual features.', 'cat': 'V'},
      {'text': 'written explanations.', 'cat': 'R'},
      {'text': 'podcasts or interviews.', 'cat': 'A'}
    ],
    [
      {'text': 'diagrams, charts, cost charts.', 'cat': 'V'},
      {'text': 'written report.', 'cat': 'R'},
      {'text': 'discuss the project.', 'cat': 'A'},
      {'text': 'examples of use.', 'cat': 'K'}
    ],
    [
      {'text': 'ask questions and talk about camera.', 'cat': 'A'},
      {'text': 'read written instructions.', 'cat': 'R'},
      {'text': 'diagrams of camera parts.', 'cat': 'V'},
      {'text': 'examples of good/bad photos.', 'cat': 'K'}
    ],
    [
      {'text': 'demonstrations or models.', 'cat': 'K'},
      {'text': 'talks, Q&A, group discussions.', 'cat': 'A'},
      {'text': 'handouts, books.', 'cat': 'R'},
      {'text': 'diagrams, charts.', 'cat': 'V'}
    ],
    [
      {'text': 'examples from what I did.', 'cat': 'K'},
      {'text': 'written description.', 'cat': 'R'},
      {'text': 'someone talk it through.', 'cat': 'A'},
      {'text': 'graphs.', 'cat': 'V'}
    ],
    [
      {'text': 'video of the property.', 'cat': 'K'},
      {'text': 'discussion with owner.', 'cat': 'A'},
      {'text': 'printed description.', 'cat': 'R'},
      {'text': 'plan and map.', 'cat': 'V'}
    ],
    [
      {'text': 'diagrams of each stage.', 'cat': 'V'},
      {'text': 'advice from someone.', 'cat': 'A'},
      {'text': 'written instructions.', 'cat': 'R'},
      {'text': 'watching a video.', 'cat': 'K'}
    ],
  ];

  List<String?> selectedCategories = List.generate(16, (_) => null);

  void _goToNextPage() {
    if (_currentIndex < questions.length) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _showVarkResult();
    }
  }

  void _startQuiz() {
  setState(() => _quizStarted = true);
  _quizStartTime = DateTime.now();
  _goToNextPage();
}


  Future<void> _showVarkResult() async {
    for (final cat in selectedCategories) {
      if (cat != null) varkScores[cat] = varkScores[cat]! + 1;
    }

    final top = varkScores.entries.reduce((a, b) => a.value > b.value ? a : b);
    final learningStyle = {
      'V': 'Visual',
      'A': 'Auditory',
      'R': 'Read/Write',
      'K': 'Kinesthetic'
    }[top.key]!;
    final encoded = {'Visual': 0, 'Auditory': 1, 'Read/Write': 2, 'Kinesthetic': 3}[learningStyle];

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('ai_inputs').doc(uid).set({
        'VARK_Result': encoded,                     // ✅ Corrected
        'VARK_Label': learningStyle,                // ✅ Optional for display
      }, SetOptions(merge: true));

    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('VARK Result'),
        content: Text(
          'Your learning style is: $learningStyle\n\n'
          'Score Breakdown:\nV: ${varkScores['V']}  A: ${varkScores['A']}  R: ${varkScores['R']}  K: ${varkScores['K']}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is the VARK Questionnaire to find out your preferred learning style.\n\nTap "Start" to begin.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            DefaultButton(txt: 'Start', onPress: _startQuiz),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionPage(int index) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Question ${index + 1}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(questions[index], style: TextStyle(fontSize: 16)),
          ...options[index].map((opt) {
            return RadioListTile<String>(
              title: Text(opt['text']!),
              value: opt['cat']!,
              groupValue: selectedCategories[index],
              onChanged: (value) {
                setState(() => selectedCategories[index] = value);
              },
            );
          }),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: selectedCategories[index] != null ? _goToNextPage : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
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
      appBar: AppBar(title: Text('VARK Questionnaire')),
      body: PageView.builder(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: questions.length + 1,
        onPageChanged: (i) => setState(() => _currentIndex = i),
        itemBuilder: (context, index) => index == 0 ? _buildIntroPage() : _buildQuestionPage(index - 1),
      ),
    );
  }
}
