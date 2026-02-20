import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';

class LoginHeader extends StatelessWidget {
  String? txt;
  LoginHeader({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                focusColor: Colors.transparent,
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                         
              onTap: () {
                pop(context);
              },
              child: Container(
                height: 30.h,
                width: 30.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: AppColors.mainColor),
                ),
                child: Icon(
                  CupertinoIcons.back,
                  color: AppColors.mainColor,
                ),
              ),
            ),
            CircleAvatar(
              radius: 17.r,
              backgroundImage: AssetImage(
                'assets/images/image 9.png',
              ),
            )
          ],
        ),
    
        defaultText(
          txt: txt,
          fontSize: 30.sp,
          fontWeight: FontWeight.w800,
          // color: AppColors.mainColor,
        ),
      ],
    );
  }
}
