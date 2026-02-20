import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/app_drawer.dart';
import 'package:flexedu/core/componant/appbar_widget.dart';
import 'package:flexedu/core/componant/bottom_sheet.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/componant/loading.dart';
import 'package:flexedu/features/reports/features/componant/get_report.dart';
import 'package:flexedu/features/reports/features/cubit/reports_cubit.dart';
import 'package:flexedu/features/reports/features/cubit/reports_state.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<ReportsCubit, ReportsState>(
        listener: (context, state) {},
        builder: (context, state) {
          ReportsCubit cubit = ReportsCubit.get(context);
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
              child: cubit.blogs == null
                  ? Center(child: LoadingWidget())
                  : Column(
                      children: [
                        Container(
                          height: 530.h,
                          child: cubit.blogs.isEmpty
                              ? Center(child: LoadingWidget())
                              : GridView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  padding:
                                      EdgeInsets.only(left: 12.w, right: 12.w),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 15,
                                          mainAxisSpacing: 15,
                                          childAspectRatio: 1 / 1.13,
                                          crossAxisCount: 2),
                                  itemCount: cubit.blogs.length,
                                  itemBuilder: (context, index) => GetReport(
                                        blogs: cubit.blogs[index],
                                      )),
                        )
                      ],
                    ),
            ),
          );
        });
  }
}
