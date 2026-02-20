import 'package:easy_localization/easy_localization.dart';
import 'package:flexedu/features/login_screen/features/componant/login_header.dart';
import 'package:flexedu/features/login_screen/features/componant/sign_up_button.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/componant/error_message.dart';
import 'package:flexedu/core/componant/loading.dart';
import 'package:flexedu/core/const/const.dart';
import 'package:flexedu/core/fonts/fonts.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';
import 'package:flexedu/features/login_screen/features/componant/default_text_field.dart';
import 'package:flexedu/features/login_screen/features/cubit/login_cubit.dart';
import 'package:flexedu/features/login_screen/features/cubit/login_state.dart';
import 'package:flexedu/features/login_screen/features/screens/forget_password.dart';
import 'package:flexedu/features/login_screen/features/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        var formKey = GlobalKey<FormState>();

        return Scaffold(
          backgroundColor: Theme.of(context).primaryColorLight,
          body: Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              top: 50.h,
              bottom: 15.h,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoginHeader(txt: 'Sign In'.tr()),
                    defaultText(
                      txt: 'Enter Your Account Info To get Access',
                      color: AppColors.textColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(height: 10.h),
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
                    SizedBox(height: 10.h),
                    DefaultTextField(
                      obscure: true,
                      controller: cubit.passwordController,
                      txt: 'Password'.tr(),
                      type: TextInputType.visiblePassword,
                      label: 'Password'.tr(),
                      validator: (val) {
                        if (cubit.passwordController.text.isEmpty) {
                          return 'Please enter your Password'.tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            onChanged: (value) => cubit.changeCheck(value),
                            value: cubit.isCheck,
                            activeColor: AppColors.mainColor,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: defaultText(
                              txt: 'Remember Account'.tr(),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            nextPage(context, ForgetPassword());
                          },
                          child: defaultText(
                            txt: 'Forgot Password'.tr(),
                            fontSize: 15.sp,
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    state is LoginLoading
                        ? LoadingWidget()
                        : DefaultButton(
                            txt: 'Login'.tr(),
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                cubit.Login();
                              } else {
                                errorMasseges('Please fill all fields'.tr());
                              }
                            },
                          ),
                    SizedBox(height: 30.h),
                    SignUpButton(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
