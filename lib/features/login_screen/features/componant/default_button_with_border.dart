import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';

class DefaultButtonWithBorder extends StatelessWidget {
  String txt;
  Function() onPress;
  Color? color;
  DefaultButtonWithBorder(
      {super.key, required this.txt, required this.onPress, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.blacColor),
          borderRadius: BorderRadius.circular(12),
          // color: Colors.white
        ),
        child: Center(
            child: defaultText(
                txt: txt,
                // color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700)),
      ),
    );
  }
}
