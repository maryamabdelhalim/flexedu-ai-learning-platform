import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/componant/app_drawer.dart';
import 'package:flexedu/core/componant/appbar_widget.dart';
import 'package:flexedu/core/componant/bottom_sheet.dart';
import 'package:flexedu/core/componant/loading.dart' show LoadingWidget;
import 'package:flexedu/features/tests/data/model/get_tests.dart';
import 'package:flexedu/features/tests/features/componant/get_tests.dart';
import 'package:flexedu/features/tests/features/componant/get_more_details.dart';
import 'package:flexedu/features/tests/features/cubit/test_cubit.dart';
import 'package:flexedu/features/tests/features/cubit/test_state.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TestData? data;
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<TestCubit, TestState>(
        listener: (context, state) {},
        builder: (context, state) {
          TestCubit cubit = TestCubit.get(context);
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
                cubit.tests == null
                    ? Center(child: LoadingWidget())
                    : Container(
                        height: 540.h,
                        child: cubit.tests!.data!.isEmpty
                            ? Center(child: LoadingWidget())
                            : ListView.separated(
                                padding: EdgeInsets.all(12.h),
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  data = cubit.tests!.data![index];
                                  return GetTests(
                                    data: data,
                                    cubit: cubit,
                                  );
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 10.h,
                                    ),
                                itemCount: cubit.tests!.data!.length),
                      ),
                if (cubit.isDetails == true)
                  GetMoreDetails(
                    data: data,
                    cubit: cubit,
                  ),
              ],
            ),
          );
        });
  }
}
