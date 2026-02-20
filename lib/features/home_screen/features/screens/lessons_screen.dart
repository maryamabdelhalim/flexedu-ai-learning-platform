import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/features/home_screen/features/screens/notification.dart';
import 'package:flexedu/features/home_screen/features/screens/lesson2_screen.dart';

class Lessons extends StatefulWidget {
  const Lessons({super.key});

  @override
  State<Lessons> createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  String? learningStyle;

  @override
  void initState() {
    super.initState();
    fetchLearningStyle();
  }

  Future<void> fetchLearningStyle() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    setState(() {
      learningStyle = doc.data()?['learningStyle'];
    });
  }

  void handleLessonTap(String lessonId, String title) {
    if (learningStyle == null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Learning Style Required'),
          content:
              const Text('Please take the learning style quiz first to continue.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Lesson2(
          lessonId: lessonId,
          lessonTitle: title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top Blue Header
          Container(
            height: 240.h,
            padding: EdgeInsets.only(top: 50.h, left: 12.w, right: 12.w),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
            ),
            child: Column(
              children: [
                // Back + Notification + Avatar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
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
                          SizedBox(width: 10.w),
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.mainColor,
                              border: Border.all(color: AppColors.mainColor),
                            ),
                            child: Image.asset(
                              'assets/images/23.png',
                              height: 25.h,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                defaultText(
                  txt: 'My Learning',
                  fontSize: 35.sp,
                  color: Colors.white,
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: defaultText(txt: 'Chapter 1', fontSize: 22.sp),
            ),
          ),

          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection("lessons").get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No lessons available."));
                }

                final lessons = snapshot.data!.docs;

                return ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: lessons.length,
                  itemBuilder: (_, i) {
                    final data = lessons[i].data() as Map<String, dynamic>;
                    final title = data['title'] ?? 'Untitled';
                    final lessonId = lessons[i].id;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () => handleLessonTap(lessonId, title),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "$title",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
