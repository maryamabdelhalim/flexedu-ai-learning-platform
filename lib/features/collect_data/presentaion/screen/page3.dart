import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Level {
  List<String> name;
  String levelName;
  Level({required this.name, required this.levelName});
}

List<Level> level = [
  Level(name: ['A1', 'A2'], levelName: 'Beginner'),
  Level(name: ['B1', 'B2'], levelName: 'Intermediate'),
  Level(name: ['C1', 'C2'], levelName: 'Advanced'),
];

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}
String? englishLevel;
class _Page3State extends State<Page3> {
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
              txt: 'What is your Current English Level ?',
              fontSize: 25.sp),
          Container(
            height: 270.h,
            child: ListView.separated(
                padding: EdgeInsets.only(top: 10.h),
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setState(() {
                          index1 = index;
                          englishLevel = level[index].levelName;
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
                              txt: level[index].levelName,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              color: index1 == index
                                  ? Colors.white
                                  : AppColors.BLACKColor,
                            ),
                            Wrap(
                              spacing: 5.w,
                              children: List.generate(
                                  level[index].name.length,
                                  (index2) => CircleAvatar(
                                        backgroundColor: index1 == index
                                            ? Colors.white
                                            : AppColors.mainColor,
                                        child: defaultText(
                                          txt: level[index].name[index2],
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w800,
                                          color: index1 == index
                                              ? AppColors.BLACKColor
                                              : Colors.white,
                                        ),
                                      )),
                            )
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
