import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_cubit.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_state.dart';
import 'package:flexedu/features/home_screen/features/screens/pragraph.dart';
import 'package:flexedu/features/home_screen/features/screens/video_quiz.dart';
import 'package:flexedu/features/home_screen/features/screens/voice_screen.dart';
import 'package:flexedu/features/home_screen/features/screens/write_quiz_screen.dart';
import 'package:flexedu/features/home_screen/features/screens/detect.dart';
import 'package:flexedu/features/home_screen/features/screens/varkq.dart';

class Lesons {
  String title;
  String image;
  String description;

  Lesons({
    required this.title,
    required this.image,
    required this.description,
  });
}

List<Lesons> lessons = [
  Lesons(title: 'activity 1', image: 'assets/images/_0013.png', description: ''),
  Lesons(title: 'activity 2', image: 'assets/images/_0016.png', description: ''),
  Lesons(title: 'activity 3', image: 'assets/images/_0010.png', description: ''),
  Lesons(title: 'activity 4', image: 'assets/images/_0010.png', description: ''),
  Lesons(title: 'activity 5', image: 'assets/images/_0016.png', description: ''),
];

class MyLearning2 extends StatefulWidget {
  const MyLearning2({super.key});

  @override
  State<MyLearning2> createState() => _MyLearning2State();
}

class _MyLearning2State extends State<MyLearning2> {
  Set<int> completedActivities = {};

  @override
  void initState() {
    super.initState();
    fetchCompletedActivities();
  }

  Future<void> fetchCompletedActivities() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance.collection('ai_inputs').doc(user.uid).get();

    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        if (data.containsKey('Visual_Score')) completedActivities.add(0);
        if (data.containsKey('Read/Write_Score')) completedActivities.add(1);
        if (data.containsKey('Auditory_Score')) completedActivities.add(2);
        if (data.containsKey('Kinesthetic_Score')) completedActivities.add(3);
        if (data.containsKey('VARK_Label')) completedActivities.add(4);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("My Learning"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      cubit.chooseCourseData(
                        level: lessons[index].title,
                        description: lessons[index].description,
                        isSubcripe: false,
                      );

                      if (index == 2) {
                        nextPage(context, AudioPage());
                      } else if (index == 0) {
                        nextPage(context, VideoPage());
                      } else if (index == 3) {
                        nextPage(context, ParagraphPage());
                      } else if (index == 1) {
                        nextPage(context, WaterCycleQuizPage());
                      } else if (index == 4) {
                        nextPage(context, VarkQPage());
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.mainColor, width: 3),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            lessons[index].image,
                            height: 70.h,
                            width: 30.w,
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            width: 200.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: defaultText(
                                        maxLines: 2,
                                        txt: lessons[index].title,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    if (completedActivities.contains(index))
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          '✅',
                                          style: TextStyle(fontSize: 18.sp),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                defaultText(
                                  maxLines: 3,
                                  txt: lessons[index].description,
                                  color: AppColors.textColor,
                                  fontSize: 13.sp,
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 40),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 20.h),
                  itemCount: lessons.length,
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user == null) return;

                        final userId = user.uid;

                        try {
                          final response = await http.post(
                            Uri.parse('http://192.168.1.8:5000/predict-style'),
                            headers: {'Content-Type': 'application/json'},
                            body: jsonEncode({'user_id': userId}),
                          );

                          if (response.statusCode == 200) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => DetectPage()),
                            );
                          } else {
                            print("API Error: ${response.body}");
                          }
                        } catch (e) {
                          print("Flask API connection error: $e");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Detect Learning Style',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
