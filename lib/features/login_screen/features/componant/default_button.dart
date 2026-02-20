import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';

class DefaultButton extends StatelessWidget {
  String txt;
  Function() onPress;
  Color? color;
  Color? txtColor;
  DefaultButton(
      {super.key, required this.txt, required this.onPress, this.color, this.txtColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color ?? AppColors.mainColor),
        child: Center(
            child: defaultText(
                txt: txt,
                color:txtColor ?? Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700)),
      ),
    );
  }
}
