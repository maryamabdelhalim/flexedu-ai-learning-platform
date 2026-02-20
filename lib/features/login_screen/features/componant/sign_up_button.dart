import 'package:easy_localization/easy_localization.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/fonts/fonts.dart';
import 'package:flexedu/features/login_screen/features/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
                            child: InkWell(
                            focusColor: Colors.transparent,
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                nextPage(context, RegisterScreen());
                              },
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: 'Don\'t have an account?'.tr(),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15.sp,
                                      fontFamily: FontFamilies.CAIRO,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: 'Create Account'.tr(),
                                  style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontFamily: FontFamilies.CAIRO,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ])),
                            ),
                          )
                       ;
  }
}