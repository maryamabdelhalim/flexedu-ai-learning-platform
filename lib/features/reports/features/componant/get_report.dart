import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/componant/loading.dart';
import 'package:flexedu/core/database/api/end_point.dart';
import 'package:flexedu/features/reports/data/model/get_reports.dart';
import 'package:flexedu/features/reports/features/screens/report_details.dart';

class GetReport extends StatelessWidget {
  BlogsModel? blogs;
  GetReport({super.key, required this.blogs});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        nextPage(
            context,
            ReportsDetailsScreen(
              id: blogs!.id.toString(),
              titleAr: blogs!.arabicTitle.toString(),
              titleEn: blogs!.englishTitle.toString(),
              image: blogs!.filesIdsAndExtensions![0].toString(),
              bodyAr: blogs!.arabicContent.toString(),
              bodyEn: blogs!.englishContent.toString(),
            ));
      },
      child: Container(
        height: 140.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Theme.of(context).primaryColorLight),
        child: Column(children: [
          ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7), topRight: Radius.circular(7)),
            child: CachedNetworkImage(
              imageUrl: blogs!.filesIdsAndExtensions![0].toString(),
              errorListener: (value) => Image.asset(
                'assets/images/no-image.png',
                color: Colors.grey.shade300,
              ),
              height: 130.h,
              fadeInDuration: Duration(seconds: 2),
              fadeOutDuration: Duration(seconds: 1),
              placeholder: (context, url) => LoadingWidget(),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/no-image.png',
                color: Colors.grey.shade300,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          defaultText(
              maxLines: 1,
              txt: blogs!.arabicTitle.toString(),
              color: AppColors.blacColor)
        ]),
      ),
    );
  }
}
