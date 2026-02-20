import 'package:easy_localization/easy_localization.dart';
import 'package:flexedu/features/login_screen/features/componant/sign_up_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/fonts/fonts.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';
import 'package:flexedu/features/login_screen/features/componant/default_text_field.dart';
import 'package:flexedu/features/login_screen/features/componant/login_header.dart';
import 'package:flexedu/features/login_screen/features/cubit/login_cubit.dart';
import 'package:flexedu/features/login_screen/features/cubit/login_state.dart';
import 'package:flexedu/features/login_screen/features/screens/register_screen.dart';
import 'package:flexedu/features/login_screen/features/screens/send_otp.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
              backgroundColor: Theme.of(context).primaryColorLight,
              body: Padding(
                padding: EdgeInsets.only(
                    left: 15.w, right: 15.w, bottom: 15.h, top: 50.h),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Container(
                    height: 600.h,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LoginHeader(txt: 'Forget Password'.tr()),
                        SizedBox(height: 40.h),
                        defaultText(
                            maxLines: 3,
                            txt:
                                'Dont worry, we will send you a link to reset your password'
                                    .tr(),
                            fontSize: 18.sp,
                            color: Theme.of(context).highlightColor,
                            fontWeight: FontWeight.normal),
                        SizedBox(height: 30.h),
                        defaultText(
                            maxLines: 3,
                            txt:
                                'We will send you a link to reset your password'
                                    .tr(),
                            fontSize: 15.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.normal),
                        SizedBox(height: 30.h),
                        DefaultTextField(
                          controller: cubit.emailController,
                          txt: 'Email'.tr(),
                          type: TextInputType.emailAddress,
                          label: 'Email'.tr(),
                          validator: (val) {
                            if (cubit.emailController.text.isEmpty) {
                              return 'Please enter your email'.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 70.h,
                        ),
                        DefaultButton(
                            txt: 'Send code'.tr(),
                            onPress: () {
                              nextPage(context, SendOtp());
                            }),
                        Spacer(),
                       SignUpButton(),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
