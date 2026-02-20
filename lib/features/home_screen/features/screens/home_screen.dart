import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/componant/loading.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_cubit.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_state.dart';
import 'package:flexedu/features/home_screen/features/screens/lessons_screen.dart';
import 'package:flexedu/features/home_screen/features/screens/my_learning2.dart';
import 'package:flexedu/features/home_screen/features/screens/notification.dart';
import 'package:flexedu/features/home_screen/features/screens/subscriptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Learning {
  String title;
  String subTitle;
  String footer;
  String image;

  Learning({
    required this.title,
    required this.subTitle,
    required this.footer,
    required this.image,
  });
}

List<Learning> learnings = [
  Learning(
      title: 'hello ',
      subTitle: 'take this quiz to know your learning Style ',
      footer: 'Take the Quiz',
      image: 'assets/images/34.png'),
  Learning(
      title: '',
      subTitle: 'Join Our Community Now for the 12 month Plan 25% OFF ',
      footer: 'Subscribe now!',
      image: 'assets/images/20.png'),
];

List<Learning> learnings2 = [
  Learning(
      title: 'Start Your First Lesson',
      subTitle:
          'improve your knowledge by practicing real life example based on what you learned  ',
      footer: 'Take the Quiz',
      image: 'assets/images/Man2.png'),
  Learning(
      title: 'Start Your Conversation with your AI teacher',
      subTitle:
          'Practice help based on your way of study to make study easier and more fun!',
      footer: 'Take the Quiz',
      image: 'assets/images/28A.png'),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: cubit.userModel == null
                ? LoadingWidget()
                : Stack(
                    children: [
                      Container(
                        color: AppColors.mainColor,
                        height: 400.h,
                        width: double.infinity,
                        padding:
                            EdgeInsets.only(top: 50.h, left: 12.w, right: 12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: Colors.white, width: 1),
                                  ),
                                  child: Image.asset(
                                    'assets/images/image 9.png',
                                    height: 30.h,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3.h, horizontal: 4.w),
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
                                          border: Border.all(
                                              color: AppColors.mainColor, width: 1),
                                        ),
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
                              txt: 'Hello ,',
                              fontSize: 30.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                            Row(
                              children: [
                                defaultText(
                                  txt:
                                      '${cubit.userModel!.firstName} ${cubit.userModel!.lastName}',
                                  fontSize: 30.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                                defaultText(
                                  txt: '👋🏻',
                                  fontSize: 30.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            defaultText(
                              txt: cubit.learningStyle != null
                                  ? 'You are a ${cubit.learningStyle} learner'
                                  : 'Want to know your learning style?',
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 15.h),
                            Container(
                              height: 150.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Container(
                                  padding: EdgeInsets.all(12),
                                  width: 290.w,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: index == 0
                                          ? [Color(0xffF12323), Color(0xffFFEB37)]
                                          : [Color(0xff61FC5F), Color(0xff3BC939)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      defaultText(
                                        txt: learnings[index].title,
                                        fontSize: 15.sp,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 200.w,
                                            child: defaultText(
                                              maxLines: 4,
                                              txt: learnings[index].subTitle,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          Image.asset(
                                            learnings[index].image,
                                            height: 50.h,
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      InkWell(
                                        onTap: () {
                                          if (index == 0) {
                                            nextPage(context, MyLearning2());
                                          } else {
                                            nextPage(context, Subscriptions());
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(9),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: defaultText(
                                              txt: learnings[index].footer,
                                              fontSize: 17.sp,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 15.w),
                                itemCount: learnings.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // bottom half
                      Container(
                        margin: EdgeInsets.only(top: 350.h),
                        padding: EdgeInsets.only(
                            top: 20.h, left: 12.w, right: 12.w),
                        height: 300.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              defaultText(txt: 'Start Learning', fontSize: 25.sp),
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: AppColors.BLACKColor, width: 1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 200.w,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    defaultText(
                                                      maxLines: 2,
                                                      txt: learnings2[index].title,
                                                      fontSize: 17.sp,
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    defaultText(
                                                      maxLines: 4,
                                                      txt: learnings2[index]
                                                          .subTitle,
                                                      fontSize: 11.sp,
                                                      color: AppColors.textColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 15.w),
                                              Image.asset(
                                                learnings2[index].image,
                                                height: 100.h,
                                                width: 50.w,
                                              )
                                            ],
                                          ),
                                          Image.asset(
                                            'assets/images/Group 14.png',
                                            height: 25.h,
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      InkWell(
                                        onTap: () {
                                          cubit.chooseCourseData(
                                            title: learnings2[index].title,
                                            description:
                                                learnings2[index].subTitle,
                                          );
                                          if (cubit.courses != null &&
                                              cubit.courseModel != null &&
                                              cubit.courseModel!.title !=
                                                  learnings2[index].title) {
                                          } else {
                                            cubit.chooseCourse();
                                          }

                                          if (index == 0) {
                                            nextPage(context, Lessons());
                                          } else {
                                            nextPage(context, MyLearning2());
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(9),
                                          decoration: BoxDecoration(
                                            color: AppColors.mainColor,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: defaultText(
                                              txt: 'Start Now',
                                              color: Colors.white,
                                              fontSize: 17.sp,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 15.h),
                                itemCount: learnings2.length,
                              ),
                              SizedBox(height: 30.h),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }
}
