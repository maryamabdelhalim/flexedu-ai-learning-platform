import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';
import 'package:flexedu/features/login_screen/features/screens/login_screen.dart';
import 'package:flexedu/features/login_screen/features/screens/register_screen.dart';
import 'package:flexedu/features/login_screen/services/google_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Padding(
        padding: EdgeInsets.only(
          top: 80.h,
          left: 10.w,
          right: 10.w,
        ),
        child: Column(
          spacing: 20.h,
          children: [
            Container(
              height: 570.h,
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
                  spacing: 35.h,
                  children: [
                    Image.asset(
                      'assets/images/Logo (1).png',
                      height: 130.h,
                      width: 307.h,
                    ),
                    defaultText(
                        maxLines: 3,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        txt:
                            'See your words convert to animated videos, where learning becomes more fun now!'),
                    Column(
                      spacing: 10.h,
                      children: [
                        Container(
                            width: 200.w,
                            child: DefaultButton(
                                txt: 'Sign Up',
                                onPress: () {
                                  nextPage(context, RegisterScreen());
                                })),
                        Container(
                          width: 200.w,
                          child: DefaultButton(
                            txt: 'Sign In',
                            onPress: () {
                              nextPage(context, LoginScreen());
                            },
                            color: AppColors.greyColor,
                            txtColor: AppColors.mainColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      spacing: 15.h,
                      children: [
                        Row(
                          spacing: 10.w,
                          children: [
                            Container(
                              height: 1.h,
                              width: 100.w,
                              color: AppColors.textColor,
                            ),
                            defaultText(
                                txt: 'Or continue with',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400),
                            Container(
                              height: 1.h,
                              width: 100.w,
                              color: AppColors.textColor,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final user = await GoogleAuthService.signInWithGoogle();
                                if (user != null) {
                                  // Navigate to next screen
                                  print("Logged in as ${user.user!.displayName}");
                                }
                              },
                              child: Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: AppColors.mainColor, width: 1),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/search 1.png',
                                    height: 30.h,
                                    width: 30.w,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
