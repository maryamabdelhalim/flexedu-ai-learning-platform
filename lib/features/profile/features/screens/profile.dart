import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/const/const.dart';
import 'package:flexedu/core/database/cache/cache_helper.dart';
import 'package:flexedu/features/dashboard_screen/screens/dashboard_screen.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_cubit.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_state.dart';
import 'package:flexedu/features/home_screen/features/screens/notification.dart';
import 'package:flexedu/features/home_screen/features/screens/subscriptions.dart';
import 'package:flexedu/features/login_screen/features/screens/login_screen.dart';
import 'package:flexedu/features/profile/features/screens/account_setting.dart';
import 'package:flexedu/features/profile/features/screens/feedback_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 50.h, left: 12.w, right: 12.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    spacing: 30.h,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            focusColor: Colors.transparent,
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () {
                              nextPageUntil(context, DashboardScreen());
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
                      defaultText(
                        txt: 'Profile',
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w800,
                      ),

                      // Home
                      _profileButton(
                        context,
                        icon: Image.asset('assets/images/home (1) 1.png', height: 30.h),
                        label: 'Home',
                        onTap: () => nextPageUntil(context, DashboardScreen()),
                      ),

                      // Account Settings
                      _profileButton(
                        context,
                        icon: CircleAvatar(
                          maxRadius: 16,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.person_2, color: Colors.white),
                        ),
                        label: 'Account Settings',
                        onTap: () => nextPage(context, AccountSetting()),
                      ),

                      // Notifications
                      _profileButton(
                        context,
                        icon: CircleAvatar(
                          maxRadius: 16,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.notifications_active, color: Colors.white),
                        ),
                        label: 'Notifications',
                        onTap: () => nextPage(context, NotificationScreen()),
                      ),

                      // Subscriptions
                      _profileButton(
                        context,
                        icon: CircleAvatar(
                          maxRadius: 16,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.subscriptions_outlined, color: Colors.white),
                        ),
                        label: 'Subscriptions',
                        onTap: () => nextPage(context, Subscriptions()),
                      ),

                      // 🚀 New Feedback Button
                      _profileButton(
                        context,
                        icon: Image.asset('assets/images/feedback.png', height: 30.h),
                        label: 'Feedback',
                        onTap: () => nextPage(context, FeedbackScreen()),
                      ),

                      // Logout
                      InkWell(
                        onTap: () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.fixed,
                              duration: Duration(seconds: 10),
                              content: Text('Are you sure you want to log out'),
                              action: SnackBarAction(
                                label: 'yes',
                                onPressed: () async {
                                  await CacheHelper.clear();
                                  await CacheHelper.removeShared(key: AppConst.kLogin);
                                  uid = CacheHelper.getShared(key: AppConst.kLogin);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (_) => LoginScreen()),
                                    (route) => false,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(width: .1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.login_outlined, color: AppColors.mainColor),
                              SizedBox(width: 15.w),
                              defaultText(
                                txt: 'LOGOUT',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _profileButton(BuildContext context,
      {required Widget icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                SizedBox(width: 20.w),
                defaultText(
                  txt: label,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800,
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, color: AppColors.mainColor, weight: 20),
          ],
        ),
      ),
    );
  }
}
