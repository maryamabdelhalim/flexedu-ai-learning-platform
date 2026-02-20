import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Flag {
  String name;
  String flag;
  Flag({required this.name, required this.flag});
}

List<Flag> flags = [
  Flag(name: 'English', flag: '🇬🇧'),
  Flag(name: 'Arabic', flag: '🇸🇦'),
  Flag(name: 'French', flag: '🇫🇷'),
  Flag(name: 'Spanish', flag: '🇪🇸'),
  Flag(name: 'German', flag: '🇩🇪'),
];

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}
String? language;
class _Page1State extends State<Page1> {
  int index1 = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        spacing: 15.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultText(
              maxLines: 2,
              txt: 'What is Your Native Language ?',
              fontSize: 25.sp),
          Container(
            padding: EdgeInsets.only(left: 12.w, right: 12.w),
            height: 45.h,
            decoration: BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.BLACKColor, width: 1)),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Image.asset(
                  'assets/images/🔍.png',
                  height: 23.h,
                )
              ],
            ),
          ),
         
          Container(
            height: 270.h,
            child: ListView.separated(
                padding: EdgeInsets.only(top: 10.h),
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setState(() {
                          index1 = index;
                          language = flags[index].name;
                        });
                      },
                      child: Container(
                        height: 45.h,
                        padding: EdgeInsets.only(left: 12.w, right: 12.w),
                        decoration: BoxDecoration(
                            color: index1 == index
                                ? AppColors.mainColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: AppColors.BLACKColor, width: .4)),
                        child: Row(
                          children: [
                            Text(flags[index].flag),
                            SizedBox(
                              width: 10.w,
                            ),
                            defaultText(
                              txt: flags[index].name,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              color: index1 == index
                                  ? Colors.white
                                  : AppColors.BLACKColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 15.h,
                    ),
                itemCount: flags.length),
          )
        ],
      ),
    );
  }
}
