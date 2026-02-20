import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/app_drawer.dart';
import 'package:flexedu/core/componant/appbar_widget.dart';
import 'package:flexedu/core/componant/bottom_sheet.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/componant/loading.dart';
import 'package:flexedu/core/database/api/end_point.dart';
import 'package:flexedu/features/labs/features/componant/labs_get_more_details.dart';
import 'package:flexedu/features/tests/data/model/get_tests.dart';
import 'package:flexedu/features/tests/features/componant/get_tests.dart';
import 'package:flexedu/features/tests/features/componant/get_more_details.dart';
import 'package:flexedu/features/tests/features/cubit/test_cubit.dart';
import 'package:flexedu/features/tests/features/cubit/test_state.dart';

class TestDetailsScreen extends StatelessWidget {
  TestData? data;
  TestDetailsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (context) => TestCubit()..getLabsTestsById(data!.id),
      child: BlocConsumer<TestCubit, TestState>(
          listener: (context, state) {},
          builder: (context, state) {
            TestCubit cubit = TestCubit.get(context);
            return Scaffold(
                key: scaffoldKey,
                appBar: appbarWidget(
                    txt: 'Labs Details'.tr(),
                    onTap: () {
                      scaffoldKey.currentState!.openEndDrawer();
                    }),
                endDrawer: AppDrawer(),
                bottomSheet: BottomSheetScreen(),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              border: Border.all(
                                  color: Colors.grey.shade300, width: .3),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 12.w,
                                  right: 12.w,
                                  top: 20.h,
                                  bottom: 20.h),
                              child: Column(
                                spacing: 20.h,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      'assets/images/splash.png',
                                      height: 100.h,
                                    ),
                                  ),
                                  defaultText(
                                      txt: data!.name ?? '--',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                  defaultText(
                                      maxLines: 3,
                                      txt:
                                          'خدمة شاملة فى عالم المختبرات تغطية المملكة بشكل كامل وخدمة جميع العملاء مختبر يقدم جميع التحاليل الطبية',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                  defaultText(
                                      txt: 'For booking'.tr(),
                                      color: AppColors.blacColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                  Column(
                                    spacing: 5.h,
                                    children: [
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
                                              txt: data!.phoneNumber ?? '',
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                              txt: data!.websiteLink ?? '',
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      defaultText(
                                          txt: 'The Videos'.tr(),
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.mainColor,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 100.h,
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            Container(
                                              height: 100.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                  border: Border.all(
                                                      color:
                                                          AppColors.mainColor),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/Frame 1160445754.png'),
                                                      fit: BoxFit.cover)),
                                            ),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                        itemCount: 7),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  data!.filesIdsAndExtensions!.isEmpty
                                      ? SizedBox()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                defaultText(
                                                    txt: 'The Images'.tr(),
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: AppColors.mainColor,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Container(
                                              height: 100.h,
                                              child: ListView.separated(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder: (context,
                                                          index) =>
                                                      Container(
                                                        height: 100.h,
                                                        width: 100.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.r),
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade300),
                                                        ),
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10),
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            child:
                                                                CachedNetworkImage(
                                                                    errorWidget:
                                                                        (context, url, error) =>
                                                                            Image
                                                                                .asset(
                                                                              'assets/images/no-image.png',
                                                                              color: Colors.grey.shade300,
                                                                            ),
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            LoadingWidget(),
                                                                    imageUrl: data!
                                                                        .filesIdsAndExtensions![
                                                                            index]
                                                                        .toString(),
                                                                    errorListener:
                                                                        (value) =>
                                                                            Image
                                                                                .asset(
                                                                              'assets/images/no-image.png',
                                                                              color: Colors.grey.shade300,
                                                                            ),
                                                                    height:
                                                                        100.h,
                                                                    width:
                                                                        100.w,
                                                                    fit: BoxFit
                                                                        .cover)),
                                                      ),
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          SizedBox(
                                                            width: 15.w,
                                                          ),
                                                  itemCount: data!
                                                      .filesIdsAndExtensions!
                                                      .length),
                                            ),
                                          ],
                                        )
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Center(
                                  child: defaultText(
                                      txt: data!.testName ?? '--',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600)),
                              cubit.labTests == null
                                  ? SizedBox()
                                  : cubit.labTests!.data!.isEmpty
                                      ? Center(child: LoadingWidget())
                                      : ListView.separated(
                                          padding: EdgeInsets.all(12.h),
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              Container(
                                                padding: EdgeInsets.all(12.h),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade200,
                                                      width: .3),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  spacing: 15.h,
                                                  children: [
                                                    defaultText(
                                                        txt: cubit
                                                                .labTests!
                                                                .data![index]
                                                                .name ??
                                                            '--',
                                                        fontSize: 16.sp),
                                                    // defaultText(
                                                    //     txt: 'الكبد',
                                                    //     fontSize: 14.sp),
                                                    defaultText(
                                                        txt: cubit
                                                                .labTests!
                                                                .data![index]
                                                                .description ??
                                                            '--',
                                                        fontSize: 14.sp,
                                                        color: AppColors
                                                            .textColor),
                                                    defaultText(
                                                        txt: cubit
                                                                .labTests!
                                                                .data![index]
                                                                .price ??
                                                            '--',
                                                        fontSize: 14.sp,
                                                        color: AppColors
                                                            .textColor),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        cubit.changeDetails();
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.info,
                                                            color: AppColors
                                                                .mainColor,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          defaultText(
                                                              txt: 'Booking Now'
                                                                  .tr(),
                                                              fontSize: 14.sp,
                                                              color: AppColors
                                                                  .textColor),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                          itemCount:
                                              cubit.labTests!.data!.length),
                            ],
                          ),
                          SizedBox(
                            height: 100.h,
                          ),
                        ],
                      ),
                    ),
                    if (cubit.isDetails == true)
                      GetMoreDetails(
                        data: data,
                        cubit: cubit,
                      ),
                  ],
                ));
          }),
    );
  }
}
