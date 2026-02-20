import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Hobbies {
  String name;
  String txt;

  Hobbies({required this.name, required this.txt});
}

List<Hobbies> hobbies = [
  Hobbies(name: '🎮', txt: 'Gaming'),
  Hobbies(name: '🎨', txt: 'Art'),
  Hobbies(name: '🎧', txt: 'Music'),
  Hobbies(name: '🎤', txt: 'Singing'),
  Hobbies(name: '🎸', txt: 'Guitar'),
  Hobbies(name: '🎹', txt: 'Piano'),
  Hobbies(name: '📷', txt: 'Photography'),
  Hobbies(name: '🎼', txt: 'Dancing'),
];

class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  State<Page4> createState() => _Page4State();
}
 List<String> selectedHobbies = [];
 
class _Page4State extends State<Page4> {
  // int index1 = 0;
  List<int> index1 = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        spacing: 15.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultText(
              maxLines: 2, txt: 'What is your hobbies ? ', fontSize: 25.sp),
          defaultText(
              maxLines: 2,
              txt: 'You Could Choose More than One',
              fontSize: 12.sp,
              color: AppColors.textColor),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'ex. Gaming',
                    ),
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
                         
                          selectedHobbies.add(hobbies[index].txt);
                          index1.add(index);
                        });
                      },
                      child: Container(
                        height: 45.h,
                        padding: EdgeInsets.only(left: 12.w, right: 12.w),
                        decoration: BoxDecoration(
                            color:  index1.contains(index)
                                ? AppColors.mainColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: AppColors.BLACKColor, width: .4)),
                        child: Row(
                          children: [
                            Text(
                              hobbies[index].txt,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            defaultText(
                              txt: hobbies[index].name,
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
                itemCount: hobbies.length),
          )
        ],
      ),
    );
  }
}
