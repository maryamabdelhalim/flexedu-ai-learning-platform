import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flexedu/features/dashboard_screen/screens/dashboard_screen.dart';
import 'package:flexedu/features/home_screen/features/screens/home_screen.dart';
import 'package:flexedu/features/splash_screen/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/const/const.dart';
import 'package:flexedu/core/database/cache/cache_helper.dart';
import 'package:flexedu/features/login_screen/features/screens/login_screen.dart';
import 'package:flexedu/features/splash_screen/screens/connected_page.dart';
import 'package:flexedu/main.dart' as MyApp;

BuildContext context = MyApp.navKey.currentState!.context;

class Splash extends StatefulWidget {
  bool? isDeepLink;
  int? id;
  Splash({Key? key, this.isDeepLink = false, this.id}) : super(key: key);

  static int themeType = 1;

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // Widget page = OnBoarding();
  bool? internet;
  bool isConnected = false;
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isConnected = true;
    }
    log(' isConnected ${isConnected.toString()}');
  }
  // conect() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     internet = true;
  //     setState(() {});
  //   } else {
  //     internet = false;
  //     setState(() {});
  //   }
  //   log(internet.toString());
  // }

  @override
  void initState() {
    // TODO: implement initState
    // checkConnectivity();

    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    Timer(
        Duration(seconds: 7),
        () => nextPageUntil(
            context,
          uid == null ?
               OnBoardingScreen() : DashboardScreen()));
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      if (result[0] == ConnectivityResult.none) {
        isConnected = true;
      }
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash.png',
              height: 340.h,
              width: 280.w,
            )
            // .animate(delay: 400.ms).fade(duration: 900.ms).slide(),
          ],
        ),
      ),
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
