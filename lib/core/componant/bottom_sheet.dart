import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/const/const.dart';
import 'package:flexedu/features/tests/features/screens/tests.dart';
import 'package:flexedu/features/labs/features/screens/labs.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_cubit.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_state.dart';
// import 'package:flexedu/features/profile/features/screens/profile.dart';
import 'package:flexedu/features/reports/features/screens/reports.dart';

class BottomSheetScreen extends StatelessWidget {
  int index;
  BottomSheetScreen({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Container(
              // margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
              height: 70.h,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: .1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                color: Theme.of(context).primaryColorLight,
              ),
              child: ListView.separated(
                  padding: EdgeInsets.only(left: 13.w, right: 13.w, top: 10.h),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          cubit.changeIndex(index);
                          if (index == 0) {
                            // nextPage(context, HomeScreen());
                          } else if (index == 1) {
                            nextPage(context, Labs());
                          } else if (index == 2) {
                            nextPage(context, TestsScreen());
                          } else if (index == 3) {
                            nextPage(context, ReportsScreen());
                          } else {
                            // nextPage(context, ProfileScreen());
                          }
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              cubit.pageIcons[index].image.toString(),
                              height: 30.h,
                              width: 30.w,
                              color: cubit.indexScreen == index
                                  ? AppColors.mainColor
                                  : AppColors.textColor,
                            ),
                            Container(
                              width: 64.w,
                              child: defaultText(
                                txt:
                                    cubit.pageIcons[index].name.toString().tr(),
                                color: cubit.indexScreen == index
                                    ? AppColors.mainColor
                                    : AppColors.textColor,
                              ),
                            )
                          ],
                        ),
                      ),
                  separatorBuilder: (context, index) => SizedBox(width: 5.w),
                  itemCount: 5));
        });
  }
}
