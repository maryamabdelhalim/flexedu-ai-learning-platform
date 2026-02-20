import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/const/const.dart';
import 'package:flexedu/core/database/cache/cache_helper.dart';
import 'package:flexedu/features/login_screen/features/componant/default_button.dart';
import 'package:flexedu/features/splash_screen/screens/splash_screen.dart';
import 'package:flexedu/features/splash_screen/splash_cubit/splash_cubit.dart';
import 'package:flexedu/features/splash_screen/splash_cubit/splash_state.dart';
// BuildContext context = MyApp.navKey.currentState!.context;

class ConnectedPage extends StatelessWidget {
  bool? isDeepLink;
  int? id;
  ConnectedPage({Key? key, this.isDeepLink = false, this.id}) : super(key: key);

  static int themeType = 1;

  // Widget page = OnBoarding();

  bool? internet;

  // conect() async {
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {},
        builder: (context, state) {
          SplashCubit cubit = SplashCubit.get(context);

          return Scaffold(
              // backgroundColor: AppColors.mainColor,
              body: Center(
                  child: Padding(
            padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/noInternet.png'),
                SizedBox(
                  height: 30.h,
                ),
                DefaultButton(
                  txt: 'متابعة',
                  onPress: () {
                    cubit.initConnectivity();

                    if (cubit.isConnected == false) {
                      nextPageUntil(context, Splash());
                    }
                  },
                ),
              ],
            ),
          )));
        });
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
