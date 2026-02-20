import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/features/tests/data/model/get_tests.dart';
import 'package:flexedu/features/tests/features/cubit/test_cubit.dart';

class GetMoreDetails extends StatelessWidget {
  TestCubit? cubit;
  TestData? data;
  GetMoreDetails({super.key, this.cubit, required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height,
          color: Colors.black12,
        ),
        Container(
          margin: EdgeInsets.only(left: 12.w, right: 12.w),
          height: 240.h,
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            border: Border.all(color: AppColors.textColor, width: .3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20.h,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  defaultText(
                      txt: 'More Details'.tr(),
                      color: AppColors.blacColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                  InkWell(
                    onTap: () {
                      cubit!.changeDetails();
                    },
                    child: Icon(CupertinoIcons.clear_circled,
                        color: AppColors.mainColor),
                  ),
                ],
              ),
              defaultText(
                  txt: data?.name ?? '--',
                  color: Theme.of(context).highlightColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
              defaultText(
                  txt: 'For booking'.tr(),
                  color: Theme.of(context).primaryColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: AppColors.mainColor,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  defaultText(
                      txt: data?.phoneNumber ?? "--",
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/Frame (3).png',
                    color: AppColors.mainColor,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  defaultText(
                      txt: data?.websiteLink ?? '--',
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
