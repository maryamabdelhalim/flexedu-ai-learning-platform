import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


var ageController = TextEditingController();
class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20.h,
      children: [
        defaultText(maxLines: 2, txt: 'How Old are You ?', fontSize: 25.sp),
        Container(
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
          height: 45.h,
          decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.BLACKColor, width: 1)),
          child: TextField(
            controller:ageController ,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'ex. 15 years',
            ),
          ),
        ),
      ],
    );
  }
}
