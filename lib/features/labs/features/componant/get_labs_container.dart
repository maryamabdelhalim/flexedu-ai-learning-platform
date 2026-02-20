import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';

class GetLabsContainer extends StatelessWidget {
  String? txt;
  Color? color;
  Color? txtColor;
  GetLabsContainer({super.key, required this.txt, this.color, this.txtColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      padding: EdgeInsets.only(left: 7.w, right: 7.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: color ?? AppColors.greenText),
      child: Row(
        spacing: 3.w,
        children: [
          defaultText(
            txt: txt,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: txtColor ?? AppColors.greenText,
          ),
          Icon(
            CupertinoIcons.check_mark_circled,
            size: 16.sp,
            color: txtColor ?? AppColors.greenText,
          )
        ],
      ),
    );
  }
}
