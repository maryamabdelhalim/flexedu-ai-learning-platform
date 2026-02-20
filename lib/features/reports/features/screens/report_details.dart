import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/app_drawer.dart';
import 'package:flexedu/core/componant/appbar_widget.dart';
import 'package:flexedu/core/componant/bottom_sheet.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/componant/loading.dart';
import 'package:flexedu/core/database/api/end_point.dart';
import 'package:flexedu/features/reports/features/componant/get_report.dart';

class ReportsDetailsScreen extends StatelessWidget {
  String? id;
  String? image;
  String? bodyAr;
  String? bodyEn;
  String? titleAr;
  String? titleEn;
  ReportsDetailsScreen(
      {super.key,
      this.id,
      this.image,
      this.bodyAr,
      this.bodyEn,
      this.titleAr,
      this.titleEn});

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    final isArabic = context.locale.languageCode == 'ar';
    return Scaffold(
      key: scaffoldKey,
      endDrawer: AppDrawer(),
      appBar: appbarWidget(
          txt: 'Reports'.tr(),
          onTap: () {
            scaffoldKey.currentState!.openEndDrawer();
          }),
      bottomSheet: BottomSheetScreen(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            spacing: 20.h,
            children: [
              defaultText(
                  maxLines: 2,
                  txt: isArabic ? titleAr.toString() : titleEn.toString(),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
              ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7), topRight: Radius.circular(7)),
                child: CachedNetworkImage(
                  imageUrl: image.toString(),
                  errorListener: (value) => Image.asset(
                    'assets/images/no-image.png',
                    color: Colors.grey.shade300,
                  ),
                  height: 180.h,
                  fadeInDuration: Duration(seconds: 2),
                  fadeOutDuration: Duration(seconds: 1),
                  placeholder: (context, url) => LoadingWidget(),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/no-image.png',
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              HtmlWidget(
                isArabic ? bodyAr.toString() : bodyEn.toString(),
                textStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).primaryColor,
                  // height: 1.5,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Cairo',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
