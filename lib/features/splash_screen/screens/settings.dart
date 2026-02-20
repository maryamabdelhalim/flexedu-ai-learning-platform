import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/app_drawer.dart';
import 'package:flexedu/core/componant/appbar_widget.dart';
import 'package:flexedu/core/componant/bottom_sheet.dart';
import 'package:flexedu/core/componant/componant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexedu/features/splash_screen/splash_cubit/theme_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? selectedLanguage;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();

    // selectedLanguage = context.locale.languageCode == 'ar' ? 'ar' : 'en';
    // isDarkMode = Theme.of(context).brightness == Brightness.dark;
  }

  void _changeLanguage(String langCode) {
    context.setLocale(Locale(langCode));
    setState(() {
      selectedLanguage = langCode;
    });
  }

  void _toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
    if (isDarkMode) {
      context.read<ThemeCubit>().toggleTheme();
    } else {
      context.read<ThemeCubit>().toggleTheme();
    }
    log(isDarkMode.toString());
    // لو عندك Cubit للثيم
    // ThemeCubit.get(context).changeTheme(isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<ThemeCubit, ThemeMode>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            bottomSheet: BottomSheetScreen(),
            endDrawer: AppDrawer(),
            appBar: appbarWidget(
                txt: 'Settings'.tr(),
                onTap: () {
                  scaffoldKey.currentState!.openEndDrawer();
                }),
            body: Padding(
              padding: EdgeInsets.only(top: 100.h, left: 14.w, right: 14.w),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: Theme.of(context).primaryColorLight,
                    child: ListTile(
                      leading: Icon(Icons.language),
                      title: defaultText(
                        txt: 'Language'.tr(),
                      ),
                      trailing: DropdownButton<String>(
                        dropdownColor: Theme.of(context).primaryColorLight,
                        value: selectedLanguage ?? 'en', // ✅ خليها 'en' أو 'ar'
                        onChanged: (value) {
                          if (value != null) _changeLanguage(value);
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'en',
                            child: defaultText(txt: 'English'),
                          ),
                          DropdownMenuItem(
                            value: 'ar',
                            child: defaultText(txt: 'العربية'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Card(
                    color: Theme.of(context).primaryColorLight,
                    child: ListTile(
                      leading: isDarkMode
                          ? Icon(
                              Icons.brightness_2_outlined,
                              color: AppColors.mainColor,
                            )
                          : Icon(
                              Icons.brightness_6,
                              color: AppColors.blacColor,
                            ),
                      title: defaultText(txt: 'Theme'.tr()),
                      trailing: Switch(
                        // focusColor: AppColors.mainColor,
                        activeColor: AppColors.mainColor,
                        value: isDarkMode,
                        onChanged: _toggleTheme,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
