import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/componant/error_message.dart';
import 'package:flexedu/core/componant/loading.dart';
import 'package:flexedu/core/fonts/fonts.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';
import 'package:flexedu/features/login_screen/features/componant/default_text_field.dart';
import 'package:flexedu/features/login_screen/features/componant/login_header.dart';
import 'package:flexedu/features/login_screen/features/cubit/login_cubit.dart';
import 'package:flexedu/features/login_screen/features/cubit/login_state.dart';
import 'package:flexedu/features/login_screen/features/screens/login_screen.dart';
import 'package:flexedu/features/login_screen/features/screens/send_otp.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String passwordStrength = '';

  String getPasswordStrength(String password) {
    if (password.length < 3) return "ضعيف";

    bool hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
    bool hasDigit = RegExp(r'\d').hasMatch(password);
    bool hasSpecial = RegExp(r'[!@#\$&*~]').hasMatch(password);
    int strength = 0;
    if (hasLetter) strength++;
    if (hasDigit) strength++;
    if (hasSpecial) strength++;

    if (strength == 3 && password.length >= 8) return "قوي";
    if (strength >= 2) return "متوسط";
    return "ضعيف";
  }

  Color getStrengthColor(String strength) {
    switch (strength) {
      case "قوي":
        return Colors.green;
      case "متوسط":
        return Colors.orange;
      case "ضعيف":
      default:
        return Colors.red;
    }
  }

  int getStrengthLevel(String strength) {
    switch (strength) {
      case "قوي":
        return 3;
      case "متوسط":
        return 2;
      case "ضعيف":
      default:
        return 1;
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
              backgroundColor: Theme.of(context).primaryColorLight,
              body: Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 50.h),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Form(
                    key: formKey,
                    child: Column(
                      spacing: 10.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LoginHeader(txt: 'Sign Up'.tr()),
                        defaultText(
                            txt: 'Enter Your Account Info To get Create!',
                            fontSize: 12.sp,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.normal),
                        DefaultTextField(
                          controller: cubit.firstNameController,
                          txt: 'First name'.tr(),
                          type: TextInputType.emailAddress,
                          label: 'First name'.tr(),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please enter your First name'.tr();
                            }
                            return null;
                          },
                        ),
                        DefaultTextField(
                          controller: cubit.lastNameController,
                          txt: 'Last name'.tr(),
                          type: TextInputType.emailAddress,
                          label: 'Last name'.tr(),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please enter your Last name'.tr();
                            }
                            return null;
                          },
                        ),
                        DefaultTextField(
                          controller: cubit.emailController,
                          txt: 'Email'.tr(),
                          type: TextInputType.emailAddress,
                          label: 'Email'.tr(),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please enter your email'.tr();
                            }
                            return null;
                          },
                        ),

                        /// Password Field
                        DefaultTextField(
                          obscure: true,
                          controller: cubit.passwordController,
                          txt: 'Password'.tr(),
                          type: TextInputType.visiblePassword,
                          label: 'Password'.tr(),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please enter your Password'.tr();
                            }
                            return null;
                          },
                        ),

                        /// Strength Indicator
                        CheckboxListTile(
                          controlAffinity:
                                    ListTileControlAffinity.leading,
                            value: cubit.isAgree,
                            activeColor: AppColors.mainColor,
                            enabled: true,
                            onChanged: (value) {
                              cubit.changeAgree(value);
                            },
                            title: defaultText(
                                maxLines: 2,
                                color: AppColors.textColor,
                                txt:
                                    'I Agree to terms of Use & Privacy Policy')),
                        SizedBox(height: 30.h),
                        state is RegisterLoading
                            ? LoadingWidget()
                            : DefaultButton(
                                txt: 'Register'.tr(),
                                onPress: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.register();
                                  } else {
                                    errorMasseges(
                                        'Please fill all fields'.tr());
                                  }
                                }),
                        // SizedBox(height: 50.h),
                        // Center(
                        //   child: InkWell(
                        //     onTap: () => nextPage(context, LoginScreen()),
                        //     child: RichText(
                        //       text: TextSpan(children: [
                        //         TextSpan(
                        //           text: 'have an account?'.tr(),
                        //           style: TextStyle(
                        //               color: Theme.of(context).primaryColor,
                        //               fontSize: 15.sp,
                        //               fontFamily: FontFamilies.CAIRO,
                        //               fontWeight: FontWeight.w400),
                        //         ),
                        //         TextSpan(
                        //           text: 'Login'.tr(),
                        //           style: TextStyle(
                        //               color: AppColors.mainColor,
                        //               fontFamily: FontFamilies.CAIRO,
                        //               fontSize: 15.sp,
                        //               fontWeight: FontWeight.w600),
                        //         ),
                        //       ]),
                        //     ),
                        //   ),
                        // ),

                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
