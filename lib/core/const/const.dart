import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flexedu/features/splash_screen/screens/splash_screen.dart';
import 'package:sqflite/sqflite.dart';

class AppConst {
  static String kLogin = 'Login';
  static String kName = 'namw';
  static String kNoty = 'Noty';
  static String kEmail = 'Email';
  static String kTheme = 'theme';
  static String kAppVersion = 'AppVersion';

  static String kLang = 'langauge';
  static String kBranchId = 'BranchId';

  static String kAppName = 'app_name'.tr();
  static String kAppCurrency = 'LE'.tr();
}

String appLogo = 'assets/images/logo white.png';
String appKey = 'AIzaSyArJ9dqhIQhdXYzqcEpyqJO2gtV1zsdgaI';
// String appKey = 'AIzaSyDjgUxgzitqoYObIabR-kHs17NiBPObKMc';
String? uid;
String? userEmail;

String? fireBaseToken;
String? apnsToken;
String? link;
String? noty;
int? theme;

Database? database;
Widget page = Splash();
// dynamic appPage = HomeScreen();
final emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
