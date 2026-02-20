import 'package:easy_localization/easy_localization.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/componant/error_message.dart';
import 'package:flexedu/core/componant/success_message.dart';
import 'package:flexedu/features/dashboard_screen/screens/dashboard_screen.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_cubit.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_state.dart';
import 'package:flexedu/features/login_screen/features/componant/login_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paymob_payment/paymob_payment.dart';

class Subscriptions extends StatelessWidget {
  const Subscriptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.only(top: 50.h, left: 12.w, right: 12.w),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  spacing: 20.h,
                  children: [
                    LoginHeader(txt: 'Choose Plan'),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.mainColor),
                      ),
                      child: Column(
                        // spacing: 15.h,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                spacing: 15.h,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: AppColors.mainColor,
                                    ),
                                    child: Center(
                                        child: defaultText(
                                            txt: 'Free Plan',
                                            color: Colors.white)),
                                  ),
                                  defaultText(
                                      txt: '✅ Limited Question  to Your Ai Bot',
                                      color: AppColors.textColor)
                                ],
                              ),
                              Image.asset(
                                'assets/images/5.png',
                                height: 110.h,
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.redColor,
                            ),
                            child: Center(
                                child: defaultText(
                                    txt: 'subscribe now',
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w800)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.mainColor),
                      ),
                      child: Column(
                        // spacing: 15.h,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                spacing: 15.h,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: AppColors.mainColor,
                                    ),
                                    child: Center(
                                        child: defaultText(
                                            txt: 'Premium',
                                            color: Colors.white)),
                                  ),
                                  defaultText(
                                      txt:
                                          '✅ Unlimited Question  to Your Ai Bot ✅ limited generated  Ai Video',
                                      color: AppColors.textColor)
                                ],
                              ),
                              Image.asset(
                                'assets/images/flag-icon 2.png',
                                height: 110.h,
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              PaymobPayment.instance.pay(
                                  context: context,
                                  currency: "EGP",
                                  amountInCents:
                                      "${(double.parse('19.99') * 100).toInt()}",
                                  onPayment: (response) {
                                    if (response.success == true) {
                                      cubit.chooseCourseData(
                                        isSubcripe: true,
                                      );
                                      cubit.editCourse();
                                      succesMasseges('Payment Success'.tr());
                                      // nextPageUntil(context, OrderSuccess());
                                    } else if (response.success == false) {
                                      errorMasseges('Payment Failed'.tr());
                                      nextPageUntil(context, DashboardScreen());
                                    } else {
                                      errorMasseges('Payment Failed'.tr());
                                      pop(context);
                                    }
                                  });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.redColor,
                              ),
                              child: Center(
                                  child: defaultText(
                                      txt: 'subscribe now',
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w800)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.mainColor),
                      ),
                      child: Column(
                        // spacing: 15.h,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                spacing: 15.h,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: AppColors.mainColor,
                                    ),
                                    child: Center(
                                        child: defaultText(
                                            txt: 'Platinum',
                                            color: Colors.white)),
                                  ),
                                  defaultText(
                                      txt:
                                          '✅ Unlimited Question  to Your Ai Bot ✅ Unlimited generated  Ai Video',
                                      color: AppColors.textColor)
                                ],
                              ),
                              Image.asset(
                                'assets/images/21.png',
                                height: 110.h,
                              )
                            ],
                          ),
                          InkWell(
                            onTap: (){
                                 PaymobPayment.instance.pay(
                                  context: context,
                                  currency: "EGP",
                                  amountInCents:
                                      "${(double.parse('50.99') * 100).toInt()}",
                                  onPayment: (response) {
                                    if (response.success == true) {
                                      cubit.chooseCourseData(
                                        isSubcripe: true,
                                      );
                                      cubit.editCourse();
                                      succesMasseges('Payment Success'.tr());
                                      // nextPageUntil(context, OrderSuccess());
                                    } else if (response.success == false) {
                                      errorMasseges('Payment Failed'.tr());
                                      nextPageUntil(context, DashboardScreen());
                                    } else {
                                      errorMasseges('Payment Failed'.tr());
                                      pop(context);
                                    }
                                  });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.redColor,
                              ),
                              child: Center(
                                  child: defaultText(
                                      txt: 'subscribe now',
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w800)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
