import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/componant/loading.dart';
import 'package:flexedu/core/database/api/end_point.dart';
import 'package:flexedu/features/tests/features/componant/get_test_container.dart';
import 'package:flexedu/features/tests/features/cubit/test_cubit.dart';
import 'package:flexedu/features/tests/features/screens/test_details.dart';
import 'package:flexedu/features/labs/data/model/get_labs_model.dart';
import 'package:flexedu/features/labs/features/componant/get_labs_container.dart';
import 'package:flexedu/features/labs/features/cubit/labs_cubit.dart';
import 'package:flexedu/features/labs/features/screens/labs_details.dart';

class GetLabs extends StatelessWidget {
  LabsCubit cubit;
  LabsData? data;
  GetLabs({super.key, required this.cubit, this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        nextPage(
            context,
            LabsDetailsScreen(
              data: data,
              id: data!.id,
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
            defaultText(txt: data!.name.toString(), fontSize: 17.sp),
            CachedNetworkImage(
              imageUrl: data!.imagesIdsAndExtensions!.first.toString(),
              errorListener: (value) => Image.asset(
                'assets/images/no-image.png',
                color: Colors.grey.shade300,
              ),
              height: 100.h,
              width: 100.w,
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/no-image.png',
                color: Colors.grey.shade300,
              ),
              placeholder: (context, url) => LoadingWidget(),
            ),
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
                        txt: data!.visitPrecentString.toString()),
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
            // SizedBox(
            //   height: 10.h,
            // ),
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
