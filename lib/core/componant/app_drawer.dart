import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/const/const.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';
import 'package:flexedu/features/login_screen/features/screens/login_screen.dart';
import 'package:flexedu/features/splash_screen/screens/settings.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 290.w,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              spacing: 30.h,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    uid == null
                        ? Container(
                            height: 40.h,
                            width: 150.w,
                            child: DefaultButton(
                                txt: 'Login'.tr(),
                                onPress: () {
                                  pop(context);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (_) => LoginScreen()),
                                    (route) => false,
                                  );

                                }))
                        : Column(
                            children: [
                              defaultText(
                                  txt: userEmail.toString(),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600),
                            ],
                          ),
                    InkWell(
                      onTap: () {
                        pop(context);
                      },
                      child: Icon(
                        CupertinoIcons.clear_circled,
                        color: AppColors.mainColor,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    pop(context);
                    // nextPage(context, HomeScreen());
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/home (2).png',
                        height: 30.h,
                        width: 30.w,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      defaultText(
                        txt: 'Home'.tr(),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    pop(context);
                    nextPage(context, SettingsScreen());
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/document.png',
                        height: 30.h,
                        width: 30.w,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      defaultText(
                        txt: 'Settings'.tr(),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    pop(context);
                    // nextPage(context, PrivacyScreen());
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/document.png',
                        height: 30.h,
                        width: 30.w,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      defaultText(
                        txt: 'Terms & Conditions'.tr(),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    pop(context);
                    // nextPage(context, ContactUs());
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/document.png',
                        height: 30.h,
                        width: 30.w,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      defaultText(
                        txt: 'Conect with us'.tr(),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    pop(context);
                    // nextPage(context, PrivacyScreen());
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/document.png',
                        height: 30.h,
                        width: 30.w,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      defaultText(
                        txt: 'About us'.tr(),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
                uid == null
                    ? SizedBox()
                    : InkWell(
                        onTap: () {
                          final alertDialog = CupertinoAlertDialog(
                            title: Text('Logout'.tr()),
                            content:
                                Text('Are you sure you want to logout?'.tr()),
                            actions: [
                              CupertinoDialogAction(
                                child: Text('No'.tr()),
                                onPressed: () {
                                  pop(context);
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text('Yes'.tr()),
                                onPressed: () {
                                  pop(context);
                                  nextPage(context, LoginScreen());
                                },
                              ),
                            ],
                          );
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => alertDialog,
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout_sharp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            defaultText(
                              txt: 'Logout'.tr(),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
