import 'package:easy_localization/easy_localization.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_cubit.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_state.dart';
import 'package:flexedu/features/home_screen/features/screens/subscriptions.dart';
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
import 'package:flexedu/features/profile/features/cubit/profile_cubit.dart';
import 'package:flexedu/features/profile/features/cubit/profile_state.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          cubit.nameController.text =
              cubit.userModel != null ? cubit.userModel!.firstName : '';
          cubit.lastNameController.text =
              cubit.userModel != null ? cubit.userModel!.lastName : '';
          cubit.emailController.text =
              cubit.userModel != null ? cubit.userModel!.email : '';
          // cubit.phoneController.text = cubit.userModel!=null? cubit.userModel!.phone:'';
          return Scaffold(
              backgroundColor: Theme.of(context).primaryColorLight,
              body: cubit.userModel == null
                  ? LoadingWidget()
                  : Padding(
                      padding:
                          EdgeInsets.only(left: 12.w, right: 12.w, top: 50.h),
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                spacing: 10.h,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        focusColor: Colors.transparent,
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        onTap: () {
                                          pop(context);
                                        },
                                        child: Container(
                                          height: 30.h,
                                          width: 30.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            border: Border.all(
                                                color: AppColors.mainColor),
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
                                    txt: 'Account Setting',
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w800,
                                    // color: AppColors.mainColor,
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.h),
                              DefaultTextField(
                                controller: cubit.nameController,
                                txt: 'Name'.tr(),
                                type: TextInputType.emailAddress,
                                label: 'Name'.tr(),
                                // validator: (val) {
                                //   if (val!.isEmpty) {
                                //     return 'Please enter your Name'.tr();
                                //   }
                                //   return null;
                                // },
                              ),
                              SizedBox(height: 20.h),
                              DefaultTextField(
                                controller: cubit.lastNameController,
                                txt: 'lastName'.tr(),
                                type: TextInputType.emailAddress,
                                label: 'lastName'.tr(),
                                // validator: (val) {
                                //   if (val!.isEmpty) {
                                //     return 'Please enter your Name'.tr();
                                //   }
                                //   return null;
                                // },
                              ),
                              SizedBox(height: 20.h),
                              DefaultTextField(
                                controller: cubit.emailController,
                                txt: 'Email'.tr(),
                                type: TextInputType.emailAddress,
                                label: 'Email'.tr(),
                                // validator: (val) {
                                //   if (val!.isEmpty) {
                                //     return 'Please enter your email'.tr();
                                //   }
                                //   return null;
                                // },
                              ),
                              SizedBox(height: 20.h),
                              DefaultTextField(
                                controller: cubit.phoneController,
                                txt: 'Phone'.tr(),
                                type: TextInputType.number,
                                label: 'Phone'.tr(),
                              ),
                              SizedBox(height: 20.h),
                              DefaultTextField(
                                controller: cubit.passwordController,
                                txt: 'Password'.tr(),
                                type: TextInputType.visiblePassword,
                                label: 'Password'.tr(),
                                // validator: (val) {
                                //   if (val!.isEmpty) {
                                //     return 'Please enter your Phone'.tr();
                                //   }
                                //   return null;
                                // },
                              ),
                              SizedBox(height: 20.h),
                              DefaultTextField(
                                controller: cubit.newPasswordController,
                                txt: 'new Password'.tr(),
                                type: TextInputType.visiblePassword,
                                label: 'new Password'.tr(),
                                // validator: (val) {
                                //   if (val!.isEmpty) {
                                //     return 'Please enter your Phone'.tr();
                                //   }
                                //   return null;
                                // },
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  defaultText(
                                      txt: 'Manage Your subscription Plan:'),
                                  InkWell(
                                    onTap: () {
                                      nextPage(context, Subscriptions());
                                    },
                                    child: Container(
                                        width: 100.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                            color: AppColors.greyColor,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Center(
                                            child: defaultText(
                                                txt: 'Free',
                                                fontSize: 16.sp,
                                                color: AppColors.mainColor))),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Row(spacing: 12.w, children: [
                                Expanded(
                                  child: DefaultButton(
                                    onPress: () {
                                      pop(context);
                                    },
                                    txt: 'Cancel'.tr(),
                                  ),
                                ),
                                state is EditProfileLoading
                                    ? LoadingWidget()
                                    : Expanded(
                                        child: DefaultButton(
                                            txt: 'Save'.tr(),
                                            onPress: () {
                                              cubit.editProfile();
                                            }),
                                      ),
                              ]),
                              SizedBox(height: 50.h),
                            ],
                          ),
                        ),
                      ),
                    ));
        });
  }
}
