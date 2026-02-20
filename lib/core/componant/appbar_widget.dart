import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/features/search/features/screens/search.dart';
import 'package:flexedu/features/splash_screen/screens/splash_screen.dart';

AppBar appbarWidget({required String txt, GestureTapCallback? onTap}) {
  return AppBar(
    backgroundColor: Theme.of(context).primaryColorLight,
    leadingWidth: 150.w,
    actionsPadding: EdgeInsets.only(left: 12.w, right: 12.w),
    actions: [
      InkWell(
          onTap: () {
            nextPage(context, SearchFiltersScreen());
          },
          child: Icon(Icons.search)),
      SizedBox(width: 10.w),
      InkWell(onTap: onTap, child: Icon(Icons.menu)),
    ],
    leading: Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Row(
        children: [
          defaultText(txt: txt, fontSize: 18.sp, fontWeight: FontWeight.w600)
        ],
      ),
    ),
  );
}
