import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flexedu/features/login_screen/features/componant/sign_up_button.dart';
import 'package:flexedu/features/login_screen/features/screens/reset_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/fonts/fonts.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button_with_border.dart';
import 'package:flexedu/features/login_screen/features/componant/default_text_field.dart';
import 'package:flexedu/features/login_screen/features/componant/login_header.dart';
import 'package:flexedu/features/login_screen/features/cubit/login_cubit.dart';
import 'package:flexedu/features/login_screen/features/cubit/login_state.dart';
import 'package:flexedu/features/login_screen/features/screens/login_screen.dart';
import 'package:flexedu/features/login_screen/features/screens/register_screen.dart';
import 'package:timer_count_down/timer_count_down.dart';

class SendOtp extends StatefulWidget {
  SendOtp({super.key});

  @override
  State<SendOtp> createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {
  String? resend;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
              backgroundColor: Theme.of(context).primaryColorLight,
              body: SingleChildScrollView(
                keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 12.w, right: 12.w, top: 50.h, bottom: 15.h),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    
                    child: Container(
                      height: 600.h,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoginHeader(txt: 'Verify E-Mail'.tr()),
                          SizedBox(height: 50.h),
                          defaultText(
                              maxLines: 3,
                              txt: 'Enter code sent to your email'.tr(),
                              fontSize: 18.sp,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.normal),
                          SizedBox(height: 20.h),
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: 'We have sent a six-digit'.tr(),
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontFamily: FontFamilies.CAIRO,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: cubit.emailController.text ?? '',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        fontFamily: FontFamilies.CAIRO,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ',
                                      style: TextStyle(
                                        fontFamily: FontFamilies.CAIRO,
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Please enter it to recover your password.'
                                              .tr(),
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        fontFamily: FontFamilies.CAIRO,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ])),
                          SizedBox(height: 40.h),
                          OtpTextField(
                            numberOfFields: 6,
                            borderColor: AppColors.textColor,
                            focusedBorderColor:
                                Theme.of(context).primaryColorDark,
                            //set to true to show as box or false to show as dash
                            showFieldAsBox: true,
                            alignment: Alignment.center,
                            contentPadding: EdgeInsets.all(4),
                            borderRadius: BorderRadius.circular(8),
                            fieldWidth: 46,
                            fieldHeight: 46,
                            autoFocus: true,
                            keyboardType: TextInputType.number,

                            //runs when a code is typed in
                            onCodeChanged: (String code) {},
                            //runs when every textfield is filled
                            onSubmit: (String code) {
                              cubit.verifyOTP(code);
                            }, // end onSubmit
                          ),
                          SizedBox(height: 30.h),
                          Countdown(
                            // controller: controller,
                            seconds: 60,
                            build: (BuildContext context, double time) => Text(
                              time.toString(),
                              style: TextStyle(
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            interval: Duration(
                              seconds: 1,
                            ),
                            onFinished: () {
                              setState(() {
                                resend = 'اعاده ارسال';
                              });
                              print(resend);
                            },
                          ),
                          SizedBox(
                            height: 70.h,
                          ),
                          DefaultButton(
                            txt: 'Send'.tr(),
                            onPress: () {
                              log(cubit.otpCode.toString());
                              // cubit.incorrectOtp();
                              nextPage(context, ResetPassword());
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: defaultText(
                                txt: 'Resnd Code'.tr(),
                                fontSize: 14.sp,
                                color: AppColors.mainColor),
                          ),
                          Spacer(),
                            SignUpButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}
