import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/features/splash_screen/screens/splash_screen.dart';

errorMasseges(txt) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      padding: EdgeInsets.all(12),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      margin: EdgeInsets.only(bottom: 30.h, left: 12.w, right: 12.w),
      // backgroundColor: Colors.transparent,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          defaultText(txt: txt, color: AppColors.BLACKWhiteColor),
          //  SizedBox(width: 10.w,),
          Icon(
            Icons.remove_circle,
            color: AppColors.redColor,
          )
        ],
      )));
}
