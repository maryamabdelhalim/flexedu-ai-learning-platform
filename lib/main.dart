import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flexedu/core/paymob/pay.dart';
import 'package:flexedu/features/dashboard_screen/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/const/const.dart';
import 'package:flexedu/core/database/api/dio_consumer.dart';
import 'package:flexedu/core/database/bloc_observer.dart';
import 'package:flexedu/core/database/cache/cache_helper.dart';
import 'package:flexedu/features/search/features/cubit/search_cubit.dart';
import 'package:flexedu/features/splash_screen/screens/splash_screen.dart';
import 'package:flexedu/features/splash_screen/splash_cubit/theme_cubit.dart';
import 'package:flexedu/features/tests/features/cubit/test_cubit.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_cubit.dart'
    show HomeCubit;
import 'package:flexedu/features/labs/features/cubit/labs_cubit.dart';
import 'package:flexedu/features/login_screen/features/cubit/login_cubit.dart';
import 'package:flexedu/features/reports/features/cubit/reports_cubit.dart';

import 'package:flexedu/features/splash_screen/splash_cubit/splash_cubit.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

const apiKey = 'AIzaSyDSgV8I7lG9ZCgfg47uoFA0SEiU58-Z0p8';


// BuildContext context = MyApp.navKey.currentState!.context;
GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
getToken() async {
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    print("Firebase Token: $token");
  } catch (e, stack) {
    print("Error getting FCM token: $e");
    print("Stack: $stack");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: "AIzaSyC6fW4KfUuwbbUKDhhSmx_xv76No-KePH8",
      appId: "1:1021162946101:android:cd74668d5c85c29bfdbb7c",
      messagingSenderId: "1021162946101",
      projectId: "club-2f8df",
      storageBucket: "club-2f8df.appspot.com",
    ));
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
  }

  // MessagingConfig.initFirebaseMessaging();
  // FirebaseMessaging.onBackgroundMessage(MessagingConfig.messageHandler);

  await CacheHelper.init();
  await DioHelper.init();
await PayMobIntegration.intialize();
  Bloc.observer = MyBlocObserver();
  if (Platform.isIOS) {
    await FirebaseMessaging.instance.requestPermission();
    fireBaseToken = await FirebaseMessaging.instance.getAPNSToken();
    // fireBaseToken = await FirebaseMessaging.instance.getToken();
  } else {
    fireBaseToken = await FirebaseMessaging.instance.getToken();
  }
  // await getToken();

  // await TimesForNotification.getTimes();
  uid = CacheHelper.getShared(key: AppConst.kLogin) != null
      ? CacheHelper.getShared(key: AppConst.kLogin)
      : null;
  noty = CacheHelper.getShared(key: AppConst.kNoty) != null
      ? CacheHelper.getShared(key: AppConst.kNoty)
      : null;
  userEmail = CacheHelper.getShared(key: AppConst.kEmail) != null
      ? CacheHelper.getShared(key: AppConst.kEmail)
      : null;
  theme = CacheHelper.getShared(key: AppConst.kTheme) != null
      ? CacheHelper.getShared(key: AppConst.kTheme)
      : null;

  print('===========$uid');


  Gemini.init(apiKey: apiKey, enableDebugging: true); // ✅ Initialize once
  runApp(const MyApp());


  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (context) => SplashCubit()..initConnectivity(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<DashboardCubit>(
          create: (context) => DashboardCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit()..getUserData()..getCourses()
          ,
        ),
        BlocProvider<LabsCubit>(
          create: (context) => LabsCubit()..getLabs(),
        ),
        BlocProvider<SearchCubit>(
          create: (context) => SearchCubit()
            ..getCities()
            ..getDistricts()
            ..getCategory()
            ..getRegions()
            ..getLabs()
            ..getLabsTest(),
        ),
        BlocProvider<TestCubit>(
          create: (context) => TestCubit()..getLabsTests(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<ReportsCubit>(
          create: (context) => ReportsCubit()..getReports(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, themeMode) {
        return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                navigatorKey: navKey,
                debugShowCheckedModeBanner: false,
                title: 'flexedu',
                home: Splash(),
                themeMode: themeMode,
                theme: ThemeData(
                  // colorSchemeSeed: AppColors.containerGreenColor,
                  canvasColor: AppColors.containerRedColor,
                  highlightColor: AppColors.secandColors,
                  drawerTheme: DrawerThemeData(
                    backgroundColor: Colors.white,
                  ),
                  primaryColor: Colors.black,
                  appBarTheme: AppBarTheme(
                    backgroundColor: Colors.white,
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                  ),

                  primaryColorDark: AppColors.blacColor,
                  primaryColorLight: Colors.white,
                  hintColor: Colors.grey,
                  disabledColor: AppColors.containerGreenColor,
                  cardTheme: CardThemeData(
                    
                      color: Colors.white,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shadowColor: Colors.grey,
                      elevation: 1,
                      margin: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      
                    ),
                    // color: const Color.fromARGB(255, 45, 43, 43),
                  ),
                  textTheme: TextTheme(
                    bodyLarge: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600),
                    bodyMedium: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  scaffoldBackgroundColor: Colors.grey.shade100,
                  bottomSheetTheme:
                      BottomSheetThemeData(backgroundColor: Colors.white),
                ),
                darkTheme: ThemeData(
                  dropdownMenuTheme: DropdownMenuThemeData(
                    menuStyle: MenuStyle(
                      backgroundColor:
                          WidgetStateProperty.all(AppColors.blacColor),
                    ),
                    textStyle: TextStyle(
                      color: AppColors.BLACKWhiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  appBarTheme: AppBarTheme(
                    backgroundColor: AppColors.blacColor,
                    titleTextStyle: TextStyle(color: AppColors.BLACKWhiteColor),
                    iconTheme: IconThemeData(color: AppColors.BLACKWhiteColor),
                    actionsIconTheme:
                        IconThemeData(color: AppColors.BLACKWhiteColor),
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      // statusBarColor: ,
                      statusBarIconBrightness: Brightness.light,
                    ),
                  ),
                  drawerTheme: DrawerThemeData(
                    backgroundColor: AppColors.blacColor,
                  ),
                  primaryColor: Colors.white,
                  canvasColor: AppColors.BLACKContainerRedColor,
                  highlightColor: AppColors.blueColor,
                  disabledColor: AppColors.BLACKContainerGreenColor,
                  focusColor: AppColors.redColor,
                  // hoverColor: AppColors.BLACKContainerGreenColor,
                  // highlightColor: AppColors.,
                  // colorSchemeSeed: AppColors.BLACKContainerGreenColor,
                  primaryColorDark: AppColors.BLACKWhiteColor,
                  primaryColorLight: AppColors.BLACKContainerColor,
                  hintColor: Colors.grey,
                  cardTheme: CardThemeData(
                   
                      color: AppColors.BLACKContainerColor,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                    
                    ),
                    // color: const Color.fromARGB(255, 45, 43, 43),
                  ),
                  textTheme: TextTheme(
                    bodyLarge: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600),
                    bodyMedium: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  scaffoldBackgroundColor: AppColors.BLACKColor,
                  bottomSheetTheme: BottomSheetThemeData(
                      backgroundColor: const Color.fromARGB(255, 45, 43, 43)),
                ),
              );
            });
      }),
    );
  }
}
