// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_cubit.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_state.dart';
import 'package:flexedu/features/home_screen/features/screens/home_screen.dart';
import 'package:flexedu/features/home_screen/features/screens/lessons_quiz.dart';
import 'package:flexedu/features/home_screen/features/screens/subscriptions.dart';
import 'package:flexedu/features/home_screen/features/screens/notification.dart';
import 'package:flexedu/features/splash_screen/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  // Lesons(
  //     title: 'Past simple',
  //     image: 'assets/images/_0013.png',
  //     description: 'topic : The Aquarium University Trip 🐬'),
  Lesons(
      title: 'Now the Reading && writing',
      image: 'assets/images/_0016.png',
      description: 'topic : What Did you See There 🦀'),
  Lesons(
      title: 'Listening and Match',
      image: 'assets/images/_0010.png',
      description: 'topic : Match your colleges outfits 👕 '),
];

class MyLearning extends StatefulWidget {
  const MyLearning({super.key});

  @override
  State<MyLearning> createState() => _MyLearningState();
}

String? titleCourse;
String? descriptionCourse;
String? priceCourse;
String? levelCourse;
String? progressCourse;
String? trueAnswersCourse;
bool? isSubcripeCourse;

void openQuiz(BuildContext context, String lessonId, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LessonQuizScreen(lessonId: lessonId, lessonTitle: title),
      ),
    );
  }
class _MyLearningState extends State<MyLearning> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 240.h,
                    padding:
                        EdgeInsets.only(top: 50.h, left: 12.w, right: 12.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.r),
                        bottomRight: Radius.circular(30.r),
                      ),
                    ),
                    child: Column(
                      spacing: 30.h,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 3.h, bottom: 3.h, left: 4.w, right: 4.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      nextPage(context, NotificationScreen());
                                    },
                                    child: Image.asset(
                                      'assets/images/notification 1.png',
                                      height: 25.h,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.mainColor,
                                        border: Border.all(
                                            color: AppColors.mainColor,
                                            width: 1)),
                                    child: Image.asset(
                                      'assets/images/23.png',
                                      height: 25.h,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        defaultText(
                          txt: 'My Learning',
                          fontSize: 35.sp,
                          color: Colors.white,
                        ),
                        customProgressBar(.15)
                        // ProgressWithLabel(
                        //   percentage: 0,
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff61FC5F), Color(0xff3BC939)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        defaultText(
                          txt: learnings[1].title,
                          fontSize: 15.sp,
                        ),
                        Row(
                          children: [
                            Container(
                                width: 250.w,
                                child: defaultText(
                                  maxLines: 4,
                                  txt: learnings[1].subTitle,
                                  fontSize: 15.sp,
                                )),
                            Image.asset(
                              learnings[1].image,
                              height: 50.h,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        InkWell(
                          onTap: () {
                            nextPage(context, Subscriptions());
                          },
                          child: Container(
                            padding: EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child: defaultText(
                              txt: learnings[1].footer,
                              fontSize: 17.sp,
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.w, right: 12.w),
                    child: defaultText(txt: 'Chapter 1', fontSize: 25.sp),
                  ),
                                   
                 FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("lessons").get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final lessons = snapshot.data!.docs;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: lessons.length,
            itemBuilder: (_, i) {
              final data = lessons[i].data() as Map<String, dynamic>;
              final lessonId = lessons[i].id;
              final title = data["title"] ?? "Untitled";

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    
                    title: Text(title),
                    onTap: () => openQuiz(context, lessonId, title),
                  ),
                ),
              );
            },
          );
        },
      ),
    
                  SizedBox(
                    height: 40.h,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

Widget customProgressBar( percentage) {
  return Stack(
    alignment: Alignment.centerLeft,
    children: [
      
      Container(
        height: 20,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      
      Container(
        height: 20,
        width: MediaQuery.of(context).size.width * percentage,
        decoration: BoxDecoration(
          color: Colors.yellow[700],
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      
      Positioned(
        left: MediaQuery.of(context).size.width * percentage - 25,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.yellow[700],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            '${(percentage * 100).round()}%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
      )
    ],
  );
}

class ProgressWithLabel extends StatelessWidget {
  final double percentage; // نسبة التقدم بين 0 و 1

  ProgressWithLabel({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        // الخلفية - Linear Progress
        Container(
          height: 25,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
            ),
          ),
        ),

        
        Positioned(
          left: percentage * MediaQuery.of(context).size.width -
              40, 
          child: Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Text(
              "${(percentage * 100).round()}%",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}