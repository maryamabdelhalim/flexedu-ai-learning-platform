import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';

class GetAboutContainer extends StatelessWidget {
  String? title;
  String? subTitle;
  GetAboutContainer({super.key, this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).primaryColorLight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.h,
          children: [
            defaultText(txt: title, fontSize: 17.sp),
            defaultText(
                maxLines: 5,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
                txt: subTitle)
          ],
        ));
  }
}
