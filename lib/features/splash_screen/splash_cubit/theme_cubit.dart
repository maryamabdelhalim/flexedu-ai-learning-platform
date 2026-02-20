import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flexedu/core/const/const.dart';
import 'package:flexedu/core/database/cache/cache_helper.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkTheme') ?? false;

    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = state == ThemeMode.dark;
    final newTheme = isDark ? ThemeMode.light : ThemeMode.dark;
    if (isDark) {
      CacheHelper.setInt(key: AppConst.kTheme, value: 0);
    } else {
      CacheHelper.setInt(key: AppConst.kTheme, value: 1);
    }
    await prefs.setBool('isDarkTheme', newTheme == ThemeMode.dark);
    emit(newTheme);
  }
}
