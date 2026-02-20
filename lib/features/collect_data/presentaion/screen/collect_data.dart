import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/features/collect_data/presentaion/screen/page1.dart';
import 'package:flexedu/features/collect_data/presentaion/screen/page2.dart';
import 'package:flexedu/features/collect_data/presentaion/screen/page3.dart';
import 'package:flexedu/features/collect_data/presentaion/screen/page4.dart';
import 'package:flexedu/features/collect_data/presentaion/screen/page5.dart';
import 'package:flexedu/features/dashboard_screen/screens/dashboard_screen.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_cubit.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_state.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CollectData extends StatefulWidget {
  const CollectData({super.key});

  @override
  State<CollectData> createState() => _CollectDataState();
}

class _CollectDataState extends State<CollectData> {
  int index1 = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserData(),
      child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            HomeCubit cubit = HomeCubit.get(context);
            return Scaffold(
              body: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
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
                              spacing: 5.w,
                              dotColor: const Color.fromARGB(255, 202, 227, 247),
                              activeDotColor: AppColors.mainColor,
                              dotHeight: 10.h,
                              dotWidth: 40.w),
                          count: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            focusColor: Colors.transparent,
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () {
                              pop(context);
                            },
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: AppColors.mainColor),
                              ),
                              child: Icon(
                                CupertinoIcons.back,
                                color: AppColors.mainColor,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 17.r,
                            backgroundImage: AssetImage(
                              'assets/images/image 9.png',
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 530.h,
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          top: 20.h,
                          left: 10.w,
                          right: 10.w,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: SingleChildScrollView(
                          child: Column(
                            spacing: 15.h,
                            children: [
                              Container(
                                height: 440.h,
                                child: PageView(
                                  children: [
                                    Page1(),
                                    Page2(),
                                    Page3(),
                                    Page4(),
                                    Page5(),
                                  ],
                                  controller: controller,
                                  onPageChanged: (value) =>
                                      setState(() => index1 = value),
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
                                        nextPageUntil(context, DashboardScreen());
                                      },
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                  Expanded(
                                      child: DefaultButton(
                                          txt: 'Continue',
                                          onPress: () {
                                            setState(() {
                                              
                                              if (index1 == 4) {
                                                cubit.collectData();
                                              }else{
                                                index1++;
                                              controller.jumpToPage(index1);
                                              }
                                            });
                                          })),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
