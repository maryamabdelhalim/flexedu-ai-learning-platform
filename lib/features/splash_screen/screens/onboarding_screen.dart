import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';
import 'package:flexedu/features/login_screen/features/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageScreen {
  String? image;
  String? title;
  String? icon;
  String? subtitle;
  String? desc;
  PageScreen({this.image, this.title, this.subtitle, this.icon, this.desc});
}

List<PageScreen> pages = [
  PageScreen(
      image: 'assets/images/Ellipse 1.png',
      title: 'Welcome To Flexedu ',
      subtitle: 'World',
      icon: 'assets/images/hand.png',
      desc:
          'Explore the wonders of science with personalized lessons made just for you'),
  PageScreen(
      image: 'assets/images/perspective_matte-24-128x128 1.png',
      title: 'Explore With ',
      subtitle: 'Curiosity',
      icon: 'assets/images/audio.png',
      desc: 'Ask scientific questions and get instant AI-powered answers'),
  PageScreen(
      image: 'assets/images/camera-icon 1.png',
      title: 'AI-Powered Science content',
      subtitle: 'for your learning objectives',
      icon: 'assets/images/perspective_matte-212-128x128 1.png',
      desc:'Learn physics, biology, and chemistry through customized video lessons'),
];

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int index1 = 0;
  var pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Padding(
        padding: EdgeInsets.only(
          top: 60.h,
          left: 10.w,
          right: 10.w,
        ),
        child: Column(
          spacing: 20.h,
          children: [
            AnimatedSmoothIndicator(
                activeIndex: index1,
                effect: ExpandingDotsEffect(
                    spacing: 10.w,
                    dotColor: Colors.white24,
                    activeDotColor: Colors.white,
                    dotHeight: 10.h,
                    dotWidth: 50.w),
                count: pages.length),
            Container(
              height: 550.h,
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 20.h,
                left: 10.w,
                right: 10.w,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 15.h,
                  children: [
                    Container(
                      height: 440.h,
                      child: PageView.builder(
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 20.h,
                            children: [
                              Image.asset(
                                pages[index].image.toString(),
                                height: 200.h,
                                width: 120,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  defaultText(
                                    txt: '${pages[index].title}',
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  Container(
                                    width: 280.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: defaultText(
                                            maxLines: 3,
                                            txt: '${pages[index].subtitle}',
                                            fontSize: 30.sp,
                                            color: AppColors.mainColor,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Image.asset(
                                          '${pages[index].icon}',
                                          height: 30.h,
                                          width: 30.w,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              defaultText(
                                maxLines: 3,
                                txt: '${pages[index].desc}',
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          );
                        },
                        controller: pageController,
                        itemCount: pages.length,
                        onPageChanged: (index) {
                          setState(() {
                            index1 = index;
                          });
                        },
                      ),
                    ),
                    Row(
                      spacing: 15.w,
                      children: [
                        Expanded(
                          child: DefaultButton(
                            txtColor: AppColors.mainColor,
                            txt: 'Skip',
                            onPress: () {
                              nextPageUntil(context, AuthScreen());
                            },
                            color: AppColors.greyColor,
                          ),
                        ),
                        Expanded(
                            child: DefaultButton(
                                txt: 'Continue',
                                onPress: () {
                                  setState(() {
                                    if (index1 < pages.length - 1) {
                                      index1++;
                                      pageController.jumpToPage(index1);
                                    } else {
                                      nextPageUntil(context, AuthScreen());
                                    }
                                  });
                                })),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 5,
              width: 150.w,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
