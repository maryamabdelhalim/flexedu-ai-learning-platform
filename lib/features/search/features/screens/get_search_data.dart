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
import 'package:flexedu/core/componant/loading.dart' show LoadingWidget;
import 'package:flexedu/features/search/features/componant/get_more_details.dart';
import 'package:flexedu/features/search/features/componant/get_tests.dart';
import 'package:flexedu/features/search/features/cubit/search_cubit.dart';
import 'package:flexedu/features/search/features/cubit/search_state.dart';
import 'package:flexedu/features/tests/data/model/get_tests.dart';
import 'package:flexedu/features/tests/features/cubit/test_cubit.dart';
import 'package:flexedu/features/tests/features/cubit/test_state.dart';

class GetSearchData extends StatelessWidget {
  String? cityId;

  String? districtId;

  String? sectionId;
  String? regionId;
  String? labIdOrMedicalTestId;
  bool? priceSortingAsc;
  int? searchType;

  GetSearchData(
      {super.key,
      this.cityId,
      this.regionId,
      this.districtId,
      this.sectionId,
      this.searchType,
      this.labIdOrMedicalTestId,
      this.priceSortingAsc});

  @override
  Widget build(BuildContext context) {
    TestData? data;
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (context) => SearchCubit()
        ..getSearchLabTests(
            cityId: cityId,
            regionId: regionId,
            searchType: searchType,
            districtId: districtId,
            sectionId: sectionId,
            labIdOrMedicalTestId: labIdOrMedicalTestId,
            priceSortingAsc: priceSortingAsc),
      child: BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            SearchCubit cubit = SearchCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              appBar: appbarWidget(
                  txt: 'Factories'.tr(),
                  onTap: () {
                    scaffoldKey.currentState!.openEndDrawer();
                  }),
              endDrawer: AppDrawer(),
              bottomSheet: BottomSheetScreen(),
              body: Stack(
                alignment: Alignment.center,
                children: [
                  cubit.searchLabsTest == null
                      ? Center(child: LoadingWidget())
                      : Container(
                          height: 540.h,
                          child: cubit.searchLabsTest!.data!.isEmpty
                              ? Center(
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/flask.png',
                                      height: 120.h,
                                      width: 150.w,
                                    ),
                                    SizedBox(height: 10.h),
                                    defaultText(
                                        txt: 'No data found'.tr(),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                  ],
                                ))
                              : ListView.separated(
                                  padding: EdgeInsets.all(12.h),
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    data = cubit.searchLabsTest!.data![index];
                                    return GetTests(
                                      data: data,
                                      cubit: cubit,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                  itemCount:
                                      cubit.searchLabsTest!.data!.length),
                        ),
                  if (cubit.isDetails == true)
                    GetMoreDetails(
                      data: data,
                      cubit: cubit,
                    ),
                ],
              ),
            );
          }),
    );
  }
}
