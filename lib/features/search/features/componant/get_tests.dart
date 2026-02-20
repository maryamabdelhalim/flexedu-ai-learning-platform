import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/componant/loading.dart';
import 'package:flexedu/core/database/api/end_point.dart';
import 'package:flexedu/core/fonts/fonts.dart';
import 'package:flexedu/features/labs/features/componant/get_labs_container.dart';
import 'package:flexedu/features/search/features/cubit/search_cubit.dart';
import 'package:flexedu/features/tests/data/model/get_tests.dart';
import 'package:flexedu/features/tests/features/componant/get_test_container.dart';
import 'package:flexedu/features/tests/features/cubit/test_cubit.dart';
import 'package:flexedu/features/tests/features/screens/test_details.dart';

class GetTests extends StatelessWidget {
  SearchCubit cubit;
  TestData? data;
  GetTests({super.key, required this.cubit, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        nextPage(
            context,
            TestDetailsScreen(
              data: data,
            ));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.h),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.textColor, width: .3),
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).primaryColorLight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 15.h,
          children: [
            defaultText(txt: data!.name ?? '--', fontSize: 17.sp),
            CachedNetworkImage(
                height: 130.h,
                width: 130.w,
                placeholder: (context, url) => LoadingWidget(),
                imageUrl: data!.imagesIdsAndExtensions!.first,
                errorListener: (value) => Image.asset(
                      'assets/images/no-image.png',
                      color: Colors.grey.shade300,
                      height: 100.h,
                      width: 100.w,
                    ),
                errorWidget: (context, url, error) => Image.asset(
                    'assets/images/no-image.png',
                    height: 100.h,
                    width: 100.w,
                    color: Colors.grey.shade300)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.trending_up_sharp,
                      color: AppColors.mainColor,
                    ),
                    defaultText(
                        maxLines: 5,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainColor,
                        txt: data!.visitPrecentString ?? ''),
                  ],
                ),
                defaultText(
                    maxLines: 5,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColorDark,
                    txt: 'معدل النشاط الشهرى'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetLabsContainer(
                  txt: 'supportSingleTest'.tr(),
                  color: data!.supportSingleTest == true
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).canvasColor,
                  txtColor: data!.supportSingleTest == true
                      ? AppColors.greenText
                      : AppColors.redColor,
                ),
                GetLabsContainer(
                  txt: "supportPackages".tr(),
                  color: data!.supportPackages == true
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).canvasColor,
                  txtColor: data!.supportPackages == false
                      ? AppColors.redColor
                      : AppColors.greenText,
                ),
                GetLabsContainer(
                  txt: 'Insurance'.tr(),
                  color: data!.supportInsurance == true
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).canvasColor,
                  txtColor: data!.supportInsurance == true
                      ? AppColors.greenText
                      : AppColors.redColor,
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: RichText(
                  text: TextSpan(
                text: 'Price'.tr(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    fontFamily: FontFamilies.CAIRO,
                    color: Theme.of(context).highlightColor),
                children: [
                  TextSpan(
                    text: ' ',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.mainColor),
                  ),
                  TextSpan(
                    text: data!.price.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.mainColor),
                  ),
                ],
              )),
            ),
            InkWell(
              onTap: () {
                cubit.changeDetails();
              },
              child: Row(
                children: [
                  Icon(Icons.info, color: AppColors.mainColor),
                  defaultText(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      txt: 'More Details'.tr(),
                      color: AppColors.mainColor),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
