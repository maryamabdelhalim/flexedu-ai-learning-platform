import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/features/splash_screen/screens/splash_screen.dart';

succesMasseges(txt) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      padding: EdgeInsets.all(12),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: 30.h, left: 12.w, right: 12.w),
      backgroundColor: Theme.of(context).primaryColor,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          defaultText(txt: txt, color: Theme.of(context).primaryColorLight),
          //  SizedBox(width: 10.w,),
          Icon(
            Icons.check_circle,
            color: AppColors.mainColor,
          )
        ],
      )));
}
