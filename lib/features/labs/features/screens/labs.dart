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
import 'package:flexedu/features/tests/features/componant/get_tests.dart';
import 'package:flexedu/features/tests/features/componant/get_more_details.dart';
import 'package:flexedu/features/tests/features/cubit/test_cubit.dart';
import 'package:flexedu/features/tests/features/cubit/test_state.dart';
import 'package:flexedu/features/labs/data/model/get_labs_model.dart';
import 'package:flexedu/features/labs/features/componant/get_labs.dart';
import 'package:flexedu/features/labs/features/componant/labs_get_more_details.dart';
import 'package:flexedu/features/labs/features/cubit/labs_cubit.dart';
import 'package:flexedu/features/labs/features/cubit/labs_state.dart';

class Labs extends StatelessWidget {
  const Labs({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    LabsData? data;
    return BlocConsumer<LabsCubit, LabsState>(
        listener: (context, state) {},
        builder: (context, state) {
          LabsCubit cubit = LabsCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: appbarWidget(
                txt: 'Labs'.tr(),
                onTap: () {
                  scaffoldKey.currentState!.openEndDrawer();
                }),
            endDrawer: AppDrawer(),
            bottomSheet: BottomSheetScreen(),
            body: Stack(
              alignment: Alignment.center,
              children: [
                cubit.labs == null
                    ? Center(child: LoadingWidget())
                    : Container(
                        height: 540.h,
                        child: cubit.labs!.data!.isEmpty
                            ? Center(child: LoadingWidget())
                            : ListView.separated(
                                padding: EdgeInsets.all(12.h),
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  data = cubit.labs!.data![index];
                                  return GetLabs(
                                    data: cubit.labs!.data![index],
                                    cubit: cubit,
                                  );
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 10.h,
                                    ),
                                itemCount: cubit.labs!.data!.length),
                      ),
                if (cubit.isDetails == true)
                  LabsGetMoreDetails(
                    data: data,
                    cubit: cubit,
                  ),
              ],
            ),
          );
        });
  }
}
