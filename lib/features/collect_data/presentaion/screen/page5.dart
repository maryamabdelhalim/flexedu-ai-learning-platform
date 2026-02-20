import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Level {
  String name;
  String image;
  Level({required this.name, required this.image});
}

List<Level> level = [
  Level(name: '15+ mins', image: '🕒'),
  Level(name: '30+ mins ', image: '🕒'),
  Level(name: '45+ mins', image: '🕒'),
  Level(name: 'more than hour', image: '🕒'),
];

class Page5 extends StatefulWidget {
  const Page5({super.key});

  @override
  State<Page5> createState() => _Page5State();
}

String? englishStudy;

class _Page5State extends State<Page5> {
  int index1 = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        spacing: 35.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultText(
              maxLines: 2,
              txt: 'For How long Could you Study English Daily ?',
              fontSize: 25.sp),
          Container(
            height: 270.h,
            child: ListView.separated(
                padding: EdgeInsets.only(top: 10.h),
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setState(() {
                          index1 = index;
                          englishStudy = level[index].name;
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            defaultText(
                                txt: level[index].name,
                                fontSize: 15.sp,
                                color: index1 == index
                                    ? Colors.white
                                    : AppColors.blacColor),
                            defaultText(
                              txt: level[index].image,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ],
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 15.h,
                    ),
                itemCount: level.length),
          )
        ],
      ),
    );
  }
}
